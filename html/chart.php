<?php

// Copyright (C) 1999, 2000, 2001 Lars Magne Ingebrigtsen
//
// Chart is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2, or (at your option)
// any later version.
//
// Chart is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Chart; see the file COPYING.  If not, write to the
// Free Software Foundation, Inc., 59 Temple Place - Suite 330,
// Boston, MA 02111-1307, USA.

require('rgb.php');

// The following variables should be edited to fit your 
// installation.

// If debugging is switched on, caching is switched off.
$chart_debug = false;

// The directory where Chart will store cached images. 
// Make sure this exists.
$chart_cache_directory = "/var/tmp/cache";

// The default is to generate PNG images.  If you set
// this to false, GIF images will be generated instead.
$chart_use_png = true;

// If you want to use Type1 fonts, PHP has to be told
// where the IsoLatin1.enc file is.  Such a file is included
// in the Chart distribution.
$type1_font_encoding = "IsoLatin1.enc";

// If your PHP is compiled with gd2, set this variable to true.
$gd2 = false;

function mod ($n, $m) {
  $n1 = (int)($n*1000);
  $m1 = (int)($m*1000);
  return ($n1 % $m1);
}

class chart {
  var $background_color = "white";
  var $x_size, $y_size;
  var $output_x_size = false, $output_y_size;
  var $plots = array();
  var $image;
  var $left_margin = 30, $right_margin = 10, 
    $top_margin = 20, $bottom_margin = 23;
  var $margin_color = "white";
  var $border_color = "black", $border_width = 1;
  var $title_text = array(), $title_where = array(), $title_color = array();
  var $legends = array(), $legend_background_color = "white", 
    $legend_margin = 8, $legend_border_color = "black";
  var $axes = "xy", $axes_color = "black";
  var $grid_color = array(230, 230, 230), $grid_under_plot = 1;
  var $tick_distance = 25;
  var $x_ticks = false, $x_ticks_format;
  var $scale = "linear";
  var $cache = false;
  var $x_label = false, $y_label = false;
  var $font = 2, $font_type = "internal", $font_name = 2, $font_size = 10;
  var $y_min = array(false), $y_max = array(false),
    $x_min = array(false), $x_max = array(false);
  var $frame = false;
  var $expired = false;
  var $marked_grid_point = false, $marked_grid_color = false;
  var $lockfd = -1, $lockfile = 0;
  var $tick_whole_x = false;
  var $months = array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  var $cleanup_after_plotting = true;

  function mark_grid ($point = 0, $color = "red") {
    $this->marked_grid_point = $point;
    $this->marked_grid_color = $color;
  }

  function set_grid_color ($color = false, $grid_under = true) {
      if ($color)
	$this->grid_color = $color;
      $this->grid_under_plot = $grid_under;
  }

  function set_output_size ($width, $height) {
    $this->output_x_size = $width;
    $this->output_y_size = $height;
  }

  function set_expired ($expired) {
    $this->expired = $expired;
  }

  function set_margins ($left = 30, $right = 10, 
			$top = 20, $bottom = 23) {
    $this->left_margin = $left;
    $this->right_margin = $right;
    $this->top_margin = $top;
    $this->bottom_margin = $bottom;
  }

  function set_tick_distance ($distance) {
    $this->tick_distance = $distance;
  }

  function set_labels ($x = false, $y = false) {
    $this->x_label = $x;
    $this->y_label = $y;
  }

  function set_extrema ($y_min = false, $y_max = false,
			$x_min = false, $x_max = false) {
    if ($y_min)
      $this->y_min = $y_min;
    if ($y_max)
      $this->y_max = $y_max;
    if ($x_min)
      $this->x_min = $x_min;
    if ($x_max)
      $this->x_max = $x_max;
  }

  function chart ($x, $y, $cache = false) {
    // error_reporting(1);
    // If this image has already been cached, then we just spew
    // it out and exit.
    if ($cache)
      $this->cache = $cache;
      //$this->get_cache($cache);
    // If not, we initialize this object and allow execution to continue.
    $this->x_size = $x;
    $this->y_size = $y;
  }

  function get_cache ($file) {
    global $chart_debug, $chart_cache_directory, $chart_use_png;
    $file = $chart_cache_directory . "/" . $file;
    // There probably is a security problem hereabouts.  Just
    // transforming all ".."'s into "__" and "//"'s into "/_" will 
    // probably help, though.
    while (ereg("[.][.]", $file)) 
      $file = ereg_replace("[.][.]", "__", $file);
    while (ereg("//", $file)) 
      $file = ereg_replace("//", "/_", $file);
    $this->cache = $file;
    if (! $chart_debug) {
	while (true) {
	    if (file_exists($file)) {
		// The chart is already in the cache, so we just serve
		// it out.
		if ($file = fopen($file, "rb")) {
		    //$this->headers();
		    fpassthru($file);
		    exit;
		} 
	    } else {
		// The idea here is to obtain a lock on the file to be
		// written before starting to write it.  That way we
		// can ensure that no chart is ever generated more
		// than once, which can be very important if the chart
		// is CPU intensive.
		$this->make_directory(dirname($file));
		$this->lockfile = "$file.lock";
		$lockfd = fopen($this->lockfile, "a");
		$tries = 0;
		while (! flock($lockfd, 2+4) && $tries++ < 200) {
		    sleep(1);
		}
		if ($tries >= 200) {
		    // We tried more than 20 seconds, so we delete the
		    // lock file, and try again.
		    fclose($lockfd);
		    unlink($this->lockfile);
		} else {
		    // We got the lock, so we break from the loop and 
		    // return, and generate the chart ourselves.
		    $this->lockfd = $lockfd;
		    break;
		}
	    }
	}
    }
    return false;
  }
  
  function put_cache ($image) {
    global $chart_use_png;
    $file = $this->cache;
    if (file_exists($file))
      unlink($file);
    $this->make_directory(dirname($file));
    // Writing to a tmp file, and then renaming the tmp file to the
    // real file gives us some atomicity on most sensible file systems.
    // That is, the real file will never exist in a half-written state.
    if ($chart_use_png)
      imagepng($image, "$file.tmp");
    else
      imagegif($image, "$file.tmp");
    rename("$file.tmp", "$file");
    imagedestroy($image);
    
    // Remove the lock file.
    if ($this->lockfd != -1) {
	fclose($this->lockfd);
	unlink($this->lockfile);
    }

    if ($file = fopen($file, "rb")) {
      $this->headers();
      fpassthru($file);
      exit;
    } 
    return true;
  }
  
  function make_directory ($file) {
    while (! (file_exists($file))) {
      $dirs[] = $file;
      $file = dirname($file);
    }
    for ($i = sizeof($dirs)-1; $i>=0; $i--) 
      mkdir($dirs[$i], 0777);
  }

  function set_border ($color = "black", $width = 1) {
    $this->border_color = $color;
    $this->border_width = $width;
  }

  function set_background_color ($color, $margin_color = false) {
    $this->background_color = $color;
    if ($margin_color)
      $this->margin_color = $margin_color;
  }

  function set_x_ticks ($ticks, $format = "date") {
    $this->x_ticks = $ticks;
    $this->x_ticks_format = $format;
  }

  function set_frame ($frame = true) {
    $this->frame = $frame;
  }

  function set_font ($font, $type = 0, $size = false) {
    $this->font_name = $font;
    $this->font_type = $type;
    if ($size)
      $this->font_size = $size;
  }

  function set_title ($title, $color = "black", $where = "center") {
    $this->title_text[] = $title;
    $this->title_where[] = $where;
    $this->title_color[] = $color;
  }

  function add_legend($string, $color = "black") {
    $this->legends[] = array($string, $color);
  }

  function set_axes ($which = "xy", $color = "black") {
    $this->axes = $which;
    $this->axes_color = $where;
  }

  function plot ($c1, $c2 = false, $color = false, $style = false,
		 $to_color = false, $param = false,
		 $texts = false) {
    $plot = new plot($c1, $c2);
    if ($color)
      $plot->set_color($color);
    if ($to_color)
      $plot->set_gradient_color($to_color, $param);
    if ($style)
      $plot->set_style($style);
    if ($texts)
      $plot->set_texts($texts);
    if ($param)
      $plot->set_param($param);
    $this->plots[] = &$plot;
    return $plot;
  }

  function splot ($plot) {
    $this->plots[] = &$plot;
  }

  function stroke ($callback = false) {
    global $chart_use_png, $type1_font_encoding;
    $xs = $this->x_size;
    $ys = $this->y_size;

    // Load the font for this chart.
    if ($this->font_type == "type1") {
	$this->font = imagepsloadfont($this->font_name);
	imagepsencodefont($this->font, $type1_font_encoding);
    } elseif ($this->font_type == "ttf") {
	$this->font = imagettfloadfont($this->font_name);
    } else {
	$this->font = $this->font_name;
    }

    if ($xs == 0 || $ys == 0) {
      php3_error(E_ERROR, "Invalid X or Y sizes: (%s, %s)", 
		 $xs, $ys);
    }
    $im = imagecreate($xs, $ys);
    $this->image = $im;
    $bgcolor = $this->allocate_color($this->background_color);
    imagefilledrectangle($im, 0, 0, $xs, $ys, $bgcolor);

    list ($xmin, $xmax) = $this->get_extrema(2);
    list ($ymin, $ymax) = $this->get_extrema(1);
    $grace = ($ymax-$ymin)*0.01;
    $ymin -= $grace;
    $ymax += $grace;

    if (! is_array($this->y_min))
      $ymin = $this->y_min;
    if (! is_array($this->y_max))
      $ymax = $this->y_max;
    if (! is_array($this->x_min))
      $xmin = $this->x_min;
    if (! is_array($this->x_max))
      $xmax = $this->x_max;

    if ($ymax == $ymin) {
      $ymax *= 1.01;
      $ymin *= 0.99;
    }
    if ($xmax == $xmin) 
      $xmax++;
    if ($ymax == $ymin) 
      $ymax++;

    $xoff = $this->left_margin;
    $yoff = $this->top_margin;
    $width = $xs - $this->left_margin - $this->right_margin;
    $height = $ys - $this->top_margin - $this->bottom_margin;

    $axes_color = $this->allocate_color($this->axes_color);

    if ($this->grid_under_plot) {
        // Draw the grid and the axes.
	$this->draw_y_axis($im, $ymin, $ymax, $xs, $ys, $height, $yoff, false,
			   $axes_color);
	$this->draw_x_axis($im, $xmin, $xmax, $xs, $ys, $width, $xoff, false,
			   $axes_color);
    }

    if (! $this->cleanup_after_plotting) {
      $margin = $this->allocate_color($this->margin_color);
      imagefilledrectangle($im, 0, 0, $xs, $this->top_margin-1, $margin);
      imagefilledrectangle($im, $xs-$this->right_margin+1, $this->top_margin-1,
			   $xs, $ys, $margin);
      imagefilledrectangle($im, 0, $ys-$this->bottom_margin+1, $xs, $ys, 
			   $margin);
      imagefilledrectangle($im, 0, 0, $this->left_margin-1, $ys, $margin);
    }
    
    // Go through all the plots and stroke them.
    if ($callback != false) {
      $callback($im, $xmin, $xmax, $ymin, $ymax,
		$xoff, $yoff, $width, $height);
    } else {
      for ($i = 0; $i < sizeof($this->plots); $i++) {
	$plot = $this->plots[$i];
	$plot->stroke($im, $xmin, $xmax, $ymin, $ymax,
		      $xoff, $yoff, $width, $height);
      }
    }

    if (! $this->grid_under_plot) {
        // Draw the grid and the axes.
	$this->draw_y_axis($im, $ymin, $ymax, $xs, $ys, $height, $yoff, false,
			   $axes_color);
	$this->draw_x_axis($im, $xmin, $xmax, $xs, $ys, $width, $xoff, false,
			   $axes_color);
    }

    // The plotting may have plotted outside of the allocated
    // "framed" area (if autoscaling is not in use), so we
    // blank out the surrounding area.
    if ($this->cleanup_after_plotting) {
      $margin = $this->allocate_color($this->margin_color);
      imagefilledrectangle($im, 0, 0, $xs, $this->top_margin-1, $margin);
      imagefilledrectangle($im, $xs-$this->right_margin+1, $this->top_margin-1,
			   $xs, $ys, $margin);
      imagefilledrectangle($im, 0, $ys-$this->bottom_margin+1, $xs, $ys, 
			   $margin);
      imagefilledrectangle($im, 0, 0, $this->left_margin-1, $ys, $margin);
    }
    
    if (! $this->frame) {
      imageline($im, $this->left_margin, $this->top_margin, 
		$this->left_margin, $ys-$this->bottom_margin+3, $axes_color);
      imageline($im, $this->left_margin-3, $ys-$this->bottom_margin,
		$xs-$this->right_margin, $ys-$this->bottom_margin,
		$axes_color);
    } else {
      imagerectangle($im, $this->left_margin, $this->top_margin, 
		     $xs-$this->right_margin, $ys-$this->bottom_margin, 
		     $this->allocate_color($this->border_color));
    }

    // Put the text onto the axes.
    $this->draw_y_axis($im, $ymin, $ymax, $xs, $ys, $height, $yoff, true,
		       $axes_color);
    $this->draw_x_axis($im, $xmin, $xmax, $xs, $ys, $width, $xoff, true,
		       $axes_color);

    $title_color = $this->allocate_color("black");

    // Draw the labels, if any.
    if ($this->y_label) {
      if ($this->font_type == "type1") {
	imagepstext ($im, $this->y_label, $this->font, $this->font_size, 
		     $this->allocate_color($title_color),
		     $this->allocate_color("white"),
		     15, (int)($ys/2+$this->string_pixels($this->y_label)/2),
		     0, 0, 90, 16);
      } else {
	imagestringup($im, $this->font, 5,
		      $ys/2+$this->string_pixels($this->y_label)/2,
		      $this->y_label, $title_color);
      }
    }
    if ($this->x_label) 
      imagestring($im, $this->font,
		  $xs/2-$this->string_pixels($this->x_label)/2,
		  $ys-20, $this->x_label, $title_color);

    // Draw the boorder.
    if ($this->border_color) 
      imagerectangle($im, 0, 0, $xs-1, $ys-1, 
		     $this->allocate_color($this->border_color));

    // Draw the title.
    $tx = "noval";
    for ($i=0; $i<sizeof($this->title_text); $i++) {
      if ($this->font_type == "type1") {
	if ($tx == "noval") {
	  if (!strcmp($this->title_where[$i], "center")) {
	    list ($llx, $lly, $urx, $ury) = imagepsbbox($this->title_text[$i],
							$this->font, 
							$this->font_size);
	    $tx = $xs/2 - ($urx-$llx)/2;
	  } else 
	    $tx = 0;
	}

	imagepstext ($im, $this->title_text[$i], $this->font, 
		     $this->font_size, 
		     $this->allocate_color($this->title_color[$i]),
		     $this->allocate_color("white"),
		     (int)$tx, 15,
		     0, 0, 0, 16);
      } elseif ($this->font_type == "internal") {
	if (!strcmp($this->title_where[$i], "center")) 
	  $tx = $xs/2 - $this->string_pixels($this->title_text[$i])/2;
	else 
	  $tx = 0;
	
	imagestring($im, $this->font, $tx, 5, $this->title_text[$i], 
		    $this->allocate_color($this->title_color[$i]));
      }
    }

    // Draw the legend.
    if (sizeof($this->legends) != 0) {
      $maxlength = 0;
      foreach ($this->legends as $legend) {
	$length = $this->real_string_pixels($legend[0]);
	if ($length > $maxlength)
	  $maxlength = $length;
      }
      $y = (int)($this->top_margin + 20);
      $x = (int)($this->x_size - $this->right_margin - $maxlength - 20);
      $lmargin = $this->legend_margin;
      // Draw a box behind the legend.
      if ($this->legend_background_color) {
	imagefilledrectangle($im, $x-$lmargin, $y-$lmargin,
			     $x+$lmargin+$maxlength, 
			     $y+$lmargin+
			     (($this->font_size+2)*sizeof($this->legends)),
			     $this->allocate_color($this->legend_background_color));
      }
      if ($this->legend_border_color) {
	imagerectangle($im, $x-$lmargin, $y-$lmargin,
		       $x+$lmargin+$maxlength, 
		       $y+$lmargin+
		       (($this->font_size+2)*sizeof($this->legends)),
		       $this->allocate_color($this->legend_border_color));
      }
      
      foreach ($this->legends as $legend) {
	$this->draw_text($legend[0], $legend[1], $x, $y);
	$y += $this->font_size+2;
      }
    }

    // Rescale the image before outputting, if requested.
    if ($this->output_x_size) {
      global $gd2;
      $owidth = $this->output_x_size;
      $oheight = $this->output_x_size;
      $om = imagecreate($owidth, $oheight);
      if ($gd2)
	imagecopyresampled($om, $im, 0, 0, 0, 0,
			   $owidth, $oheight, $xs, $ys);
      else
	imagecopyresized($om, $im, 0, 0, 0, 0,
			 $owidth, $oheight, $xs, $ys);
      $im = $om;
    }

    // This statement usually doesn't return.
    imagepng($im, $this->cache);
    imagedestroy($im);
    return true;
  }

  function headers () {
    global $chart_use_png;
    if ($this->expired) {
      header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
      header("Last-Modified: " . gmdate("D, d M Y H:i:s") . "GMT");
      header("Cache-Control: no-cache, must-revalidate");
      header("Pragma: no-cache");
    }
    if ($chart_use_png)
      header("Content-type: image/png");
    else
      header("Content-type: image/gif");
  }

  function datadatetotime ($datatime) {
    if (ereg ("([0-9]{4})([0-9]{2})([0-9]{2})", $datatime, $regs)) { 
      return mktime (1, 0, 0,
		     $regs[2], $regs[3], $regs[1]);
    }
    return 0;
  }

  function shortnorwegiandate ($time) {
    return date("d.m.y", $time);
  }

  function secondtosecond($s) {
    return substr($s, 0, 2)*60*60+substr($s, 2, 2)*60+substr($s, 4, 2);
  }

  function month_length ($month, $year) {
    $length = $this->months[$month-1];
    // Special rules for February.
    if ($month == 2) {
      if (!($year % 4) && ($year % 100 || !($year % 400)))
	$length = 29;
    }
    return $length;
  }

  function draw_x_axis ($im, $xmin, $xmax, $xs, $ys, $width,
			$xoff, $do_text, $axes_color) {
    $grid_color = $this->allocate_color($this->grid_color);
    $do_tick_texts = false;
    $thinning_factor = 70;
    $even_thin = false;
    $number_unsuitable = 0;
    if (!(strcmp($this->axes, "x")) || !(strcmp($this->axes, "xy"))) {
      if ($this->x_ticks_format == "time") {
	$do_tick_texts = true;
	$thinning_factor = 40;
	$start = $this->secondtosecond($this->x_ticks[0]);
	$end = $this->secondtosecond($this->x_ticks[sizeof($this->x_ticks)-1]);
	$xmax = sizeof($this->x_ticks)-1;
	$xmin = 0;
	$duration = $end-$start;
	$scale = ($xmax-$xmin)/$duration;
	if ($duration < 10*60) {
	  $step = 60;
	} elseif ($duration < 30*60) {
	  $step = 60*5;
	} elseif ($duration < 2*60*60) {
	  $step = 60*10;
	} elseif ($duration < 4*60*60) {
	  $step = 60*30;
	} else {
	  $step = 3600;
	  $this->tick_whole_x = true;
	}

	// If the start/end positions are near "pretty"
	// numbers, then we round up/down.
	if ((! $start%$step) || (($start%$step) / ($end-$start)) > 0.01) 
	  $kstart = $start;
	else
	  $kstart = $start-($start%$step);

	if ((! $end%$step) || ($step-$end%$step) / ($end-$kstart) > 0.01)
	  $kend = $end;
	else
	  $kend = $end-$end%$step+$step;

	// See if we can start at an hour, if possible.
	if ($step == 3600 && $kstart%3600 != 0 && $kstart+3600 < $end)
	  $kstart += 3600-$kstart%3600;

	for ($hour = $kstart; $hour <= $kend; $hour += $step) {
	  $ticks[] = (($hour-$start)*$scale);
	  if ($step == 3600 && $hour%3600 == 0) 
	    $tick_texts[] = (int)($hour/3600);
	  else 
	    $tick_texts[] = sprintf("%02d:%02d", 
				    (int)($hour/3600), ($hour%3600/60));
	}
      } elseif ($this->x_ticks_format == "date") {
	$do_tick_texts = true;
	$thinning_factor = 60;
	$start = $this->datadatetotime($this->x_ticks[0])/(24*60*60);
	$end = $this->datadatetotime($this->x_ticks[sizeof($this->x_ticks)-1])/
	  (24*60*60);
	$duration = $end-$start;
	$gdate = getdate($start*(24*60*60));
	$month = $gdate["mon"];
	$mday = $gdate["mday"];
	$wday = $gdate["wday"]+1;
	$year = $gdate["year"];
	$mlength = $this->month_length($month, $year);
	$first = true;
	for ($i = $start; $i < $end; $i++) {
	  if ($mday == 1) 
	    $firsts[] = $i;
	  if ($mday == 1 || $mday == 15) {
	    if ($first) {
	      $first = false;
	      if ($mday == 15)
		$number_unsuitable = 1;
	    }
	    $mids[] = $i;
	  } if ($wday == 1) 
	    $mondays[] = $i;
	  if ($month == 1 && $mday == 1)
	    $first_januarys[] = $i;
	  if ($mday++ > $mlength-1) {
	    if ($month++ > 12-1) {
	      $month = 1;
	      $year++;
	    }
	    $mlength = $this->month_length($month, $year);
	    $mday = 1;
	  }
	  if ($wday++ > 7-1)
	    $wday = 1;
	}

	$wdformat = false;

	$scale = ($xmax-$xmin)/$duration;
	if ($duration < 24) {
	  for ($i = $start; $i<$end; $i++) 
	    $dates[] = $i;
	} elseif ($duration < 62) {
	  $dates = $mondays;
	  $wdformat = true;
	} elseif ($duration < 31*6) {
	  $dates = $mids;
	  $even_thin = true;
	} elseif ($duration < 365*2) {
	  $dates = $firsts;
	} else {
	  $dates = $first_januarys;
	}

	for ($i = 0; $i<sizeof($dates); $i++) {
	  $ticks[] = (($dates[$i]-$start)*$scale);
	  if (! $wdformat)
	    $tick_texts[] = $this->shortnorwegiandate($dates[$i]*24*60*60);
	  else
	    $tick_texts[] = "Ma " . 
	      $this->shortnorwegiandate($dates[$i]*24*60*60);
	}
      } else {
	$ticks = $this->get_ticks($xmin, $xmax, $ys, $this->tick_whole_x);
      }

      if (! $this->tick_whole_x) {
	if ($do_tick_texts) 
	  $thinning_factor = $this->string_pixels($tick_texts[0]) + 2;

        $step = ceil(sizeof($ticks)*1.0/
	  	     ($width/$thinning_factor));
	if ($step > 1 && $even_thin && $step%2) 
	  $step++;
      } else {
        $step = 1;
      }

      $ticklength = sizeof($ticks);
      for ($i = 0; $i < $ticklength; $i += 1) {
	$x = $ticks[$i];
	$xt = $xoff + ($x - $xmin) / ($xmax - $xmin) * $width;
	if ($do_text) {
	  if ((($i+$number_unsuitable) % $step) == 0) {
	    if ($do_tick_texts) {
	      $text = $tick_texts[$i];
	    } elseif ($this->x_ticks) {
	      if (!strcmp($this->x_ticks_format, "date")) {
		$text = $this->shortnorwegiandate
		  ($this->datadatetotime($this->x_ticks[$x]));
	      } elseif (!strcmp($this->x_ticks_format, "time")) {
		$text = $this->x_ticks["$x"];
	        $text = substr($text, 0, 2) . ":" . substr($text, 2, 2);
	      } elseif (!strcmp($this->x_ticks_format, "ctime")) {
		$dtext = $text = date("m/d", $x);
		if (isset($odtext) && $text != $odtext) 
		  $text .= " " . date("G:i", $x); 
		else 
		  $text= date("G:i", $x);
		$odtext=$dtext;
	      } elseif (!strcmp($this->x_ticks_format, "cdate")) {
		$text= date("m/d", $x);
	      } elseif (!strcmp($this->x_ticks_format, "text")) {
                $text = $this->x_ticks["$x"];
              }

	    } else {
	      // ryan moved this from the block above, since
	      // $this->x_ticks does not need to be 
              // defined for this to work properly
	      if (!strcmp($this->x_ticks_format, "ctime")) {
		$dtext = $text = date("m/d", $x);
		if (isset($odtext) && $text != $odtext) 
		  $text .= " " . date("G:i", $x); 
		else 
		  $text= date("G:i", $x);
		$odtext=$dtext;
	      } elseif (!strcmp($this->x_ticks_format, "cdate")) {
		$text= date("m/d", $x);
	      } elseif (!strcmp($this->x_ticks_format, "text")) {
                $text = $this->x_ticks["$x"];
              } // end of what ryan moved
	      else {
		// this was originally alone in this block
	        $text = $x;
	      }
	    }
	    if ($this->font_type == "type1") {
	      imagepstext($im, $text, $this->font, $this->font_size, 
			  $axes_color,
			  $this->allocate_color("white"),
			  (int)($xt-(strlen($text)*5/2)+0),
			  (int)($ys-$this->bottom_margin+15),
			  0, 0, 0, 16);
	    } elseif ($this->font_type == "internal") {
	      imagestring($im, $this->font, $xt-(strlen($text)*6/2),
			  $ys-$this->bottom_margin+5, $text, $axes_color);
	    }
	    imageline($im, $xt, $ys-$this->bottom_margin, 
		      $xt, $ys-$this->bottom_margin+3, $axes_color);
	  } else {
	    imageline($im, $xt, $ys-$this->bottom_margin, 
		      $xt, $ys-$this->bottom_margin+1, $axes_color);
	  }
	} else {
	  imageline($im, $xt, $this->top_margin, 
		    $xt, $ys-$this->bottom_margin-1, $grid_color);
	}
      }

      for ($x = $this->left_margin; $x < $xs-$this->right_margin; 
	   $x += $this->tick_distance) {
      }
    }      
  }

  function pleasing_numbers ($number, $series = 0, $minimum = 0) {
    $one = 0.01;
    $two = 0.02;
    $five = 0.05;
    while (true) {
      if ($number < $one && ($series == 0 || $series == 1) && $one >= $minimum)
	return array($one, 1);
      $one *= 10;
      if ($number < $two && ($series == 0 || $series == 2) && $two >= $minimum)
	return array($two, 2);
      $two *= 10;
      if ($number < $five && ($series == 0 || $series == 5) &&
	  $five >= $minimum)
	return array($five, 5);
      $five *= 10;
    }
  }

  function draw_text ($string, $color, $x, $y) {
    if ($this->font_type == "type1") {
      imagepstext($this->image, $string, $this->font, $this->font_size, 
		  $this->allocate_color($color),
		  $this->allocate_color($this->background_color),
		  $x, $y+$this->font_size-2, 
		  0, 0, 0, 16);
    } elseif ($this->font_type == "internal") {
      imagestring($this->image, $this->font, $x, $y, $string, 
		  $this->allocate_color($color));
    }
  }

  function draw_y_axis ($im, $ymin, $ymax, $xs, $ys,
			$height, $yoff, $do_text, $axes_color) {
    $grid_color = $this->allocate_color($this->grid_color);
    // Compute the Y axis.
    if (!(strcmp($this->axes, "y")) || !(strcmp($this->axes, "xy"))) {
      $ticks = $this->get_ticks($ymin, $ymax, $height);
      $length = sizeof($ticks);
      $whole = true;
      $ideal = $height/$this->font_size;
      if ($ideal >= $length) {
	$factor = .1;
	$valfactor = .1;
      } else {
	list($factor, $series) =
	  $this->pleasing_numbers(ceil($length/$ideal));
	if ($factor/$length < 2 && false) {
	  if ($series == 5) {
	    $series = 2;
	  } elseif ($series == 2) {
	    $series = 1;
	  } else {
	    $series = 5;
	  }
	  list($factor) = 
	    $this->pleasing_numbers(ceil(sizeof($ticks)/$ideal/2),
				    $series);
	}
	list($valfactor) = $this->pleasing_numbers(($ymax-$ymin)/100, $series);
      }
      
      $spacing = abs($ticks[1] - $ticks[0]);
      for ($i = 0; $i < $length*2; $i++) {
	$y = $ticks[0] + $spacing*$i;
	if (! mod($y, $factor)) {
	  $offset = $i%$factor;
	  break;
	}
      }

      $iy = -1;
      $print_real = false;

      for ($i = 0; $i < $length; $i += 1) {
	$y = $ticks[$i];
	$yt = $yoff + $height - (($y*1.0 - $ymin) / ($ymax - $ymin) * $height);

	if ($do_text) {
	  if ($i >= $offset) 
	    $iy++;

	  if ((! ((int)($iy*100)%($factor*100))) && ($iy != -1)) {

	    if (ceil($spacing*100) == 10 || ceil($spacing*100) == 20)
	      $yst = sprintf("%.1f", $y);
	    else if ($spacing < 1 && ! mod($spacing*10, 1))
	      $yst = sprintf("%.1f", $y);
	    elseif (abs($spacing) < 1) 
	      $yst = sprintf("%.2f", $y);
	    elseif (!($spacing % 1000000)) 
	      $yst = sprintf("%sM",  $y / 1000000);
	    elseif (!($spacing % 1000))
	      $yst = sprintf("%sk",  $y / 1000);
	    elseif (! $whole)
	      $yst = sprintf("%.1f", $y);
	    else 
	      $yst = $y;

	    if (strlen($yst) > 5) 
	      $yst = (int) $yst;

	    if (($y*10)%10)
	      $whole = false;
	    
	    if ($this->font_type == "type1") {
	      list ($llx, $lly, $urx, $ury) = 
		imagepsbbox("$yst", $this->font, $this->font_size);
	      // This is a filter to ween out any single pixel
	      // differences in text width.
	      $ww = ($urx-$llx); 
	      if ($prev_ww != $ww && abs($prev_ww-$ww) < 3)
		$ww = $prev_ww;
	      else
		$prev_ww = $ww;
	      imagepstext ($im, "$yst", $this->font, $this->font_size, 
			   $axes_color,
			   $this->allocate_color("white"),
			   (int)($this->left_margin-6-$ww), 
			   (int)($yt+4), 
			   0, 0, 0, 16);
	    } elseif ($this->font_type == "internal") {
	      imagestring($im, $this->font,
			  $this->left_margin-3-strlen($yst)*6, $yt-7, $yst,
			  $axes_color);
	    }
	    imageline($im, $this->left_margin-3, $yt, 
		      $this->left_margin, $yt, $axes_color);
	  } else {
	    imageline($im, $this->left_margin-1, $yt, 
		      $this->left_margin, $yt, $axes_color);
	  }
	} else {
	  // Draw the grid line.
	  imageline ($im, $this->left_margin+1, $yt, 
		     $xs-$this->right_margin, $yt, $grid_color);
	}
      }

      if (! $do_text && $this->marked_grid_color) {
	$y = $this->marked_grid_point;
	$yt = $yoff + $height - (($y*1.0 - $ymin) / ($ymax - $ymin) * $height);
	imageline ($im, $this->left_margin+1, $yt, 
		   $xs-$this->right_margin, $yt, 
		   $this->allocate_color($this->marked_grid_color));
      }
    }
  }

  function real_string_pixels ($string) {
    if ($this->font_type == "type1") {
      list ($llx, $lly, $urx, $ury) = 
	imagepsbbox($string, $this->font, $this->font_size);
      return $urx-$llx;
    } else
      return strlen($string)*6;
  }


  function string_pixels ($string) {
    if ($this->font_type == "type1")
      return strlen($string)*4.5;
    else
      return strlen($string)*6;
  }

  function get_ticks ($min, $max, $height, $whole = false) {

    $diff = abs($max-$min);
    list ($even) = $this->pleasing_numbers($diff/$height*10);

    if ($whole) 
      $even = 1;

    if ($min < 0) 
      $start = floor($min*100) + $even*100-(floor($min*100)%($even*100))
	- $even*100;
    elseif ($min == 0)
      $start = 0;
    else {
      // This is to work around yet another PHP floating point bug.
      $m = sprintf("%.10f", $min);
      $m = ($m*100);
      $e = ($even*100);
      $start = floor($m + $e-($m%$e));
    }
    for ($elem = $start, $i = 0;
	 $elem < $max*100; $elem += (int) floor($even*100), $i++) {
      $ticks[$i] = $elem/100;
      if ($i > 1000)
	return $ticks;
    }

    return $ticks;
  }

  function get_ticks_old ($min, $max, $whole = false) {

    $diff = abs($max-$min);
    // Compute the "reasonable" distance between the tick marks,
    // independent of the size of the chart.
    if ($diff > 5000) 
      $even = pow(10, floor(log10($diff/2)));
    elseif ($diff > 500) 
      $even = 100;
    elseif ($diff > 50)
      $even = 10;
    elseif ($diff > 25) 
      $even = 2;
    elseif ($diff > 3) 
      $even = 1;
    elseif ($diff > 1) 
      $even = .5;
    elseif ($diff > .2) 
      $even = .2;
    else
      $even = .01;

    if ($whole) 
      $even = 1;

    if ($min < 0) 
      $start = floor($min*100) + $even*100-(floor($min*100)%($even*100))
	- $even*100;
    else {
      // This is to work around yet another PHP floating point bug.
      $m = sprintf("%.10f", $min);
      $m = ($m*100);
      $e = ($even*100);
      $start = floor($m +
		     $e-($m%$e));
    }
    for ($elem = $start, $i = 0;
	 $elem < $max*100; $elem += (int) floor($even*100), $i++) {
      $ticks[$i] = $elem/100;
      if ($i > 1000)
	return $ticks;
    }

    return $ticks;
  }

  function set_scale ($type = "linear") {
    $this->scale = $type;
  }

  function allocate_color($color) {
    return rgb_allocate($this->image, $color);
  }

  function get_extrema ($dim) {
    for ($i = 0; $i < sizeof($this->plots); $i++) {
      $plot = $this->plots[$i];
      if (($plot->style == "fill" || $plot->style == "fillgradient")
	  && $dim == 2)
	list ($mi, $ma) = $plot->get_extrema(3);
      else
	list ($mi, $ma) = $plot->get_extrema($dim);

      if (! isset($max))
	$max = $ma;
      if (! isset($min)) 
	$min = $mi;
      if ($ma > $max)
	$max = $ma;
      if ($mi < $min)
	$min = $mi;

      if (($plot->style == "fill" || $plot->style == "fillgradient")
	  && $dim == 1) {
	list ($mi, $ma) = $plot->get_extrema(2, true);
	if ($ma > $max)
	  $max = $ma;
	if ($mi < $min)
	  $min = $mi;
      }

    }
    return array($min, $max);
  }

}

class plot {
  var $coords;
  var $color = "black", $to_color = false, $param = 0;
  var $style = "lines";
  var $dimension = 1;
  var $texts = false;

  function plot ($c1, $c2) {
    $this->coords[] = $c1;
    $this->coords[] = $c2;
    if ($c2 == 0) {
      $this->dimension = 1;
    } else {
      $this->dimension = 2;
    }
    return true;
  }

  function set_color ($color) {
    $this->color = $color;
    return true;
  }

  function set_texts ($texts) {
    $this->texts = $texts;
    return true;
  }

  function set_gradient_color ($to_color) {
    $this->to_color = $to_color;
  }

  function set_param ($param) {
    $this->param = $param;
  }

  function get_color () {
    return $this->color;
  }

  function set_style ($style) {
    $this->style = $style;
  }

  function set_dimension ($dim) {
    $this->dimension = $dim;
  }

  function get_extrema ($dim, $force_true = false) {
    if ($dim > $this->dimension ||
	(!$force_true && $dim == 2 && ($this->style == "fill" ||
				       $this->style == "fillgradient")))
      return array(0, sizeof($this->coords[0])-1);

    $arr = $this->coords[$dim-1];
    for ($j = 0; $j < sizeof($arr); $j++) {
      if ((! is_string($arr[$j])) || (strcmp($arr[$j], "noplot"))) {
	if (! isset($max))
	  $max = $arr[$j];
	if (! isset($min)) 
	  $min = $arr[$j];
	if ($arr[$j] > $max)
	  $max = $arr[$j];
	if ($arr[$j] < $min)
	  $min = $arr[$j];
      }
    }
    return array($min, $max);
  }

  function stroke ($im, $xmin, $xmax, $ymin, $ymax, $xoff, $yoff,
		   $width, $height) {
    $color = rgb_allocate($im, $this->color);
    $style = $this->style;
    $param = $this->param;
    $ycoords = $this->coords[0];
    $end = sizeof($ycoords);
    if (!strcmp($style, "points"))
      $style = 1;
    elseif (!strcmp($style, "lines"))
      $style = 2;
    elseif (!strcmp($style, "impulse"))
      $style = 3;
    elseif (!strcmp($style, "circle")) {
      $style = 4;
      if ($param)
	$circle_size = $param;
      else
	$circle_size = 10;
    } elseif (!strcmp($style, "cross")) {
      $style = 5;
      if ($param)
	$cross_size = $param/2;
      else
	$cross_size = 5;
    } elseif (!strcmp($style, "fill")) {
      $style = 6;
      $this->dimension = 1;
    } elseif (!strcmp($style, "square"))
      $style = 7;
    elseif (!strcmp($style, "triangle")) {
      if ($this->to_color)
	$dcolor = $this->to_color;
      else
	$dcolor = $this->color;
      $dcolor = rgb_allocate($im, $dcolor);
      $style = 9;
    } elseif (!strcmp($style, "box")) {
      if ($this->to_color)
	$to_color = $this->to_color;
      else
	$to_color = $this->color;
      $tcolors = rgb_allocate_colors
	($im, rgb_gradient_color($this->color, $to_color, 3));
      $style = 10;
    } elseif (!strcmp($style, "gradient") ||
	      !strcmp($style, "fillgradient")) {
	// Calculate the gradient.
      if (!strcmp($style, "gradient"))
	$style = 8;
      else {
	$style = 12;
	$this->dimension = 1;
      }

      $gradient_style = $this->param&1;
      $gradient_updown = $this->param&2;
      $gradient_direction = $this->param&4;
      $gradient_horizontal = $this->param&8;
      if ($gradient_direction == 0) {
	$fcol = rgb_color($this->color);
	$tcol = rgb_color($this->to_color);
      } else {
	$tcol = rgb_color($this->color);
	$fcol = rgb_color($this->to_color);
      }
      // We use at most 220 different colors.
      $numcols = 110;
      
      $rfactor = ($tcol[0]-$fcol[0]) / $numcols;
      $gfactor = ($tcol[1]-$fcol[1]) / $numcols;
      $bfactor = ($tcol[2]-$fcol[2]) / $numcols;

      if ($gradient_horizontal)
	$h = $width+2;
      else
	$h = $height+2;
      $col_factor = $numcols/$h;
      $prev = -1;
      for ($i = 0; $i < $h; $i++) {
	$num = floor($col_factor*($h-$i));
	
	$rnum = floor($fcol[0] + $num * $rfactor);
	$gnum = floor($fcol[1] + $num * $gfactor);
	$bnum = floor($fcol[2] + $num * $bfactor);
	
	if ($num == $prev) {
	  $colors[$i] = $col;
	} else {
	  $col = rgb_allocate($im, sprintf("#%02x%02x%02x", 
					   $rnum, $gnum, $bnum));
	  $colors[$i] = $col;
	}
	$prev = $num;
      }
    } elseif (!strcmp($style, "text")) {
	$style = 11;
        $textnum = 0;
    }

    for ($i = 0; $i < $end; $i++) {
      $y = $ycoords[$i];
      if ((! is_string($y)) || (strcmp($y, "noplot"))) {
	if ($this->dimension == 1) 
	  $x = $i;
	else 
	  $x = $this->coords[1][$i];
	
	$xt = $xoff + ($x - $xmin) / ($xmax - $xmin) * $width;
	$yt = $yoff + $height - (($y*1.0 - $ymin) / ($ymax - $ymin) * $height);
	
	if (! isset($pxt))
	  $pxt = $xt;
	if (! isset($pyt))
	  $pyt = $yt;

	if ($style == 1) 
	  imageline($im, $xt, $yt, $xt, $yt, $color);
	elseif ($style == 2)
	  imageline($im, $pxt, $pyt, $xt, $yt, $color);
	elseif ($style == 3)
	  imageline($im, $xt, $yoff+$height, $xt, $yt, $color);
	elseif ($style == 4)
	  imagearc($im, $xt, $yt, $circle_size, $circle_size, 0, 360, $color);
	elseif ($style == 5) {
	  imageline($im, $xt-$cross_size, $yt-$cross_size,
		    $xt+$cross_size, $yt+$cross_size, $color);
	  imageline($im, $xt+$cross_size, $yt-$cross_size,
		    $xt-$cross_size, $yt+$cross_size, $color);
	} elseif ($style == 6) {
	  // Fill
	    if (! isset($poyt))
	      $poyt = $oyt;
	    $oyt = $yoff + $height - 
	      (($this->coords[1][$i]*1.0 - $ymin) / ($ymax - $ymin) * $height);
	    for ($j = $pxt; $j <= $xt; $j++) 
	      imageline($im, $j, $oyt, $j, $yt, $color);
	    $poyt = $oyt;
	} elseif ($style == 7) {
	  imageline($im, $pxt, $pyt, $pxt, $yt, $color);
	  imageline($im, $pxt, $yt, $xt, $yt, $color);
      } elseif ($style == 8) {
	// gradient
	
	// We plot down from the value to the bottom of the chart.
	// There might be several pixels width of stuff to be plotted,
	// so we first calculate the gradient of the top of the chart
	// between the two points.  So the top of the "gradient"
	// chart will resemble the "lines" chart, not the "square"
	// chart.
	
	if ($xt == $pxt) {
	  $b = 0;
	} else {
	  $b = ($yt - $pyt) / ($xt - $pxt);
	}
	$a = $yt - $b * $xt;
	
	for ($x = $pxt; $x <= $xt; $x++) {
	  $firsty = $a + $b * $x;
	  if ($gradient_updown == 0) {
	    for ($y = $a + $b * $x; $y < $yoff+$height; $y++) {
	      if ($gradient_style && ! $gradient_horizontal)
		$coff = $y-$firsty;
	      elseif (! $gradient_style && ! $gradient_horizontal)
		$coff = $y-$yoff;
	      elseif ($gradient_style && $gradient_horizontal)
		$coff = $x-$firstx;
	      elseif (! $gradient_style && $gradient_horizontal)
		$coff = $x-$xoff;
	      imagesetpixel($im, $x, $y, $colors[$coff]);
	    }
	  } else {
	    for ($y = $a + $b * $x; $y > $yoff; $y--) {
	      if ($gradient_style && ! $gradient_horizontal)
		$coff = $firsty-$y;
	      elseif (! $gradient_style && ! $gradient_horizontal)
		$coff = $y-$yoff;
	      elseif ($gradient_style && $gradient_horizontal)
		$coff = $firstx-$x;
	      elseif (! $gradient_style && $gradient_horizontal)
		$coff = $x-$xoff;
	      imagesetpixel($im, $x, $y, $colors[$coff]);
	    }
	  }
	}
      } elseif ($style == 12) {
	// fillgradient

	if (! isset($poyt))
	  $poyt = $oyt;
	$oyt = $yoff + $height - 
	  (($this->coords[1][$i]*1.0 - $ymin) / ($ymax - $ymin) * $height);
	for ($x = $pxt; $x <= $xt; $x++) {
	  if ($oyt < $yt) {
	    $miny = $oyt;
	    $maxy = $yt;
	  } else {
	    $miny = $yt;
	    $maxy = $oyt;
	  }

	  $firsty = $oyt;
	  if ($gradient_updown == 0) {
	    for ($y = $miny; $y < $maxy; $y++) {
	      if ($gradient_style == 1) {
		imagesetpixel($im, $x, $y, $colors[$y-$firsty]);
	      } else {
		imagesetpixel($im, $x, $y, $colors[$y-$yoff]);
	      }
	    }
	  } else {
	    for ($y = $maxy; $y > $miny; $y--) {
	      if ($gradient_style == 1) {
		imagesetpixel($im, $x, $y, $colors[$firsty-$y]);
	      } else {
		imagesetpixel($im, $x, $y, $colors[$y-$yoff]);
	      }
	    }
	  }
	}
	$poyt = $oyt;

      } elseif ($style == 9) {
	// Triangle
	imageline($im, $xt-3, $yt+3, $xt+3, $yt+3, $dcolor);
	imageline($im, $xt-3, $yt+2, $xt+3, $yt+2, $color);
	imageline($im, $xt-2, $yt+1, $xt+2, $yt+1, $color);
	imageline($im, $xt-2, $yt, $xt+2, $yt, $color);
	imageline($im, $xt-1, $yt-1, $xt+1, $yt-1, $color);
	imageline($im, $xt-1, $yt-2, $xt+1, $yt-2, $color);
	imagesetpixel($im,$xt,$yt-3,$color);
	imagesetpixel($im,$xt,$yt-4,$color);
	imageline($im, $xt+4, $yt+3, $xt+1, $yt-4, $dcolor);
      } elseif ($style == 10) {
	// Box
	imageline($im, $xt-2, $yt-2, $xt+2, $yt-2, $tcolors[0]);
	imageline($im, $xt-2, $yt-1, $xt-2, $yt+2, $tcolors[0]);
	imageline($im, $xt-1, $yt-1, $xt+1, $yt-1, $tcolors[1]);
	imageline($im, $xt-1, $yt  , $xt+1, $yt  , $tcolors[1]);
	imageline($im, $xt-1, $yt+1, $xt+1, $yt+1, $tcolors[1]);
	imageline($im, $xt-1, $yt+2, $xt+2, $yt+2, $tcolors[2]);
	imageline($im, $xt+2, $yt-1, $xt+2, $yt+1, $tcolors[2]);
      } elseif ($style == 11) {
	imagestring($im, $this->font, $xt, $yt, $this->texts[$textnum++],
		    $color);
      }
	
	$pxt = $xt;
	$pyt = $yt;
      }
      
    }
    return($color);
  }


}

?>

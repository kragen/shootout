<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004, 2005

// LIBRARIES ////////////////////////////////////////////////

require_once(BLIB); 


// DATA ////////////////////////////////////////////////////

list($Incl,$Excl) = ReadIncludeExclude();
$Langs = ReadUniqueArrays('lang.csv',$Incl);
$Tests = ReadUniqueArrays('test.csv',$Incl);
uasort($Tests, 'CompareTestName');

if (isset($HTTP_GET_VARS['lang'])){ $L = $HTTP_GET_VARS['lang']; } 
else { $L = 'all'; }

if (isset($HTTP_GET_VARS['lang2'])){ $L2 = $HTTP_GET_VARS['lang2']; } 
else { $L2 = $L; }

if (isset($HTTP_GET_VARS['sort'])){ $S = $HTTP_GET_VARS['sort']; } 
else { $S = 'cpu'; }




// FILTER & SORT DATA ////////////////////////////////////////

$Data = HeadToHeadData(DATA_PATH.'ndata.csv',$Langs,$Incl,$Excl,$L,$L2);

// CHART /////////////////////////////////////////////////////

   $w = 300;
   $w2 = 150;
   $o = 150;   
   $h = 380;
   $hsec = 5;
   $hmem = 1;
   $vscale = CHART_VSCALE;
   $hscale = 15;   
   
   $ts = 2;
   $t = $ts+13;   
   $v1 = $w2/$hscale;
   $b = $h-50;   
   
   $ysec = $t+7;
   $ymem = $t+7 -1;
   $height = 9;


$im = ImageCreate($w,$h);
ImageColorAllocate($im,204,204,204);

$white = ImageColorAllocate($im,255,255,255);
$black = ImageColorAllocate($im,0,0,0);
$bgray = ImageColorAllocate($im,204,204,204);


// TOP GRIDLINES & GRIDLINE LABELS

$gray = ImageColorAllocate($im,221,221,221);

ImageString($im, 2, $o -2, $ts, '1', $white);
ImageString($im, 2, $o-$v1*4 -6, $ts, '5x', $white);
ImageString($im, 2, $o-$v1*9 -8, $ts, '10x', $white);
ImageString($im, 2, $o-$v1*14 -8, $ts, '15x', $white);
ImageString($im, 2, $o+$v1*4 -6, $ts, '5x', $white);
ImageString($im, 2, $o+$v1*9 -8, $ts, '10x', $white);
ImageString($im, 2, $o+$v1*14 -8, $ts, '15x', $white);

ImageLine($im, $o-$v1*14, $t+5, $o+$v1*14, $t+5, $white);
ImageLine($im, $o-$v1*14, $b-5, $o+$v1*14, $b-5, $white);

ImageLine($im, $o, $t, $o, $b, $white);
ImageLine($im, $o-$v1*4, $t, $o-$v1*4, $b, $gray);
ImageLine($im, $o-$v1*9, $t, $o-$v1*9, $b, $gray);
ImageLine($im, $o-$v1*14, $t, $o-$v1*14, $b, $white);
ImageLine($im, $o+$v1*4, $t, $o+$v1*4, $b, $gray);
ImageLine($im, $o+$v1*9, $t, $o+$v1*9, $b, $gray);
ImageLine($im, $o+$v1*14, $t, $o+$v1*14, $b, $white);




// CHART BARS

foreach($Tests as $Row){
   if (isset($Data[$Row[TEST_LINK]])){
      $v = $Data[$Row[TEST_LINK]];             

      if ($v[N_LINES] > 0){
         if ($S=='cpu'){ $wsec = $v[N_CPU]; }
         else { $wsec = $v[N_FULLCPU]; }  
         if ($wsec < 1){ 
            if ($wsec==0){ $wsec = 0.0001; }      
            $wsec = min( (1/$wsec)*$v1, $w2) - $v1; 
            ImageFilledRectangle($im, $o, $ysec, $o+$wsec, $ysec+$hsec, $white);
         }            
         else { 
            $wsec = min( $wsec*$v1, $w2) - $v1;
            ImageFilledRectangle($im, $o-$wsec, $ysec, $o, $ysec+$hsec, $white);
         }

         $wmem = $v[N_MEMORY];
         if ($wmem < 1){ 
            if ($wmem==0){ $wmem = 0.0001; }      
            $wmem = min( (1/$wmem)*$v1, $w2) - $v1; 
            ImageFilledRectangle($im, $o, $ymem, $o+$wmem, $ymem+$hmem, $black);
         }            
         else { 
            $wmem = min( $wmem*$v1, $w2) - $v1;
            ImageFilledRectangle($im, $o-$wmem, $ymem, $o, $ymem+$hmem, $black);
         }                             
      }
   }      

   $ysec = $ysec + $height;
   $ymem = $ymem + $height;   
}


// BOTTOM GRIDLINE LABELS

ImageString($im, 2, $o -2, $b, '1', $white);
ImageString($im, 2, $o-$v1*4 -6, $b, '5x', $white);
ImageString($im, 2, $o-$v1*9 -8, $b, '10x', $white);
ImageString($im, 2, $o-$v1*14 -8, $b, '15x', $white);
ImageString($im, 2, $o+$v1*4 -6, $b, '5x', $white);
ImageString($im, 2, $o+$v1*9 -8, $b, '10x', $white);
ImageString($im, 2, $o+$v1*14 -8, $b, '15x', $white);

// LEGEND 
if (($S=='kb')||($S=='lines')){ $sortname = SortName('cpu'); } 
else { $sortname = SortName($S); }  
ImageFilledRectangle($im, $o-$v1*9, $b+20, $o-$v1*9+8, $b+20+$hmem, $black);
ImageString($im, 2, $o-$v1*9+8+5, $b+13, SortName('kb'), $white);
ImageFilledRectangle($im, $o-$v1*9+80, $b+18, $o-$v1*9+80+8, $b+18+$hsec, $white);
ImageString($im, 2, $o-$v1*9+88+5, $b+13, $sortname, $white);


ImageString($im, 3, $o-$v1*9, $b+32, $Langs[$L][LANG_NAME], $black);
ImageString($im, 3, $o+$v1*4, $b+32, $Langs[$L2][LANG_NAME], $black);


ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im); 
?> 
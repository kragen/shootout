<?php
# $Id: craps_funcs.php,v 1.4 2004-06-22 08:08:16 bfulgham Exp $

require 'langs.inc';

$weight = array(
     'ackermann' => 1,
     'ary' => 3,
     'echo' => 5,
     'except' => 1,
     'fibo' => 2,
     'hash' => 1,
     'hash2' => 4,
     'heapsort' => 4,
     'hello' => 1,
     'lists' => 3,
     'matrix' => 3,
     'methcall' => 5,
     'moments' => 2,
     'nestedloop' => 4,
     'objinst' => 5,
     'prodcons' => 1,
     'random' => 3,
     'regexmatch' => 4,
     'reversefile' => 4,
     'sieve' => 4,
     'spellcheck' => 4,
     'strcat' => 2,
     'sumcol' => 3,
     'wc' => 3,
     'wordfreq' => 5  );


function do_craps($query_string)
{
    global $LANGS, $weight, $base;

    $M2INWT = 0;
    $MAXWT = 5;
    $xloc = 0;
    $xmem = 0;
    $xcpu = 1.0;

    if ($query_string != "")
    {
        $tests = Explode('&', $query_string);

        foreach ($tests as $test)
        {
            list($tn,$w) = preg_split("/=/", $test);
            if ($w > $MAXWT) {
                $w = $MAXWT;
            } elseif ($w < $MINWT) {
                $w = 1;
            }

            if ($tn == 'xloc') {
                $xloc = $w;
            } elseif ($tn == 'xmem') {
                $xmem = $w;
            } elseif ($tn == 'xcpu') {
                $xcpu = $w;
            } else {
                $weight[$tn] = $w;
            }
        }
    }

    $craps_lines = file("$base/.craps.table");

    foreach ($craps_lines as $line_no => $line)
    {
        if (preg_match("/^TITLE/", $line)) {
            list($t, $_test, $_title) = preg_split("/,/", $line);
            $title[$_test] = $_title;
        } elseif (preg_match("/^LANG/", $line)) {
            list($t, $_lang, $_impl, $_missing) = preg_split("/,/", $line);
            $lang[$_impl] = $_lang;
            $missing[$_impl] = $_missing;
        } elseif (preg_match("/^SCORE/", $line)) {
            list($t, $_test, $_impl, $_cpu, $_mem, $_loc) = preg_split("/,/", $line);
            $cpu[$_impl] += $_cpu * $weight[$_test];
            $mem[$_impl] += $_mem * $weight[$_test];
            $loc[$_impl] += $_loc * $weight[$_test];
        } else {
            # error
        }
    }

    echo "<div class=\"h3\"><h3>Patented CRAPS Calculator</h3></div>\n";
    echo "<form METHOD=\"GET\">\n";
    echo "  <div class=\"functnbar\">\n";
    echo "    <input type=\"submit\" value=\"Recalulate Scores\" />";
    echo "    <a href=\"$scriptname\">Reset</a>";
    echo "  </div>\n";
    echo "  <div class=\"axial\">\n";
    echo "    <table border=\"0\" cellspacing=\"2\" cellpadding=\"3\" width=\"100%\">\n";
    echo "      <tr><th>CPU Score Multiplier: <input type=\"text\" name=\"xcpu\" size=\"4\" value=\"$xcpu\" /></th></tr>\n";
    echo "      <tr><th>Memory Score Multiplier: <input type=\"text\" name=\"xmem\" size=\"4\" value=\"$xmem\" /></th></tr>\n";
    echo "      <tr><th>Lines of Code Multiplier: <input type=\"text\" name=\"xloc\" size=\"4\" value=\"$xloc\" /></th></tr>\n";
    echo "      <tr><td>\n";
    echo "        <table border=\"1\" cellspacing=\"2\" cellpadding=\"3\" width=\"100%\">\n";
    echo "          <tr><h4>WEIGHTS</h4></tr>\n";
    echo "          <tr><th>Test</th><th>Weight</th><th>Test</th><th>Weight</th></tr>\n";

    $tests = array_keys($title);
    sort($tests);
    $usea = true;
    $total = count($tests);
    while( count($tests) )
    {
        if ($usea) {
            $ab = "a";
            $usea = false;
        } else {
            $ab = "b";
            $usea = true;
        }
        echo "         <tr class=\"$ab\">\n";
        for ($i=0; $i<2; $i++) {
            if ($test = array_shift($tests)) {
                echo "            <td><a href=\"bench/$test/\">$title[$test]</td><td align=\"center\"><input type=\"text\" name=\"$test\" size=\"2\" value=\"$weight[$test]\"></td>\n";
            } else {
                echo "            <td>&nbsp;</td><td>&nbsp;</td>\n";
            }
        }
        echo "         </tr>\n";
    }

    echo "        </table>\n";
    echo "      </td><td>\n";
    echo "        <table border=\"1\" cellspacing=\"2\" cellpadding=\"3\" width=\"60%\">\n";
    echo "          <tr><h4>SCORES</h4></tr>\n";
    echo "          <tr>\n";
    echo "            <th>Language</th>\n";
    echo "            <th>Implementation</th>\n";
    echo "            <th>Score</th>\n";
    echo "            <th>Missing</th>\n";
    echo "          </tr>\n";

    foreach (array_keys($cpu) as $lang) {
        $score[$lang] = ($cpu[$lang] * $xcpu) + ($mem[$lang] * $xmem) + ($loc[$lang] * $xloc);
    }

    foreach (array_keys($score) as $lang) {
        $ranked[$lang] = $score[$lang];
    }
    array_multisort($score, SORT_ASC, $ranked);
   
    foreach ($ranked as $lang => $score) {
        $lang_type = $LANGS[$lang]['Type'];
        $language = $LANGS[$lang]['Lang'];
        if (preg_match("/native compiled/", $lang_type)) {
            $lt_html = "<b><i>$lang</i></b>";
        } else {
            $lt_html = "$lang";
        }
        $score = floatval($score);
	$score_str = sprintf("%2.04f", $score);
        if ($usea) {
            $ab = "a";
            $usea = false;
        } else {
            $ab = "b";
            $usea = true;
        }
        echo "         <tr class=\"$ab\"><td>$language</td><td><a href=\"lang/$lang/\">$lt_html</a></td><td align=\"right\">$score_str</td><td align=\"right\">$missing[$lang]</td></tr>\n";
    }

    echo "          <tr><td colspan=\"4\"><p class=\"infomark\"><small>Languages that compile to native code are in <i><b>Bold Italics</b></i></small>.</p></td></tr>\n";
    echo "          </td></tr></table>\n";
    echo "    </table>\n";
    echo "  </form>\n";
}

?>

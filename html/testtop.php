<?php require("../../html/header.php");
      require("../../html/nav.php");
      require("../../html/toptabs.php");
      require("../../html/datafuncs.php");
      $current = "testdet";

      toptabs($current);

      require("../../html/testnav.php");

function testtop($title)
{
    echo "<table border=\"0\" cellspacing=\"0\" cellpadding=\"4\" id=\"main\" width=\"100%\">\n";
    echo "  <tr valign=\"top\">\n";

    benchlist("../..");
    nav_list_end();

    echo "    <td>\n";
    echo "      <div id=\"bodycol\">\n";
    echo "        <div class=\"app\" id=\"test\">\n";
    echo "	  <div class=\"h3\"><h3>$title</h3><div>\n";
    echo "	  <table width=\"70%\">\n";
    echo "            <tr>\n";
    echo "              <td>\n";

    incdata();

    echo "              </td>\n";
    echo "              <td>\n";
    echo "                <img src=\"data/max.png\">\n";

    require("../../html/graph_note.php");

    $date = require(".up_date");

    echo "                <p><small>[Results last updated: $date CDT]</small></p>\n";
    echo "              </td>\n";
    echo "            </tr>\n";
    echo "          </table>\n";
    echo "    <p>\n";
    echo "    <hr noshade size=\"5\">\n";
}


<?php require("../../html/header.php");
      require("../../html/nav.php");
      require("../../html/toptabs.php");
      require("../../html/datafuncs.php");
      $current = "testdet";

      toptabs($current);

      require("../../html/testnav.php"); ?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">

<?php benchlist("../..");
      nav_list_end(); ?>

    <td>
      <div id="bodycol">
        <div class="app" id="test">
	  <table width="70%">
            <tr>
              <td>
<?php incdata(); ?>
              </td>
              <td>
                <img src="data/max.png">
<?php require("../../html/graph_note.php"); ?>
                <p><small>[Results last updated: <?php require(".up_date"); ?> CDT]</small></p>
              </td>
            </tr>
          </table>
    <p>
    <hr noshade size="5">


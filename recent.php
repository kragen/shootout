<?php require("html/header.php");
      require("html/toptabs.php");
      $parts = Explode('/', $_SERVER["SCRIPT_NAME"]);
      $current = $parts[count($parts) - 1];

      toptabs($current) ?>

<table border="0" cellspacing="0" cellpadding="4" id="main" width="100%">
  <tr valign="top">
    <td>
      <div id="bodycol">
        <div id="apphead"><h2>Recent Changes</h2></div>
	<div class="app" id="projecthome" >
        <div class="h3" id="intro"><h3>Intro</h3></div>
	<p>This is a short peek into the CVS history log for this project to
	let you know if/what things have changed recently.</p>

	<table border="1" cellspacing="2" cellpadding="4" bgcolor="#c0e0e0" width="100%">
	  <tr>
	    <th bgcolor="black"><font color="white">Date</font></th>
	    <th bgcolor="black"><font color="white">GMT</font></th>
	    <th bgcolor="black"><font color="white">Directory</font></th>
	    <th bgcolor="black"><font color="white">Filename</font></th>
	    <th bgcolor="black"><font color="white">Action</font></th>
          </tr>
	  <?php require("recent.html"); ?>
        </table>
      </div>
    </td>
  </tr>
</table>

<?php require("html/footer.php"); ?>

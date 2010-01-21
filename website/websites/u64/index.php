<?php

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - 

 Title : Sample Landing page for PHP Quick Profiler Class
 Author : Created by Ryan Campbell
 URL : http://particletree.com/features/php-quick-profiler/

 Last Updated : April 22, 2009

 Description : This file contains the basic class shell needed
 to use PQP. In addition, the init() function calls for example
 usages of how PQP can aid debugging. See README file for help
 setting this example up.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

require_once('classes/PhpQuickProfiler.php');
//require_once('classes/MySqlDatabase.php');

class PQPExample {

	private $profiler;
	private $db = '';

	public function __construct() {
		$this->profiler = new PhpQuickProfiler(PhpQuickProfiler::getMicroTime());
	}

	public function init() {
      require_once('compare.php');
	}



	public function __destruct() {
		$this->profiler->display($this->db);
	}

}

$pqp = new PQPExample();
$pqp->init();

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>
PHP Quick Profiler Demo
</title>


<!-- CSS -->

<style type="text/css">
body{
	font-family:"Lucida Grande", Tahoma, Arial, sans-serif;
	margin:100px 0 0 0;
	background:#eee;
}
h3{
	line-height:160%;
}
#box{
	margin:100px auto 0 auto;
	width: 450px;
	padding:10px 20px 30px 20px;
	background-color: #FFF;
	border: 10px solid #dedede;
}
#box ul {
	margin:0 0 20px 0;
	padding:0;
}
#box li {
	margin:0 0 0 20px;
	padding:0 0 10px 0;
}
li a{
	color:blue;
}
strong a{
	color:#7EA411;
}
</style>

<body>

<div id="box">
	<h3>On this Page You Can See How to <br /> Use the PHP Quick Profiler to...</h3>

	<ul>
	<li>Log PHP Objects. [ <a href="#" onclick="changeTab('console'); return false;">Demo</a> ]</li>
	<li>Watch as a string eats up memory. [ <a href="#" onclick="changeTab('memory'); return false;">Demo</a> ]</li>
	<li>Monitor our queries and their indexes. [ <a href="#" onclick="changeTab('queries'); return false;">Demo</a> ]</li>
	<li>Ensure page execution time is acceptable. [ <a href="#" onclick="changeTab('speed'); return false;">Demo</a> ]</li>
	<li>Prevent files from getting out of control. [ <a href="#" onclick="changeTab('files'); return false;">Demo</a> ]</li>
	</ul>
	
	<strong>Return to <a href="http://particletree.com/features/php-quick-profiler/">Particletree</a>.</strong>
</div>

</body>
</html>
<?php

function incdata()
{
	if ($_SERVER['QUERY_STRING'] == "mem")
	{
		require("data/all_mem.html");
	}
	else if ($_SERVER['QUERY_STRING'] == "loc")
	{
		require("data/all_loc.html");
	}
	else if ($_SERVER['QUERY_STRING'] == "cpu-s")
	{
		require("data/all_cpu-s.html");
	}
	else
	{
		require("data/all.html");
	}
}

?>


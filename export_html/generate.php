<?php

if(isset($_GET['uri']))
{
	$uri = $_GET['uri'];
	
	$uri = preg_match("#uri_([^/]*)_([^/]*)#i",$uri,$matches);
	$typ = $matches[1];
	$uri = $matches[2];

	$xh = xslt_create();

	if (xslt_process($xh,"xml/$typ/$uri.xml","xsl/$typ/$typ.xsl","gen/$typ/$uri.xml")) {
		include('template1.php');
		readfile("gen/$typ/$uri.xml");
		include('template2.php');
	} else {
		echo "Error : " . xslt_error($xh) . " and the ";
		echo "error code is " . xslt_errno($xh);
	}
	xslt_free($xh);
}

?>
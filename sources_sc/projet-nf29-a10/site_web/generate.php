<?php include('template1.php');?>

<?php

if(isset($_GET['uri']))
{
	$uri = $_GET['uri'];
	
	$ext = "xml";
	
	$uri = preg_match("#uri_([^/]*)_([^/]*)#i",$uri,$matches);
	$typ = $matches[1];
	$uri = $matches[2];
	
	if($typ=="note")
		$ext = "note";
	
	$xml_filename = "xml/$typ/$uri.$ext";
	$xsl_filename = "xsl/$typ/$typ"."ToHtml.xsl";

	$doc = new DOMDocument();
	$xsl = new XSLTProcessor();

	$doc->load($xsl_filename);
	$xsl->importStyleSheet($doc);

	$doc->load($xml_filename);
	echo $xsl->transformToXML($doc);

}

?>

<?php include('template2.php');?>
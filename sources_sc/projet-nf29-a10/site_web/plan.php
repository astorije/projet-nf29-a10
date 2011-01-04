<?php include('template1.php');?>

<?php

	if(isset($_GET['id']))
	{
		
		$id = $_GET['id'];
		
		$xml_filename = "xml/plan/$id";
		$xsl_filename = "xsl/plan/planToHtml.xsl";
	
		$doc = new DOMDocument();
		$xsl = new XSLTProcessor();

		$doc->load($xsl_filename);
		$xsl->importStyleSheet($doc);

		$doc->load($xml_filename);
		echo $xsl->transformToXML($doc);

	}

?>

<?php include('template2.php');?>

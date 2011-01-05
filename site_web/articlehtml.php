<?php include('template1.php');?>

<?php

	if(isset($_GET['id']))
	{
		
		$id = $_GET['id'];
		
		$xml_filename = "xml/article/$id";
		$xsl_filename = "xsl/article/module1.xsl";
	
		$doc = new DOMDocument("<root>");
		$xsl = new XSLTProcessor("<root>");

		$doc->load($xsl_filename);
		$xsl->importStyleSheet($doc);

		$doc->load($xml_filename);
		echo $xsl->transformToXML($doc);

		/*// Allocate a new XSLT processor
		$xh = xslt_create();

		// Process the document
		if (xslt_process($xh, "xml/article/$id", "xsl/article/article.xsl", "gen/article/$id.xml")) {
			readfile("gen/article/$id.xml");
		} else {
			echo "Error : " . xslt_error($xh) . " and the ";
			echo "error code is " . xslt_errno($xh);
		}

		xslt_free($xh);*/
		
		
	}

?>

<?php include('template2.php');?>

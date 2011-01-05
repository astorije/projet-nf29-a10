<?php include('template1.php');?>

<?php

	if(isset($_GET['id']))
	{
		// Allocate a new XSLT processor
		$xh = xslt_create();

		// Process the document
		if (xslt_process($xh, "xml/parcours/$id", "xsl/parcours/parcours.xsl", "gen/parcours/$id.xml")) {
			readfile("gen/parcours/$id.xml");
		} else {
			echo "Error : " . xslt_error($xh) . " and the ";
			echo "error code is " . xslt_errno($xh);
		}

		xslt_free($xh);
	}

?>

<?php include('template2.php');?>

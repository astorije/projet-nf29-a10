<?php include('template1.php');?>

<?php

	if(isset($_GET['id']))
	{
		// Allocate a new XSLT processor
		$xh = xslt_create();

		// Process the document
		if (xslt_process($xh, "xml/plan/$id", "xsl/plan/plan.xsl", "gen/plan/$id.xml")) {
			readfile("gen/plan/plan.xml");
		} else {
			echo "Error : " . xslt_error($xh) . " and the ";
			echo "error code is " . xslt_errno($xh);
		}

		xslt_free($xh);
	}

?>

<?php include('template2.php');?>

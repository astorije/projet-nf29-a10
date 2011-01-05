<?php

	if(isset($_GET['id']))
	{
		// Allocate a new XSLT processor
		$xh = xslt_create();

		// Process the document
		if (xslt_process($xh, "xml/exercice/$id", "xsl/exercice/exercice.xsl", "gen/exercice/$id.xml")) {
			readfile("gen/exercice/$id.xml");
		} else {
			echo "Error : " . xslt_error($xh) . " and the ";
			echo "error code is " . xslt_errno($xh);
		}

		xslt_free($xh);
	}

?>
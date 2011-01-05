<?php

	if(isset($_GET['id']))
	{
		// Allocate a new XSLT processor
		$xh = xslt_create();

		// Process the document
		if (xslt_process($xh, "xml/article/$id", "xsl/article/article.xsl", "gen/article/$id.xml")) {
			readfile("gen/article/$id.xml");
		} else {
			echo "Error : " . xslt_error($xh) . " and the ";
			echo "error code is " . xslt_errno($xh);
		}

		xslt_free($xh);
	}

?>
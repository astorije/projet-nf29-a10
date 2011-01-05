<?php

	if(isset($_GET['id']))
	{
		// Allocate a new XSLT processor
		$xh = xslt_create();

		// Process the document
		if (xslt_process($xh, "xml/audio/$id", "xsl/audio/audio.xsl", "gen/audio/$id.xml")) {
			readfile("gen/audio/$id.xml");
		} else {
			echo "Error : " . xslt_error($xh) . " and the ";
			echo "error code is " . xslt_errno($xh);
		}

		xslt_free($xh);
	}

?>
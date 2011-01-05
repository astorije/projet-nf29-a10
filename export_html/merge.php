<?php

// Allocate a new XSLT processor
$xh = xslt_create();

// Process the document
if (xslt_process($xh, 'xml/merge.xml', 'xsl/merge.xslt', 'res_merge.xml')) {
    echo "SUCCESS!";
    readfile('res_merge.xml');
} else {
    echo "Echec : " . xslt_error($xh) . " and the ";
    echo "error code is " . xslt_errno($xh);
}

xslt_free($xh);

?>
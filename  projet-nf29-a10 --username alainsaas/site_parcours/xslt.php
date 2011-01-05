<?php

/* Allocation du processeur XSLT */
$xh = xslt_create();
$input = 'plan.xml';
$xslt = 'plan.xsl';
$output = 'plan.php';
$template1 = '<?php include(\'template1.php\');?>';
$template2 = '<?php include(\'template2.php\');?>';

/* Traitement du document */
if (xslt_process($xh, 'xml/'.$input, 'xsl/'.$xslt, $output)) {
    echo "Réussi!!!!!";
	$fp = fopen($output,'r+');
	$contents = file_get_contents($output);
	fputs($fp,$template1.$contents.$template2);
	fclose($fp);
    readfile('plan.php');
} else {
    echo "Echec : " . xslt_error($xh) . " et ";
    echo " le code d'erreur est " . xslt_errno($xh);
}
xslt_free($xh);

?>
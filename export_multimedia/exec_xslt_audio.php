<?php

$input = 'cours_audio.xml';
$xslt = 'cours_audio.xsl';
$output = 'cours_audio.html';

$procXSL = new XSLTProcessor();
// Chargement du document XML
$xml = new DOMDocument;
$xml->load('xslt/'.$input);

// Chargement de la feuille de style
$xsl = new DOMDocument;
$xsl->load('xslt/'.$xslt);

// Création du processeur XSLT
$proc = new XSLTProcessor;

//Affectation de la feuille de style
$proc->importStyleSheet($xsl);

// Transformation du document XML selon la feuille XSL
$proc->transformToURI($xml, "./".$output);
/*
$result = $proc->transformToXML($xml);
echo $result;
fwrite($html,$result);
*/
?>
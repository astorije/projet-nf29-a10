<?php

$xslt = 'cours_audio.xsl';

if($_GET['in'] != null) $input = $_GET['in'];
else $input = 'cours_audio.xml';

if($_GET['out'] != null) $output = $_GET['out'];
else $output = 'cours_audio.html';

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
if($proc != FALSE) echo "transformation réussie.";

?>
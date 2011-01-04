<?php

	$profondeur = 0;
	$str = "";

	function startElement($parser, $name, $attrs) 
	{
		global $str;
		global $profondeur;
		if($name == 'UL')
			$profondeur++;
		
		if($name == 'LI')
		{
			for($i=0;$i<$profondeur;$i++)
				$str.= '	';
			if($profondeur == 1)
				$str.= "<pl:partie_plan";
			else if($profondeur == 2)
				$str.= "<pl:sous_partie_plan";
			else if($profondeur == 3)
				$str.= "<pl:sous_sous_partie_plan";
		}
	}

	function endElement($parser, $name) 
	{
		global $str;
		global $profondeur;
		if($name == 'UL')
		{	
			for($i=0;$i<$profondeur;$i++)
				$str.= '	';
			if($profondeur == 1)
				$str.= "</pl:partie_plan>\n";
			else if($profondeur == 2)
				$str.= "</pl:sous_partie_plan>\n";
			else if($profondeur == 3)
				$str.= "</pl:sous_sous_partie_plan>\n";
				
			$profondeur--;
		}
	}

	function characters($parser, $data)
	{
		global $str;
		global $profondeur;
		$str.= ' titre="' . $data . "\">\n";
	}

	//$filename = 'tmp/plan.xml';

	$input = fopen('zip://' . dirname(__FILE__) . '/' . $filename . '#content.xml','r');
	$output = fopen($filename,'w');

	while (($buffer = fgets($input)) != FALSE) 
	{
		fputs($output,$buffer);	
	}

	fclose($input);
	fclose($output);
	
	$xml_filename = $filename;
	$xsl_filename = "xsl/outil/content.xsl";

	$doc = new DOMDocument();
	$xsl = new XSLTProcessor();

	$doc->load($xsl_filename);
	$xsl->importStyleSheet($doc);

	$doc->load($xml_filename);
	$res = $xsl->transformToXML($doc);
	
	$output = fopen($filename,'w');
	fputs($output,$res);
	fclose($output);
	
	if (!($fp = fopen($filename, "r"))) {
		die("could not open XML input");
	}
	
	$xml_parser = xml_parser_create(); 
	xml_set_element_handler($xml_parser, "startElement", "endElement"); 
	xml_set_character_data_handler($xml_parser, "characters");
	
	
	while ($data = fread($fp, 4096)) {
		if (!xml_parse($xml_parser, $data, feof($fp))) {
			die(sprintf("XML error: %s at line %d",
						xml_error_string(xml_get_error_code($xml_parser)),
						xml_get_current_line_number($xml_parser)));
		}
	}
	
	xml_parser_free($xml_parser); 
	
	fclose($fp);
	
	$name = str_replace('.odt','',str_replace('tmp/','',$filename));
	
	$fp = fopen(str_replace('tmp/','xml/plan/',$filename),'w');
	fputs($fp,"<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	fputs($fp,"<pl:plan xmlns:pl=\"utc.fr/nf29/pr/plan\" uri=\"uri_plan_$name\" auteur=\"\" titre=\"$name\">\n");
	fputs($fp,$str);
	fputs($fp,"</pl:plan>\n");

?>
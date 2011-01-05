<?php

$file = "note.xml";
$depth = array();
$balise = "";
$tags_se = array();
array_push($tags_se,'TITRE');
array_push($tags_se,'PARAGRAPHE');
array_push($tags_se,'IMAGE');
array_push($tags_se,'URL');
array_push($tags_se,'DESCRIPTION');
array_push($tags_se,'LIST');
array_push($tags_se,'PUCE1');
array_push($tags_se,'PUCE2');
$tags = array();
array_push($tags,'TITRE');
array_push($tags,'PARAGRAPHE');
array_push($tags,'URL');
array_push($tags,'DESCRIPTION');

function startElement($parser, $name, $attrs) 
{
	global $balise;
	global $tags_se;
	$balise = $name;
    // global $depth;
    // for ($i = 0; $i < $depth[$parser]; $i++) {
        // echo "  ";
    // }
	if(in_array($balise,$tags_se))
		echo "<$balise>\n";
    // $depth[$parser]++;
}

function endElement($parser, $name) 
{
    // global $depth;
	global $balise;
	global $tags_se;
	$balise = $name;
	if(in_array($balise,$tags_se))
		echo "</$balise>\n";
    // $depth[$parser]--;
	$balise = "";
}

function characters($parser, $data_text)
{
	global $balise;
	global $tags;
	if(in_array($balise,$tags))
		echo "$data_text\n";
}

$xml_parser = xml_parser_create();
xml_set_element_handler($xml_parser, "startElement", "endElement");
xml_set_character_data_handler($xml_parser, "characters");

if (!($fp = fopen($file, "r"))) {
    die("could not open XML input");
}

while ($data = fread($fp, 4096)) {
    if (!xml_parse($xml_parser, $data, feof($fp))) {
        die(sprintf("XML error: %s at line %d",
                    xml_error_string(xml_get_error_code($xml_parser)),
                    xml_get_current_line_number($xml_parser)));
    }
}
xml_parser_free($xml_parser);

?>

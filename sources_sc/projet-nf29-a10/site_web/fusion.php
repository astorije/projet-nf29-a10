<?php include('template1.php');?>

<?php

	if(isset($_GET['plan']) and isset($_GET['partie']))
	{
		$tmp = strtolower($_GET['plan']);
		
		$plan = "xml/plan/$tmp".".xml";
		$partie = $_GET['partie'];
		
		$notes = array();
	
		function match_partie($line,$part)
		{
			$res = false;
			if(preg_match('#<(pl:partie_plan|pl:sous_partie_plan|pl:sous_sous_partie_plan) titre="'.$part.'" uri="([^/]*)">#i',$line))
				$res = true;
			return $res;
		}
		
		function is_note($line)
		{
			$res = false;
			if(preg_match('#<pl:ref_note uri="([^/]*)" titre="([^/]*)"/>#i',$line))
				$res = true;
			return $res;
		}
	
		function extract_note($line)
		{
			$res = '';
			if(preg_match('#<pl:ref_note uri="([^/]*)" titre="([^/]*)"/>#i',$line,$matches))
				$res = $matches[2];
			return $res;
		}
		
		function extract_text($tag,$line)
		{
			$res = '';
			if(preg_match("#<pl:$tag>([^/]*)</pl:$tag>#i",$line,$matches))
				$res = $matches[1];
			return $res;
		}
		
		function match_tag($tag,$line)
		{
			if(preg_match("#</?pl:$tag([^/]*)>(([^/]+)</pl:$tag>)?#i",$line))
				return true;
			return false;
		}
		
		function isComment($line)
		{
			if(preg_match("#<\?([^/]*)\?>#i",$line))
				return true;
			return false;
		}

		$fd = fopen($plan,'r');

		//PARSING XML
		while(!feof($fd))
		{
			$line = fgets($fd);
			if(match_partie($line,$partie))
			{
				$line = fgets($fd);
				while(is_note($line)){
					array_push($notes,extract_note($line));
					$line = fgets($fd);
				}
			}
		}
		
		if(sizeof($notes)>0)
		{
			//FUSION
			$titre = 'compilation_'.$notes[0];
			$fdc = fopen('xml/note/'.$titre.'.note','w');
			$cpt = 0;
			fputs($fdc,"<note uri=\"uri_note_".$titre."\">\n");
			foreach($notes as $file)
			{
				$fd = fopen('xml/note/'.$file.'.note','r');
				
				while(!feof($fd))
				{
					$line1 = fgets($fd);
					
					if($cpt==0)
					{
						if(match_tag('titre',$line1))
							fputs($fdc,"<titre>".extract_text('titre',$line1)." [Compilation]</titre>\n");
						else
						{
							if(!match_tag('note',$line1) and !match_tag('meta_note',$line1) and !match_tag('statut',$line1)
							and !match_tag('date_creation',$line1) and !match_tag('date_modification',$line1) 
							and !match_tag('auteur',$line1) and !match_tag('contributeurs',$line1) 
							and !match_tag('contributeur',$line1) and !match_tag('relecteur',$line1)
							and !match_tag('nom',$line1) and !match_tag('prenom',$line1)
							and !isComment($line1))
								fputs($fdc,$line1);
						}
					}
					else
					{
						if(!match_tag('note',$line1) and !match_tag('meta_note',$line1) and !match_tag('statut',$line1)
						and !match_tag('date_creation',$line1) and !match_tag('date_modification',$line1) 
						and !match_tag('auteur',$line1) and !match_tag('contributeurs',$line1) 
						and !match_tag('contributeur',$line1) and !match_tag('relecteur',$line1)
						and !match_tag('nom',$line1) and !match_tag('prenom',$line1)
						and !match_tag('titre',$line1) and !isComment($line1))
							fputs($fdc,$line1);
					}
				}
				$cpt++;
			}
			fputs($fdc,'</note>');
			
			$xml_filename = "xml/note/$titre.note";
			$xsl_filename = "xsl/note/noteToHtml.xsl";

			$doc = new DOMDocument();
			$xsl = new XSLTProcessor();

			$doc->load($xsl_filename);
			$xsl->importStyleSheet($doc);

			$doc->load($xml_filename);
			echo $xsl->transformToXML($doc);
		}
		else
		{
			echo "<br/><br/><br/><br/><br/>";
			echo "Fusion impossible au sein de parties vides.";
		}
	}

?>

<?php include('template2.php');?>
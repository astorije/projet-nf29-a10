<?php

	if(isset($_GET['plan']) and isset($_GET['partie']))
	{
		$tmp = $_GET['plan'];
		
		$plan = "xml/plan/$tmp".".xml";
		$partie = $_GET['partie'];
		
		$notes = array();
	
		function match_partie($line,$part)
		{
			$res = false;
			if(preg_match('#<(partie_plan|sous_partie_plan|sous_sous_partie_plan) titre="'.$part.'">#i',$line))
				$res = true;
			return $res;
		}
		
		function is_note($line)
		{
			$res = false;
			if(preg_match('#<ref_note uri="([^/]*)" titre="([^/]*)"/>#i',$line))
				$res = true;
			return $res;
		}
	
		function extract_note($line)
		{
			$res = '';
			if(preg_match('#<ref_note uri="([^/]*)" titre="([^/]*)"/>#i',$line,$matches))
				$res = $matches[2];
			return $res;
		}
		
		function extract_text($tag,$line)
		{
			$res = '';
			if(preg_match("#<$tag>([^/]*)</$tag>#i",$line,$matches))
				$res = $matches[1];
			return $res;
		}
		
		function match_tag($tag,$line)
		{
			if(preg_match("#</?$tag([^/]*)>(([^/]+)</$tag>)?#i",$line))
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
		
		//FUSION
		$titre = 'compilation_'.$notes[0];
		$fdc = fopen('xml/note/'.$titre.'.xml','w');
		$cpt = 0;
		fputs($fdc,"<note uri=\"uri_note_".$titre."\">\n");
		foreach($notes as $file)
		{
			$fd = fopen('xml/note/'.$file.'.xml','r');
			
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
		
		$xh = xslt_create();

		if (xslt_process($xh,"xml/note/$titre.xml","xsl/note/note.xsl","gen/note/$titre.xml")) {
			include('template1.php');
			readfile("gen/note/$titre.xml");
			include('template2.php');
		} else {
			echo "Error : " . xslt_error($xh) . " and the ";
			echo "error code is " . xslt_errno($xh);
		}
		xslt_free($xh);
		
	}

?>
<?php include('template1.php');?>

<?php
	//header('Location: http://localhost:8080/nf29tris/test?fileName=note1.xml');

	if(isset($_GET['uri']))
	{
		$url = explode("_",$_GET['uri']);
		header('Location: http://localhost:8080/wikiutc/pdf?fileName=xml/'.$url[1].'/'.$url[2].'.note');
	}
	
	if(isset($_GET['id']))
	{
		if(isset($_GET['gen']))
		{
			header('Location: http://localhost:8080/wikiutc/pdf?fileName='.$_GET['id'].'');
			

		}
		else
		{
			$tmp = strtolower($_GET['id']);
			
			$plan = "xml/plan/$tmp";
			//$partie = $_GET['partie'];
			
			$notes = array();
		
			function match_partie($line,$part)
			{
				$res = false;
				if(preg_match('#<(pl:partie_plan|pl:sous_partie_plan|pl:sous_sous_partie_plan) titre="'.$part.'" uri="([^/]*)">#i',$line))
					$res = true;
				return $res;
			}
			
			function is_note($line) //Récupération de la note et le titre du plan pour la génération du plan en PDF
			{
				$res = false;
				if(preg_match('#<pl:ref_note uri="([^/]*)" titre="([^/]*)"/>#i',$line))
					$res = true;
				return $res;
			}
			
			function is_partie($line)
			{
				$res = false;
				if(preg_match('#<pl:partie_plan|pl:sous_partie_plan|pl:sous_sous_partie_plan  titre="([^/]*)" uri="([^/]*)">#i',$line))
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
			
			function extract_titre_partie($line)
			{
				$res = '';
				if(preg_match('#(<pl:partie_plan|pl:sous_partie_plan|pl:sous_sous_partie_plan) titre="([^/]*)" uri="([^/]*)">#i',$line,$matches))
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
			$i = -1;
			while(!feof($fd))
			{
	//			$line = fgets($fd);
	//			if(match_partie($line,$partie))
	//			{
					$line = fgets($fd);
					//echo "ligne lue".$line."<br>";	
					
					if(is_partie($line))
					{
						//array_push($parties,extract_titre_partie($line));
						
						$notes = array();
						$i++;
						$parties[$i]['titre'] = extract_titre_partie($line);
						
						//echo "titre récupéré".extract_titre_partie($line)."<br>";
						
					}
					elseif(is_note($line))
					{
						array_push($notes,extract_note($line));
						$parties[$i]['notes'] = $notes;
						//echo "note récupérée".extract_note($line)."<br>";
					}
	//			}
			}
			
			//FUSION
			$titre = 'compilation';
			$fdc = fopen('xml/note/'.$titre.'.note','w');
			$cpt = 0;
			fputs($fdc,"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n
			<?xml-stylesheet type=\"text/css\" href=\"style.css\" media=\"all\"?>\n
			<note uri=\"uri_note_".$titre."\">\n");
			foreach($parties as $partie)
			{
				fputs($fdc,"<partie>");
				fputs($fdc,"<titrepartie>".$partie['titre']."</titrepartie>");
				// echo "<pre>";
				// print_r($partie);
				// echo "</pre>";
				if($partie['notes'])
				{
					foreach($partie['notes'] as $file)
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
				}
				fputs($fdc,'</partie>');
			}

			fputs($fdc,'</note>');
			$xml_filename = "xml/note/$titre.note";
			header('Location: http://localhost/wikiutc/pdf.php?id='.$xml_filename.'&gen=1');
		}
	}

?>

<?php include('template2.php');?>

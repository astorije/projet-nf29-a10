
<?php include('template1.php');?>

<?php
        //header('Location: http://localhost:8080/nf29tris/test?fileName=note1.xml');

        if(isset($_GET['uri']))
        {
                $url = explode("_",$_GET['uri']);
                header('Location: http://localhost:4040/wikiutc/pdf?fileName=xml/'.$url[1].'/'.$url[2].'.xml');
        }
       
        if(isset($_GET['id']))
        {
                if(isset($_GET['gen']))
                {
                        header('Location: http://localhost:4040/wikiutc/pdf?fileName='.$_GET['id'].'');
                }
                else
                {
                        $tmp = strtolower($_GET['id']);
                       
                        $article = "xml/article/$tmp";
                        //$partie = $_GET['partie'];
                       
                        $note = array();
						
						function is_article($line) //Récupération de la note et le titre du plan pour la génération du plan en PDF
                        {
                                $res = false;
                                if(preg_match('#<article([^>]*)>#i',$line))
                                        $res = true;
                                return $res;
                        }
                       
					   function is_article_end($line) //Récupération de la note et le titre du plan pour la génération du plan en PDF
                        {
                                $res = false;
                                if(preg_match('#</article([^>]*)>#i',$line))
                                        $res = true;
                                return $res;
                        }
                       
                        function is_note($line) //Récupération de la note et le titre du plan pour la génération du plan en PDF
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
                                    $res = $matches[1];
                                return $res;
                        }
                       
					    function match_tag($tag,$line)
                        {
                                if(preg_match("#</?$tag([^/]*)>(([^/]+)</$tag>)?#i",$line))
                                        return true;
                                return false;
                        }

                        $fd = fopen($article,'r');
						$titre = 'compilation';
						$fdc = fopen('xml/article/'.$titre.'.xml','w');
                        //PARSING XML
                        $i = 0;
                        while(!feof($fd))
                        {
							$line = fgets($fd);
							
							if(is_note($line))
							{
									$note=extract_note($line);
									$notes[$i] = $note;
									$i++;
									/*$temoin=extract_note($line);
									array_push($note,$temoin)
									/*echo "Hello Maxime la réponse est là" . $temoin;
									fputs($fdc,$line);*/
							}
							elseif(is_article($line)) fputs($fdc,"<?xml-stylesheet type=\"text/css\" href=\"style.css\" media=\"all\"?>\n<article>\n");
							elseif(is_article_end($line)) ;
							else fputs($fdc,$line);
                        }
                       
                        //FUSION
                        
                        
                        //print_r($notes);
                        foreach($notes as $file)
                        {
                                $fdn = fopen('xml/note/'.$file.'.note','r');
								$cpt = 0;
								while(!feof($fdn))
								{
									$line1 = fgets($fdn);
									if($cpt==0);
									else{
										if(match_tag('titre',$line1)) fputs($fdc,$line1);
										else
										{
												if(!match_tag('note',$line1) and !match_tag('meta_note',$line1) and !match_tag('statut',$line1)
												and !match_tag('date_creation',$line1) and !match_tag('date_modification',$line1)
												and !match_tag('auteur',$line1) and !match_tag('contributeurs',$line1)
												and !match_tag('contributeur',$line1) and !match_tag('relecteur',$line1)
												and !match_tag('nom',$line1) and !match_tag('prenom',$line1))
														fputs($fdc,$line1);
										}
									}
									$cpt++;
								}
								
                                fputs($fdc,"</note>");
                        }

                        fputs($fdc,'</article>');
                        $xml_filename = "xml/article/$titre.xml";
						//echo $xml_filename;
                        header('Location: http://localhost/wikiutc/article.php?id='.$xml_filename.'&gen=1');
                }
        }

?>

<?php include('template2.php');?>


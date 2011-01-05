<?php

 
 $fileOut="tmp/pdf/docpublication.xml";

 $fileIn="xml/publication/publication.xml";
 
 

function writeInfile($chaine){
 global $fileOut;
 
	$fp = fopen($fileOut,"a+"); // ouverture du fichier en écriture	
	fputs($fp,$chaine); // on écrit le nom et email dans le fichier
	fclose($fp);
}

function writeEmpty(){

 global $fileOut;
	$fp = fopen($fileOut,"w"); // ouverture du fichier en écriture	
	fclose($fp);

}

function launch(){
 global $fileIn;
loadnewfile($fileIn);
goPdf();
}

function goPdf(){
global $fileOut;
 header('Location: http://localhost:4040/wikiutc/pdf?fileName='.$fileOut);
}


 $entete="<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n<?xml-stylesheet media='all' href='style.css' type='text/css'?>\n";


 if(isset($_GET['id']))
	{
		global $fileIn;
		$fileIn=$_GET['id'];
		
		writeEmpty();
		writeInfile($entete);
		launch();
		
		
	}



function loadnewfile($fileIns){

/*Ouverture du fichier en lecture seule*/
	$handle = fopen( $fileIns, 'r');
	/*Si on a réussi à ouvrir le fichier*/
	if ($handle)
	{
		/*Tant que l'on est pas à la fin du fichier*/
		while (!feof($handle))
		{
			/*On lit la ligne courante*/
			$buffer = fgets($handle);
			/*On l'affiche*/
			/**
			*recupere les entetes et les écrits dans un fichier
			**/
			if(preg_match('`<\?`i', $buffer)){
			
			}else{
				//determination des uri de parcours
				
				if(preg_match('#<ref_parcours>([^/]*)</ref_parcours>#i', $buffer,$matches)){
				
				  loadnewfile("xml/parcours/".$matches[1]);
				}
				if(preg_match('#<uri>([^/]*)</uri>#i', $buffer,$matches)){
						$ty=$matches[1];
					if(preg_match('`article`i',$ty ,$matche)){
					  loadnewfile("xml/article/".$ty);
					}
					if(preg_match('`exercice`i', $ty,$matche)){
					  loadnewfile("xml/exercice/".$ty);
					}
					if(preg_match('`audio`i', $ty,$matche)){
					  loadnewfile("xml/cours/".$ty);
					}
				}
				
				else{			
				writeInfile(iconv("UTF-8", "ISO-8859-1",$buffer));
				}
			}
			
			//echo $buffer;
		}
		/*On ferme le fichier*/
		fclose($handle);
	}
	
	
}



?>
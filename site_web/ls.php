<?php

	if(isset($_GET['id']))
	{
		$id = $_GET['id'];

		include('template1.php');
		
		echo '<br/><br/><br/>';

		
		if ($handle = opendir("xml/$id/")) 
		{
			while (false !== ($file = readdir($handle))) 
			{
				if ($file != "." && $file != "..") 
				{
					echo "<a href=\"$id.php?id=$file\">$file</a><a href=\"$id.php?id=$file\" target=\"_blank\"><img src=\"images/pdf.gif\" /></a><br/>";
				}
			}
			closedir($handle);
		}
		
		/*if($id=="plan")
		{
			/** Generation scenari to Rng **/
			/*$path = "scenari/sources/";
			if ($handle = opendir("$path/Plan/")) 
			{
				while (false !== ($file = readdir($handle))) 
				{
					if ($file != "." && $file != "..") 
					{
						$xml_filename = "$path/Plan/$file";
						$xsl_filename = "xsl/plan/planToRng.xsl";

						$doc = new DOMDocument();
						$xsl = new XSLTProcessor();

						$doc->load($xsl_filename);
						$xsl->importStyleSheet($doc);

						$doc->load($xml_filename);
						
						$fd = fopen("xml/plan/$file","w");
						fputs($fd,$xsl->transformToXML($doc));
						
					}
				}
				closedir($handle);
			}
			if ($handle = opendir("$path/Note/")) 
			{
				while (false !== ($file = readdir($handle))) 
				{
					if ($file != "." && $file != "..") 
					{
						$xml_filename = "$path/Note/$file";
						$xsl_filename = "xsl/note/noteToRng.xsl";

						$doc = new DOMDocument();
						$xsl = new XSLTProcessor();

						$doc->load($xsl_filename);
						$xsl->importStyleSheet($doc);

						$doc->load($xml_filename);
						
						$fd = fopen("xml/note/$file","w");
						fputs($fd,$xsl->transformToXML($doc));
					}
				}
				closedir($handle);
			}
		}*/

				
		include('template2.php');
	}

?>
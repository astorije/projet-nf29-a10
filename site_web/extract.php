<?php

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

	$file1 = fopen('xml/note.xml','r');

	while(!feof($file1))
	{
		$line1 = fgets($file1);
		
		if(match_tag('titre',$line1))
			echo "<titre>".extract_text('titre',$line1)." [Compilation]</titre>\n";
		else
		{
			if(!match_tag('note',$line1) and !match_tag('meta_note',$line1) and !match_tag('statut',$line1)
			and !match_tag('date_creation',$line1) and !match_tag('date_modification',$line1) 
			and !match_tag('auteur',$line1) and !match_tag('contributeurs',$line1) 
			and !match_tag('contributeur',$line1) and !match_tag('relecteur',$line1)
			and !match_tag('nom',$line1) and !match_tag('prenom',$line1)
			and !isComment($line1))
				echo $line1;
		}
	}
	
	$file2 = fopen('xml/note2.xml','r');
	echo "<?Note suivante?>\n";
	
	while(!feof($file2))
	{
		$line2 = fgets($file2);
		if(!match_tag('note',$line2) and !match_tag('meta_note',$line2) and !match_tag('statut',$line2)
		and !match_tag('date_creation',$line2) and !match_tag('date_modification',$line2) 
		and !match_tag('auteur',$line2) and !match_tag('contributeurs',$line2) 
		and !match_tag('contributeur',$line2) and !match_tag('relecteur',$line2)
		and !match_tag('nom',$line2) and !match_tag('prenom',$line2)
		and !match_tag('titre',$line2) and !isComment($line2))
			echo $line2;
	}

?>
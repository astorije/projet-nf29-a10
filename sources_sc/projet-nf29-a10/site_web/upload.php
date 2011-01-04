<?php

	if( isset($_POST['upload']) ) // si formulaire soumis
	{
		$content_dir = 'tmp/'; // dossier où sera déplacé le fichier

		$tmp_file = $_FILES['fichier']['tmp_name'];

		if( !is_uploaded_file($tmp_file) )
		{
			exit("Le fichier est introuvable");
		}

		// on vérifie maintenant l'extension
		$type_file = $_FILES['fichier']['type'];

		if( !strstr($type_file, 'opendocument'))
		{
			echo "Le fichier n'est pas un odt";
		}

		// on copie le fichier dans le dossier de destination
		$name_file = $_FILES['fichier']['name'];

		if( !move_uploaded_file($tmp_file, $content_dir . $name_file) )
		{
			exit("Impossible de copier le fichier dans $content_dir");
		}

		echo "Fichier upload&eacute;";
		
		$filename = 'tmp/' . $name_file;
		
		echo $filename;
		
		include('odtToXml.php');
		
	}


	include('template1.php');

	echo '	
			<form method="post" enctype="multipart/form-data" action="upload.php">
			<p>
			<input type="file" name="fichier" size="30">
			<input type="submit" name="upload" value="Uploader">
			</p>
			</form>';

	echo '<br/>';
		
	include('template2.php');
		
?>
<?php

	if(isset($_GET['id']))
	{
		$id = $_GET['id'];

		include('template1.php');
		
		
		echo '<br/><br/><br/>';
		if ($id != "article"){
			echo '	<form action="input_file.htm" enctype="multipart/form-data">
				<p>
				Choisissez un fichier odt de votre ordinateur:<br>
				<input name="fichier" type="file" size="50" maxlength="100000" accept="text/*">
				</p>
				</form>';

			echo '<br/>';
		}
		
		if ($handle = opendir("xml/$id/")) {
			while (false !== ($file = readdir($handle))) {
				if ($file != "." && $file != "..") {
					echo "<a href=\"$id.php?id=$file\">$file\n<br/>";
				}
			}
			closedir($handle);
		}
		
		include('template2.php');
	}

?>
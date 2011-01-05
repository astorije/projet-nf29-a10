<?php
if(isset($_GET['id']))
{		
	header('Location: http://localhost/wikiutc/publish?id=xml/publication/'.$_GET['id']);	
}
?>
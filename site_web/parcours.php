<?php
if(isset($_GET['id']))
{		
	header('Location: http://localhost/wikiutc/publish?id=xml/parcours/'.$_GET['id']);	
}
?>
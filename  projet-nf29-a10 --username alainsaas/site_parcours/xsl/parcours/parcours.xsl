<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:par="utc.fr/nf29/PR/parcours" xmlns:res="utc.fr/nf29/PR/ressource" xmlns:not="utc.fr/nf29/PR/notion" xmlns:met="utc.fr/nf29/PR/meta_parcours" xmlns:uti="utc.fr/nf29/PR/utilisateur" xmlns:ctx="utc.fr/nf29/PR/contextualisation" xmlns:ctn="utc.fr/nf29/pr/contenu">
	<xsl:output method="html"/>
	<xsl:template match="par:parcours">
		<html>
			<head>
				<script type="text/javascript">
function envoieRequete(url,id)
{
	var xhr_object = null;
	var position = id;
	   if(window.XMLHttpRequest)  xhr_object = new XMLHttpRequest();
	  else
	    if (window.ActiveXObject)  xhr_object = new ActiveXObject("Microsoft.XMLHTTP"); 

	// On ouvre la requete vers la page désirée
	xhr_object.open("GET", url, true);
	xhr_object.onreadystatechange = function(){
	if ( xhr_object.readyState == 4 )
	{
		// j'affiche dans la DIV spécifiées le contenu du fichier
		document.getElementById(position).innerHTML = xhr_object.responseText;
	}
	}
	// dans le cas du get
	xhr_object.send(null);

}
</script>
				<style type="text/css">
#conteneur 
{
position: absolute;
width: 100%;
height:100%;
background-color:#FFFFFF;
margin-top:50px;

}

#centre 
{
background-color:#FFFFFF;
margin-left: 270px;
}

#gauche
{
position: absolute;
height: 100%;
background-color:  #EEDDCC;
width: 250px;
}

</style>
			</head>
			<body>
				<div id="conteneur">
					<div id="gauche">
						<xsl:apply-templates/>
					</div>
					<div id="centre"/>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="not:notion">
		<h3>
			<xsl:value-of select="not:titre"/>
		</h3>
		<xsl:apply-templates select="res:ressource"/>
	</xsl:template>
	<xsl:template match="met:meta_parcours">
		<h1>
			<xsl:value-of select="met:titre"/>
		</h1>
		<xsl:apply-templates select="met:auteur"/>
	</xsl:template>
	<xsl:template match="met:auteur">
		<p>
			<xsl:text>Auteur : </xsl:text>
			<xsl:value-of select="uti:utilisateur/uti:prenom"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="uti:utilisateur/uti:nom"/>
		</p>
	</xsl:template>
	<xsl:template match="ctx:contextualisation">
		<h4>
			<xsl:value-of select="ctx:titre"/>
		</h4>
		<xsl:apply-templates select="ctn:contenu"/>
	</xsl:template>
	<xsl:template match="ctn:paragraphe">
		<p>
			<xsl:value-of select="."/>
		</p>
	</xsl:template>
	<xsl:template match="res:ressource">
		<xsl:choose>
			<xsl:when test="res:type = 'audio'">
				<p>
					<a href="#">
						<xsl:attribute name="onClick">envoieRequete('http://alainsaas.free.fr/nf29/p_audio.php?id=<xsl:value-of select="res:uri"/>','centre');</xsl:attribute>
						<xsl:value-of select="res:titre"/>
					</a>
				<xsl:text> Audio</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="res:type = 'exercice'">
				<p>
					<a href="#">
						<xsl:attribute name="onClick">envoieRequete('http://alainsaas.free.fr/nf29/p_exercice.php?id=<xsl:value-of select="res:uri"/>','centre');</xsl:attribute>
						<xsl:value-of select="res:titre"/>
					</a>
				<xsl:text> Exercice</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="res:type = 'article'">
				<p>
					<a href="#">
						<xsl:attribute name="onClick">envoieRequete('http://alainsaas.free.fr/nf29/p_article.php?id=<xsl:value-of select="res:uri"/>','centre');</xsl:attribute>
						<xsl:value-of select="res:titre"/>
					</a>
				<xsl:text> Article</xsl:text>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>

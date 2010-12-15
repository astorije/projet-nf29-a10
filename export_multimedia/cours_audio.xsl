<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:template match="cours_audio">
		<html>
			<head>
				<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
				<link href="style.css" type="text/css" rel="stylesheet"/>
				<title>
					<xsl:value-of select="meta/fichier_audio"/> : cours magistral du <xsl:value-of select="meta/date"/>
				</title>
			</head>
			<body> 
				<div class="menu">
					<div class="contenu">
						<img alt="logo" src="images/logo_wiki.png"/><br/><br/>
							<div style="padding-left: 20px;">
								<a href="">Accueil</a><br/><br/>
									<div id="articles">
										<div class="lien" id="lien">
											Articles<br/>
										</div>
										<div id="details" style="display: none;">
											<ul><li>Cr�er</li><li>Consulter</li><li>Rechercher</li></ul>
										</div>
									</div><br/>
										<div id="notes">
											<div class="lien" id="lien">
												Plans<br/>
											</div>
											<div id="details" style="display: none;">
												<ul>
													<li>Creer</li>
													<li><a href="ls.php?id=plan">Consulter</a></li>
													<li>Rechercher</li>
												</ul>
											</div>
										</div><br/>
											<div id="parcours">
												<div class="lien" id="lien">
													Parcours<br/>
												</div>
												<div id="details" style="display: none;">
													<ul><li>Cr�er</li><li>Consulter</li><li>Rechercher</li></ul>
												</div>
											</div>
							</div>
					</div>
				</div>
				<div class="cadre">
					<div id="chapitrage" data-timecontainer="excl" data-mediasync="audio" data-dur="{/cours_audio/segment[last()]/date_fin}" data-first="first.click" data-prev="prev.click" data-next="next.click" data-last="last.click" smil="active">
						<xsl:for-each select="segment">
							<div class="partie" data-begin="{date_debut}" smil="idle">
								<xsl:value-of select="partie_plan/ref_partie_plan/@uri"/>
							</div>
						</xsl:for-each>
					</div>
					<xsl:apply-templates/>   
				</div>
			</body>
		</html>
    </xsl:template>
   
    <xsl:template match="meta"/>
    <xsl:template match="segment">
    	<div class="segment" data-timecontainer="excl" data-mediasync="audio" data-dur="{/cours_audio/segment[last()]/date_fin}" data-first="first.click" data-prev="prev.click" data-next="next.click" data-last="last.click" smil="active">
        	<!--
    		<h1><xsl:value-of select="partie_plan/ref_partie_plan/@uri"/></h1>
            <h2><xsl:value-of select="date_debut"/> => <xsl:value-of select="date_fin"/></h2>
            -->
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="partie_plan"/>   
	<xsl:template match="ref_partie_plan"/>    
    <xsl:template match="segment/date_debut"/>   
    <xsl:template match="segment/date_fin"/>

    <xsl:template match="annotation">
    	<xsl:if test="position()= 1">
    		<div class="annotation" data-begin="{date_debut}" smil="active">
    			<xsl:apply-templates/>
    		</div>
    	</xsl:if>
    	<xsl:if test="position()> 1">
    		<div class="annotation" data-begin="{date_debut}" smil="idle">
    			<xsl:apply-templates/>
    		</div>
    	</xsl:if>
    	
    </xsl:template>

    <xsl:template match="contenu">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="paragraphe">
        <p><xsl:value-of select="."/></p>
    </xsl:template>
   
    <xsl:template match="annotation/titre"/>
    <xsl:template match="annotation/date_debut"/>   
    <xsl:template match="annotation/date_fin"/>
</xsl:stylesheet>

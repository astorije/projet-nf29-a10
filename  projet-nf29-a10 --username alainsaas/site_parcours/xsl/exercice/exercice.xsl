<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	<xsl:template match="exercice">
			<div class="exo" style="margin-top:50px;">
				<h1><xsl:value-of select="titre" /></h1>
				
				<xsl:for-each select="question">
						<!-- UNE QUESTION -->
						<div class="question" style="background:#dddddd;padding:15px;margin:10px;">
						<b>QUESTION</b> :
							<xsl:apply-templates/> 
						</div>
				</xsl:for-each>
				 
			</div>
			<b>FIN DE L'EXERCICE</b>
			<hr/>
    </xsl:template>
	
	
	<xsl:template match="question">
		<div class="enonce">
			<xsl:apply-templates/> 
		</div>
	</xsl:template>
	
	<xsl:template match="enonce/paragraphe">
		<p style="padding-left:30px;color:blue;">
			<xsl:value-of select="." />
		</p>
	</xsl:template>
	
	
	<xsl:template match="SolutionGenerale"/>
	
	<xsl:template match="reponseChoixUnique">
		<em class="indicateQC" style="font-size:11px;">(Une seule réponse possible)</em> 
		<ul> 
			<xsl:apply-templates/> 
		</ul>
	</xsl:template>
	
	<xsl:template match="reponseChoixMultiple">
		<em class="indicateQC" style="font-size:11px;">(Une ou plusieurs réponse(s) possible(s))</em>
		<ul style="list-style-type:square;"> 
			<xsl:apply-templates/> 
		</ul>
	</xsl:template>
	
	<xsl:template match="choix">
		<li><xsl:value-of select="." /></li>
	</xsl:template>
	
	<xsl:template match="reponseTexte"/>
	
	
</xsl:stylesheet>

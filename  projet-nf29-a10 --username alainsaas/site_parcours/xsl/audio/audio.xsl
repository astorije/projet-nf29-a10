<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:template match="cours_audio">
	
			<div class="cadre">
					<div id="chapitrage" data-timecontainer="excl" data-mediasync="audio" data-dur="{/cours_audio/segment[last()]/date_fin}" data-first="first.click" data-prev="prev.click" data-next="next.click" data-last="last.click" smil="active">
						<xsl:for-each select="segment">
							<div class="partie" data-begin="{date_debut}" smil="idle">
								<h2><xsl:value-of select="titre_segment"/></h2>
								<xsl:apply-templates/> 
							</div>
							
						</xsl:for-each>
					</div>
					  
				</div>
	
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
    
  	<xsl:template match="reference_plan"/>
	<xsl:template match="titre_segment"/>   
    <xsl:template match="segment/date_debut"/>   
    <xsl:template match="segment/date_fin"/>

    <xsl:template match="annotation">
    	<xsl:if test="position()= 1">
    		<div class="annotation" data-begin="{date_debut}" smil="active">
				début : <xsl:value-of select="date_debut"/>
				fin : <xsl:value-of select="date_fin"/>
    			<xsl:apply-templates/>
    		</div>
    	</xsl:if>
    	<xsl:if test="position()> 1">
    		<div class="annotation" data-begin="{date_debut}" smil="idle">
				début : <xsl:value-of select="date_debut"/>
				fin : <xsl:value-of select="date_fin"/>
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

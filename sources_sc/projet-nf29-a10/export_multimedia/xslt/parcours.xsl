<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:parcours="utc.fr/nf29/PR/parcours"
    xmlns:context="utc.fr/nf29/PR/contextualisation"
    xmlns:content="utc.fr/nf29/pr/contenu"
    xmlns:ressource="utc.fr/nf29/PR/ressource"
    exclude-result-prefixes="xd"
    version="1.0">
    
    
    <xsl:template match="parcours:parcours">
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <title>Parcours</title>
                <link rel="stylesheet" href="../css/global.css" type="text/css" />
                <link rel="stylesheet" href="../css/exercises.css" type="text/css" />
                <script src="../js/jquery-1.4.4.min.js"></script>
                <script src="../js/jquery.flash.js"></script>
                <script src="../js/exercises.js"></script>          
            </head>
            <body>
                <div id="questions">
                    <h1 id="title" class="hidden">
                        <xsl:apply-templates select="parcours:meta_parcours"/>
                    </h1>
                    
                    <xsl:apply-templates select="context:contextualisation"/>
                    
                    
                    <xsl:apply-templates select="parcours:notion"/>
                    
               </div>
                <div id="footer" class="hidden">
                  
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="parcours:meta_parcours">
        
        <p><xsl:value-of select="parcours:titre"/></p>
        <p><xsl:value-of select="parcours:auteur/parcours:utilisateur/parcours:nom"/> - <xsl:value-of select="parcours:auteur/parcours:utilisateur/parcours:prenom"/></p>
        
    </xsl:template>
    
    <xsl:template match="context:contextualisation">
        <div> 
            <h2><xsl:value-of select="context:titre"/></h2> 
            <p><xsl:apply-templates select="content:contenu" /></p>
        </div>
    </xsl:template>
    
    <xsl:template match="parcours:notion">
        <h2><xsl:value-of select="parcours:titre"/></h2>
       <xsl:apply-templates select="ressource:ressource" />
    </xsl:template>
    
    <xsl:template match="ressource:ressource">
        <div> <a href="{@uri}" target="_blank">ressource</a></div> 
    </xsl:template>
    
    <xsl:template match="content:contenu">
        <p><xsl:apply-templates select="content:paragraphe"/></p>
    </xsl:template>
    
    <xsl:template match="content:paragraphe">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>

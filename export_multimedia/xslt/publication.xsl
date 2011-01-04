<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:publication="utc.fr/nf29/PR/publication"
    xmlns:context="utc.fr/nf29/PR/contextualisation"
    xmlns:content="utc.fr/nf29/pr/contenu"
    xmlns:notion="utc.fr/nf29/PR/notion"
    xmlns:ressource="utc.fr/nf29/PR/ressource"
    xmlns:php="http://php.net/xsl"
    exclude-result-prefixes="xd"
    version="2.0">
    
    
    <xsl:template match="publication:publication">
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <title>Parcours</title>
                <link rel="stylesheet" href="css/global.css" type="text/css" />
                <link rel="stylesheet" href="css/exercises.css" type="text/css" />
                <script src="js/jquery-1.4.4.min.js"></script>
                <script src="js/jquery.flash.js"></script>
                <script src="js/exercises.js"></script>          
            </head>
            <body>
                <div id="questions">
                    <h1 id="title" class="hidden">
                        <xsl:apply-templates select="publication:meta_publication"/>
                    </h1>
                    
                    <xsl:apply-templates select="publication:corps"/>
                    
                    <xsl:apply-templates select="notion:notion"/>
                    
                </div>
                <div id="footer" class="hidden">
                    
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="publication:meta_publication">
        
        <p><xsl:value-of select="publication:titre"/></p>
        <p><xsl:value-of select="publication:auteur/publication:utilisateur/publication:nom"/> - <xsl:value-of select="publication:auteur/publication:utilisateur/publication:prenom"/></p>
        <p>Version - <xsl:value-of select="publication:version"/></p>
        <p><xsl:value-of select="publication:collection"/></p>
        <p> <xsl:value-of select="publication:edition"/></p>
    </xsl:template>
    
    <xsl:template match="publication:corps">
        <div> 
            <xsl:apply-templates select="context:contextualisation"/>
            <xsl:apply-templates select="publication:ref_parcours"/>
        </div>
    </xsl:template>
    
    <xsl:template match="publication:ref_parcours">
        <div> 
            <iframe height="600px" width="100%" src="file:///C:/Users/gaelle/Documents/MOD2/export_multimedia/{replace(@uri,'.xml','.html')}"> </iframe>
        </div>
    </xsl:template>
    
    
    <xsl:template match="context:contextualisation">
        <div> 
            <h2><xsl:value-of select="context:titre"/></h2> 
            <p><xsl:apply-templates select="content:contenu" /></p>
        </div>
    </xsl:template>
    
    <xsl:template match="notion:notion">
        <h2><xsl:value-of select="notion:titre"/></h2>
        <xsl:apply-templates select="ressource:ressource" />
    </xsl:template>
    
    <xsl:template match="ressource:ressource">
        <div> <a href="{replace(ressource:uri,'.xml','.html')}"  target="_blank"> <xsl:value-of select="ressource:titre" /> </a> </div> 
        <!-- echo '<a href="'.$res=split('.', {@uri}).'"  target="_blank"> ressource </a>'; -->
        <iframe height="300px" width="100%" src="file:///C:/Users/gaelle/Documents/MOD2/export_multimedia/{replace(ressource:uri,'.xml','.html')}"> </iframe> 
    </xsl:template>
    
    <xsl:template match="content:contenu">
        <p><xsl:apply-templates select="content:paragraphe"/></p>
    </xsl:template>
    
    <xsl:template match="content:paragraphe">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- <xsl:function name="substring-before-match">
        <xsl:param name="arg" /> 
        <xsl:param name="regex"  /> 
        <xsl:sequence select="tokenize($arg,$regex)[1]"/>
        </xsl:function> -->
    
    
</xsl:stylesheet>

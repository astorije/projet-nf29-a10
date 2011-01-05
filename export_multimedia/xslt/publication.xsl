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
                <link rel="stylesheet" href="css/style.css" type="text/css" />
                <script src="js/jquery-1.4.4.min.js"></script>
                <script src="js/jquery.flash.js"></script>
                <script src="js/custom.js"></script>
                <script src="js/exercises.js"></script> 
                <style type="text/css">
                    #chargement 
                    {
                    display:none;
                    }
                </style>
            </head>
            <body>
                <div id="questions">
                  
                    <div id="conteneur">
                        <div id="gauche">
                            <h1 id="titles" class="hidden">
                                <xsl:apply-templates select="publication:meta_publication"/>
                            </h1>
                            <xsl:apply-templates select="publication:corps"/>
                            <xsl:apply-templates select="notion:notion"/>
                        </div>
                        <iframe id="test" height="800px" width="100%" src=""></iframe>
                    </div>
                    
                </div>
                
                <script type="text/javascript">  
                    function envoieRequete(url,id)
                    {
                    
                    $('#button'+id).click( function() {
                    $('#test').attr('src',url);
                    
                    });
                    }
                    
                </script>
                
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
            <div id="chargement"><b style="color:#ff0000;">CHARGEMENT EN COURS ...</b></div>
        </div>
    </xsl:template>
    
    <xsl:template match="publication:ref_parcours">
        
            <p> <button id="button{position()}" onclick="envoieRequete('file:///C:/Users/gaelle/Documents/MOD2/export_multimedia/{replace(. ,'\.xml','.html')}', '{position()}')">Parcours <xsl:value-of select="position()" /></button></p>
        
    </xsl:template>
    
    
    <xsl:template match="context:contextualisation">
        <div> 
            <h2><xsl:value-of select="context:titre"/></h2> 
            <p><xsl:apply-templates select="content:contenu" /></p>
        </div>
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

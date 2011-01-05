<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:parcours="utc.fr/nf29/PR/parcours"
    xmlns:context="utc.fr/nf29/PR/contextualisation"
    xmlns:content="utc.fr/nf29/pr/contenu"
    xmlns:notion="utc.fr/nf29/PR/notion"
    xmlns:ressource="utc.fr/nf29/PR/ressource"
    xmlns:php="http://php.net/xsl"
    exclude-result-prefixes="xd"
    version="2.0">
    
    
    <xsl:template match="parcours:parcours">
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <title>Parcours</title>
                <link rel="stylesheet" href="css/global.css" type="text/css" />
                <link rel="stylesheet" href="css/exercises.css" type="text/css" />
                <link rel="stylesheet" href="css/style.css" type="text/css" />
                <script src="js/jquery-1.4.4.min.js"></script>
                <script src="js/jquery.flash.js"></script>
                <script src="js/exercises.js"></script> 
                <script src="js/jquery.tools.min.js"></script>
                <style type="text/css">
                    #chargement 
                    {
                    display:none;
                    }
                </style>
                
            </head>
            <body >
                <div id="questions">
                    <div id="conteneur">
                        <div id="gauche">
                            <h1 id="title" class="hidden">
                                <xsl:apply-templates select="parcours:meta_parcours"/>
                            </h1>
                            <xsl:apply-templates select="context:contextualisation"/>
                            <xsl:apply-templates select="notion:notion"/>
                        </div>
                        <iframe id="test" height="500px" width="100%" src=""></iframe>
                    </div>
                </div>   
                
                <script type="text/javascript">  
                   function envoieRequete(url,id)
                     {
               
                    $('#bouton'+id).click( function() {
                    $('#test').attr('src',url);
                    
                    });
                    }
                
                </script>
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
    
    <xsl:template match="notion:notion">
        <h2><xsl:value-of select="notion:titre"/></h2>
       <xsl:apply-templates select="ressource:ressource" />
        <div id="chargement"><b style="color:#ff0000;">CHARGEMENT EN COURS ...</b></div>
    </xsl:template>
    
    <xsl:template match="ressource:ressource">
        <p> <button id="bouton{position()}" onclick="envoieRequete('file:///C:/Users/gaelle/Documents/MOD2/export_multimedia/{replace(ressource:uri,'\.xml','.html')}', '{position()}')"><xsl:value-of select="ressource:titre" /></button></p>
      
        <!-- <p> <a href="{replace(ressource:uri,'.xml','.html')}" onclick="envoieRequete(file:///C:/Users/gaelle/Documents/MOD2/export_multimedia/exercices_php.html,{ressource:uri});"><xsl:value-of select="ressource:titre" /></a> </p>
         <p> <a href="{replace(ressource:uri,'.xml','.html')}"> <xsl:value-of select="ressource:titre" /> </a> </p>
        
             <iframe height="300px" width="100%" src="file:///C:/Users/gaelle/Documents/MOD2/export_multimedia/{replace(ressource:uri,'.xml','.html')}"> </iframe>  
            echo '<a href="'.$res=split('.', {@uri}).'"  target="_blank"> ressource </a>'; -->
        
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

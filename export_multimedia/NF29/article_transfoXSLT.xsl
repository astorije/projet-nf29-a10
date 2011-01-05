<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:art="http://utc.fr/nf29/PR/article"
    exclude-result-prefixes="art"
    xmlns:cont="http://utc.fr/nf29/pr/contenu">

    <xsl:template match="art:article">
        
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <title><xsl:value-of select="./art:titre_article"/></title>
                <link rel="stylesheet" href="global.css" type="text/css" />
                <script src="jquery-1.4.4.min.js"></script>
                <script src="custom-form-elements.js"></script>
                <script src="app.js"></script>
            </head>
            <body>
                <h1><xsl:value-of select="./art:titre_article"/></h1>
                <center>contenu <xsl:value-of select="./art:meta_article/art:statut_validation"/> et <xsl:value-of select="./art:meta_article/art:statut_completude"/></center>
                <div id="article">
                    <form method="post" action="#">
                        <xsl:apply-templates select="art:partie"/>
             </form>
                </div>
                
                <div id="score" class="rounded_box">
                    <div id="score_sentence">
                         <strong><span id="score_value"></span> %</strong>.
                    </div>
                    <a href="#">Afficher les solutions.</a>
                </div>

                <div id="footer">
                    
                    <ul>
                        <li class="right"> <a id="previous" href="#">Precedent</a></li>
                       
                        <li class="left"> <a id="next" href="#">Suivant</a></li>
                    </ul>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="art:partie">
        <xsl:apply-templates select="art:sous_partie"/>
        <xsl:apply-templates select="cont:contenu"/>
    </xsl:template>
    
    <xsl:template match="art:sous_partie">
        <xsl:apply-templates select="art:sous_sous_partie"/>
        <xsl:apply-templates select="cont:contenu"/>
    </xsl:template>
    
    <xsl:template match="art:sous_sous_partie">
        <xsl:apply-templates select="cont:contenu"/>
    </xsl:template>
    
    
    <xsl:template match="cont:contenu">              
        <div class="question rounded_box">
            <p><b><font size="5"><xsl:value-of select="../../../art:titre"/></font></b></p>
            <p><b><font size="5"><xsl:value-of select="../../art:titre"/></font></b></p>
            <p><b><font size="4"><xsl:value-of select="../art:titre"/></font></b></p>
            <xsl:apply-templates select="cont:paragraphe"/>
            <xsl:apply-templates select="cont:itemListe"/>
        </div>       
    </xsl:template>
    
    
    <xsl:template match="cont:paragraphe">
        <p><xsl:value-of select="."/></p>
    </xsl:template>
        
    <xsl:template match="cont:itemListe">
        <UL>
            <LI>
                <p><xsl:value-of select="./cont:paragraphe"/></p>  
            </LI>  
        </UL>
    </xsl:template>
        
</xsl:stylesheet>
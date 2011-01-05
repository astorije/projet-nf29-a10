<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:art="http://utc.fr/nf29/PR/article"
    exclude-result-prefixes="art"
    xmlns:cont="http://utc.fr/nf29/pr/contenu">
    
<xsl:template match="art:article">
        <link rel="stylesheet" type="text/css" href="style-article.css" />
        <div id="top-article">
            <div id="meta-info">
                <fieldset>
                    <legend>Informations sur l'article</legend>
                    Date de création: <i><xsl:value-of select="art:meta_article/art:date_creation"/></i><br/>
                    Auteur: <i><xsl:value-of select="art:meta_article/art:auteur/art:utilisateur/art:prenom"/><xsl:text> </xsl:text><xsl:value-of select="art:meta_article/art:auteur/art:utilisateur/art:nom"/></i><br/>
                    Modifié le: <i><xsl:value-of select="art:meta_article/art:date_modification"/></i><br/>
                    Dernier contributeur: <i><xsl:apply-templates select="art:meta_article/art:contributeurs [position()=last()]"/></i>
                    Relecteur: <i><xsl:value-of select="art:meta_article/art:relecteur/art:utilisateur/art:prenom"/><xsl:text> </xsl:text><xsl:value-of select="art:meta_article/art:relecteur/art:utilisateur/art:nom"/></i><br/>
                    Statut:  <i><xsl:value-of select="art:meta_article/art:statut_validation/text()"/><xsl:text> / </xsl:text><xsl:value-of select="art:meta_article/art:statut_completude/text()"/></i>
                </fieldset>
            </div>
            <h1><xsl:value-of select="art:titre_article"/></h1>
            <xsl:if test="./art:ref_note/@uri != ''">
                Note(s) liée(s):<xsl:apply-templates select="./art:ref_note"/> 
            </xsl:if>
        </div>
        <div id="article">
            <xsl:apply-templates select="art:partie"/>  <br/>
        </div>

</xsl:template>

<xsl:template match="art:contributeurs">
    <xsl:value-of select="./art:utilisateur/art:prenom/text()"/><xsl:text> </xsl:text><xsl:value-of select="./art:utilisateur/art:nom/text()"/><br/>
</xsl:template> 
    
<xsl:template match="art:partie">
    <div id="partie">
        <h2><xsl:value-of select="./art:titre/text()"/></h2>
        <xsl:apply-templates select="./cont:contenu"/>
        <xsl:apply-templates select="./art:sous_partie"/>
    </div>
</xsl:template>   
    
<xsl:template match="art:sous_partie">
    <div id="sous-partie">
        <h3><xsl:value-of select="./art:titre/text()"/></h3>
        <xsl:apply-templates select="./cont:contenu"/>
        <xsl:apply-templates select="./art:sous_sous_partie"/>
    </div>
</xsl:template>   
  
<xsl:template match="art:sous_sous_partie">
    <div id="sous-sous-partie">
        <h4><xsl:value-of select="./art:titre/text()"/></h4>
        <xsl:apply-templates select="./cont:contenu"/>
    </div>
</xsl:template>  


<xsl:template match="cont:contenu">
    <xsl:apply-templates/>
</xsl:template>

    
<xsl:template match="cont:paragraphe">
    <xsl:value-of select="./text()"/><br/>
    <xsl:apply-templates select="./cont:itemListe"/>
    <xsl:apply-templates select="./paragraphe"/>
</xsl:template>
    
<xsl:template match="art:ref_note">
    <xsl:text> </xsl:text><a href="{concat('generate.php?uri=uri_note_',@uri)}"><xsl:value-of select="@titre"/></a><br/>
</xsl:template>
 
<xsl:template match="cont:itemListe">
    <li id="n1"><xsl:value-of select="./cont:paragraphe/text()"/></li>
    <xsl:apply-templates select="./cont:sousItemListe"/>
</xsl:template>

<xsl:template match="cont:sousItemListe">
    <li id="n2"><xsl:value-of select="./cont:paragraphe/text()"/></li>
    <xsl:apply-templates select="./cont:sousSousItemListe"/>
</xsl:template>
    
    <xsl:template match="cont:sousSousItemListe">
        <li id="n3"><xsl:value-of select="./cont:paragraphe/text()"/></li>
    
</xsl:template>
    

    
</xsl:stylesheet>

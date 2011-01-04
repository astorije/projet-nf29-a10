<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:note="utc.fr/nf29/pr/note"
    xmlns:contenu="utc.fr/nf29/pr/contenu"
    exclude-result-prefixes="xd note contenu"
    version="1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec 5, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Thibaud BOURGEOIS</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="note:note">
        <xsl:apply-templates/>         
    </xsl:template>
    <xsl:template match="note:titre">
        <h1><xsl:apply-templates/></h1>
    </xsl:template>
    <xsl:template match="contenu:contenu">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="contenu:paragraphe">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="contenu:image">
        <img src="{@src}" alt="{@label}"/>
    </xsl:template>
    <xsl:template match="contenu:itemListe">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="contenu:sousItemListe">
        <li><xsl:value-of select="./contenu:paragraphe/text()"/></li>
    </xsl:template>
    <xsl:template match="note:meta_note "></xsl:template>
</xsl:stylesheet>
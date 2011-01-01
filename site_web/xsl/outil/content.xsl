<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"     
    exclude-result-prefixes="xd text office"
    version="1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec 18, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Martine BOURGEOIS</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="office:document-content">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="office:scripts"></xsl:template>
    <xsl:template match="office:font-face-decls"></xsl:template>
    <xsl:template match="office:automatic-styles"></xsl:template>
    
    <xsl:template match="office:body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="office:text">
        <pl>
            <xsl:apply-templates/>
        </pl>
    </xsl:template>
    <xsl:template match="text:sequence-decls"></xsl:template>
    
    <xsl:template match="text:list">   
        <xsl:apply-templates/>   
    </xsl:template>
   
    <xsl:template match="text:list-item">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="text:p">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
</xsl:stylesheet>
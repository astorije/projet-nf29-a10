<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:art="utc.fr/nf29/sc/article"
    xmlns:bs="scpf.org:base" 
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:img="utc.fr/nf29/sc/image" 
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core" 
    xmlns:cont="utc.fr/nf29/sc/contenu" exclude-result-prefixes="xd" version="2.0">
    
    <xsl:template match="art:article">
        <xsl:element name="article">
            <xsl:attribute name="ns">utc.fr/nf29/sc/article</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
   
    <xsl:template match="bs:sTitleArticle/sc:fullTitle">
        <xsl:element name="titre_article">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="bs:sTitlePartie/sc:fullTitle">
        <xsl:element name="titre">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="sp:partie">
        <xsl:element name="partie"><xsl:apply-templates/>
        </xsl:element>
    </xsl:template>  
    

    
    <xsl:template match="sp:contenu">
        <xsl:element name="contenu">
            <xsl:attribute name="ns">utc.fr/nf29/sc/contenu</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template> 
    
    <xsl:template match="sp:texte">
        <xsl:apply-templates/>
    </xsl:template>  
    
    <xsl:template match="sc:para">
        <xsl:element name="paragraghe">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>  
    <xsl:template match="cont:textContenu/sc:itemizedList">
        <xsl:element name="itemListe">
            <xsl:for-each select="sc:listItem">
                <xsl:apply-templates select="sc:para"/>
                <xsl:if test="sc:itemizedList">
                    <xsl:element name="sousItemListe">
                        <xsl:for-each select="sc:itemizedList/sc:listItem">
                            <xsl:apply-templates select="sc:para"/>
                            <xsl:if test="sc:itemizedList">
                                <xsl:element name="sousSousItemListe">
                                    <xsl:for-each select="sc:itemizedList/sc:listItem">
                                        <xsl:apply-templates select="sc:para"/>
                                    </xsl:for-each>
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:for-each>
            
        </xsl:element>
        
    </xsl:template>
    
    <xsl:template match="sp:sousPartie">
        <xsl:element name="sous_partie">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="sp:sousSousPartie">
        <xsl:element name="sous_sous_partie">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="img:image">
        <xsl:apply-templates/> 
    </xsl:template>
    
    <xsl:template match="sp:image">
        <xsl:element name="image">
            <xsl:element name="url">
                <xsl:value-of select="img:image/sp:image/@sc:refUri"/>            
            </xsl:element>
        </xsl:element>
    </xsl:template>    
    
    <xsl:template match="sp:note">
        <xsl:element name="note">
            <xsl:attribute name="src">
                <xsl:value-of select="@sc:refUri"/>
            </xsl:attribute>  
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core" 
    xmlns:au="utc.fr/nf29/sc/audio"
    xmlns:cnt="utc.fr/sc/contenu" 
    xmlns:cont="utc.fr/sc/contenu" 
    xmlns:img="utc.fr/sc/image"
    xmlns:not="utc.fr/nf29/sc/plan"
    xmlns:bs="scpf.org:base" exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="au:coursaudio">
        <xsl:element name="cours_audio">
            <xsl:namespace name="ns">utc.fr/nf29/PR/audio</xsl:namespace>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="au:coursaudioentete">
        <xsl:element name="meta">
            <xsl:element name="fichier_audio">
                <xsl:value-of select="sp:fichierAudio"/>
            </xsl:element>
            <xsl:element name="date">
                <xsl:value-of select="sp:date"/>
            </xsl:element>
            <xsl:element name="url_server"><xsl:value-of select="sp:urlServeur"/></xsl:element>
        </xsl:element>
    </xsl:template>

    <!-- Parser un segment audio -->
    <xsl:template match="sp:segment">
        <xsl:variable name="in" select="@sc:refUri"/>
        <xsl:element name="segment">
            <xsl:apply-templates select="document(replace($in,'/(.*)/',''))">
                <xsl:with-param name="segURI" select="@sc:refUri"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>

    <!-- Titre segement a enlever -->
    <xsl:template match="sc:item/au:segment/bs:sTitle"/>


    <!-- parser le plan -->
    <xsl:template match="sc:item/au:segment/sp:plan">
        <xsl:param name="segURI"/>
        <xsl:element name="reference_plan">
            <xsl:namespace name="ns">utc.fr/nf29/PR/plan</xsl:namespace>
            <xsl:value-of select="replace(@sc:refUri,'/(.*)/','')"/>
        </xsl:element>
        <xsl:apply-templates select="document(replace(@sc:refUri,'/(.*)/',''))">
            <xsl:with-param name="segURI" select="$segURI"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="sc:item/not:plan">
        <xsl:param name="segURI"/>
        <xsl:apply-templates select="//sp:segmentAudio">
            <xsl:with-param name="segURI" select="$segURI"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="sp:segmentAudio">
        <xsl:param name="segURI"/>
        <xsl:if test="replace(@sc:refUri,'/(.*)/','') = replace($segURI,'/(.*)/','')">
            <!-- extraire le titre du segment à partir du plan -->
            <xsl:for-each select="../..//sc:fullTitle">
                <xsl:if test="position() = 1">
                    <xsl:element name="titre_segment">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template match="sp:dateDebut">
        <xsl:element name="date_debut">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sp:dateFin">
        <xsl:element name="date_fin">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sp:annotation/au:note">
        <xsl:element name="annotation">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sp:annotation/au:note/bs:sTitle">
        <xsl:element name="titre">
            <xsl:value-of select="sc:fullTitle"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sp:tcin">
        <xsl:element name="date_debut">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sp:tcout">
        <xsl:element name="date_fin">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Contenu -->
    <xsl:template match="sp:contenu">
        <xsl:element name="contenu">
                <xsl:namespace name="ns">utc.fr/nf29/PR/contenu</xsl:namespace>
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
    
    <xsl:template match="sp:image">
        <xsl:if test="@sc:refUri">
        <xsl:element name="image">
            <xsl:attribute name="src">
                <xsl:value-of select="@sc:refUri"/>
            </xsl:attribute>
        </xsl:element>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>  
    
    <!-- parser un contenu de type liste -->
    <xsl:template match="sc:listItem">
        <xsl:element name="itemListe">
            <xsl:apply-templates select="sc:para"/>
            <xsl:for-each select="sc:itemizedList/sc:listItem">
                <xsl:element name="sousItemListe">
                    <xsl:apply-templates select="sc:para"/>
                    <xsl:for-each select="sc:itemizedList/sc:listItem">
                        <xsl:element name="sousSousItemListe">
                            <xsl:apply-templates select="sc:para"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="au:time">
        <xsl:value-of select="sp:heure"/>:<xsl:value-of select="sp:minute"/>:<xsl:value-of select="sp:seconde"/>
    </xsl:template>
</xsl:stylesheet>

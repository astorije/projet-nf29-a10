<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:not="utc.fr/note"
    xmlns:bs="scpf.org:base"
    
    exclude-result-prefixes="xd sc sp not bs"
    version="1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec 5, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Thibaud BOURGEOIS</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="sc:item">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="not:plan">
        <plan auteur="" titre="{./bs:sTitlePlan/sc:fullTitle/text()}">
            <xsl:apply-templates/>
        </plan>
    </xsl:template>
    <xsl:template match="bs:sTitlePlan">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="sp:partiePlan">
        <partie_plan titre="{./bs:sTitlePartiePlan/sc:fullTitle/text()}">
            <xsl:apply-templates/>
        </partie_plan>
    </xsl:template>
    <xsl:template match="sp:sousPartiePlan">
        <sous_partie_plan titre="{./bs:sTitlePartiePlan/sc:fullTitle/text()}">
            <xsl:apply-templates/>
        </sous_partie_plan>
    </xsl:template>
    <xsl:template match="sp:sousSousPartiePlan">
        <sous_sous_partie_plan titre="./bs:sTitlePartiePlan/sc:fullTitle/text()">
            <xsl:apply-templates/>
        </sous_sous_partie_plan>
    </xsl:template>
    <xsl:template match="sp:note">
        <ref_note uri="{substring-before(concat('uri_note_',substring-after(@sc:refUri,'Notes/')),'.xml')}" titre="{substring-before(substring-after(@sc:refUri,'Notes/'),'.xml')}"/>
    </xsl:template>
    <xsl:template match="sc:fullTitle">
    </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="style.css" type="text/css" media="all"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:not="utc.fr/note"
    xmlns:bs="scpf.org:base"
    xmlns:pl="utc.fr/nf29/pr/plan"
    exclude-result-prefixes="xd sc sp not bs"
    version="1.0">
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
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
        <pl:plan auteur="" titre="{./bs:sTitlePlan/sc:fullTitle/text()}" uri="{concat('uri_partiePlan_',translate(./bs:sTitlePlan/sc:fullTitle/text(),' ','_'))}"><xsl:value-of select="$newline"/>
            <xsl:apply-templates/>
        </pl:plan><xsl:value-of select="$newline"/>
    </xsl:template>
    <xsl:template match="bs:sTitlePlan">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="sp:partiePlan">
        <pl:partie_plan titre="{./bs:sTitlePartiePlan/sc:fullTitle/text()}" uri="{concat('uri_partiePlan_',translate(./bs:sTitlePartiePlan/sc:fullTitle/text(),' ','_'))}"><xsl:value-of select="$newline"/>
            <xsl:apply-templates/>
        </pl:partie_plan><xsl:value-of select="$newline"/>
    </xsl:template>
    <xsl:template match="sp:sousPartiePlan">
        <pl:sous_partie_plan titre="{./bs:sTitlePartiePlan/sc:fullTitle/text()}" uri="{concat('uri_partiePlan_',translate(./bs:sTitlePartiePlan/sc:fullTitle/text(),' ','_'))}"><xsl:value-of select="$newline"/>
            <xsl:apply-templates/>
        </pl:sous_partie_plan><xsl:value-of select="$newline"/>
    </xsl:template>
    <xsl:template match="sp:soussouspartiePlan">
        <pl:sous_sous_partie_plan titre="{./bs:sTitlePartiePlan/sc:fullTitle/text()}" uri="{concat('uri_partiePlan_',translate(./bs:sTitlePartiePlan/sc:fullTitle/text(),' ','_'))}"><xsl:value-of select="$newline"/>
            <xsl:apply-templates/>
        </pl:sous_sous_partie_plan><xsl:value-of select="$newline"/>
    </xsl:template>
    <xsl:template match="sp:note">
        <pl:ref_note uri="{substring-before(concat('uri_note_',substring-after(@sc:refUri,'Note/')),'.note')}" titre="{substring-before(substring-after(@sc:refUri,'Note/'),'.note')}"/><xsl:value-of select="$newline"/>
    </xsl:template>
    <xsl:template match="sc:fullTitle">
    </xsl:template>
</xsl:stylesheet>
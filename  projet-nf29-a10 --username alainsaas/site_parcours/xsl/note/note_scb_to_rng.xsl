<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
    xmlns:nf29a003="scenari-platform.org/nf29a003"
    xmlns:img="utc.fr/image"
    xmlns:not="utc.fr/note"
    xmlns:bs="scpf.org:base"
    exclude-result-prefixes="xd sp sc not nf29a003 img bs"
    version="1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec 6, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Thibaud BOURGEOIS</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="sc:item">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="not:note">
        <note uri="{concat('note_',translate(./sp:contenuNote/bs:sTitle/sc:fullTitle/text(),' ','_'))}">
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    <xsl:template match="sp:contenuNote">
        <meta_note>
            <statut>none</statut>
            <date_creation>2011-01-01</date_creation>
            <date_modification>2011-01-01</date_modification>
            <auteur>
                <nom>none</nom>
                <prenom>none</prenom>
            </auteur>
            <contributeurs>
                <contributeur>
                    <nom>none</nom>
                    <prenom>none</prenom>
                </contributeur>
            </contributeurs>
            <relecteur>
                <nom>none</nom>
                <prenom>none</prenom>
            </relecteur>
        </meta_note>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="bs:sTitle">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="sc:fullTitle">
        <titre><xsl:apply-templates/></titre>
    </xsl:template>
    <xsl:template match="nf29a003:contenu">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="sp:texte">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="bs:sTxt">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="sc:para">
        <paragraphe>
            <xsl:apply-templates/>
        </paragraphe>
    </xsl:template>
    <xsl:template match="sp:image">
        <image>
            <url><xsl:value-of select="./img:image/sp:image/@sc:refUri"/></url>
            <description><xsl:value-of select="substring-before(substring-after(./img:image/sp:image/@sc:refUri,'Notes/'),'.jpg')"/></description>
        </image>
    </xsl:template>
</xsl:stylesheet>
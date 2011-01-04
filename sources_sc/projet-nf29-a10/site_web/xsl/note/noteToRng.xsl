<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="style.css" type="text/css" media="all"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
    xmlns:nf29a003="scenari-platform.org/nf29a003"
    xmlns:img="utc.fr/image"
    xmlns:not="utc.fr/note"
    xmlns:bs="scpf.org:base"
    xmlns:note="utc.fr/nf29/pr/note"
    xmlns:contenu="utc.fr/nf29/pr/contenu"
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
        <note:note uri="{concat('note_',translate(./sp:contenuNote/bs:sTitle/sc:fullTitle/text(),' ','_'))}">
            <xsl:apply-templates/>
        </note:note>
    </xsl:template>
    <xsl:template match="sp:contenuNote">
        <note:meta_note>
            <note:date_creation>2011-01-01</note:date_creation>
            <note:date_modification>2011-01-01</note:date_modification>
            <note:auteur>
                <note:utilisateur>
                    <note:nom>none</note:nom>
                    <note:prenom>none</note:prenom>
                </note:utilisateur>
            </note:auteur>
            <note:contributeurs>
                <note:utilisateur>
                    <note:nom>none</note:nom>
                    <note:prenom>none</note:prenom>
                </note:utilisateur>
            </note:contributeurs>
            <note:relecteur>
                <note:utilisateur>
                    <note:nom>none</note:nom>
                    <note:prenom>none</note:prenom>
                </note:utilisateur>
            </note:relecteur>
            <note:statut>none</note:statut>
            <note:version>none</note:version>
        </note:meta_note>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="bs:sTitle">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="sc:fullTitle">
        <note:titre><xsl:apply-templates/></note:titre>
    </xsl:template>
    
    <xsl:template match="nf29a003:contenu">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="sp:texte">
        <contenu:contenu>
            <xsl:apply-templates/>
        </contenu:contenu>
    </xsl:template>
    
    <xsl:template match="bs:sTxt">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="sc:para">
        <contenu:paragraphe>
            <xsl:apply-templates/>
        </contenu:paragraphe>
    </xsl:template>
    
    <xsl:template match="sp:image">
        <contenu:image src="{./img:image/sp:image/@sc:refUri}" label="{substring-before(substring-after(./img:image/sp:image/@sc:refUri,'Notes/'),'.jpg')}"/>
    </xsl:template>
    
    <xsl:template match="sc:itemizedList">
        <contenu:itemListe>
            <xsl:apply-templates/>
        </contenu:itemListe>
    </xsl:template>

    <xsl:template match="sc:listItem">
        <contenu:sousItemListe>
            <xsl:apply-templates/>
        </contenu:sousItemListe>
    </xsl:template>
    
</xsl:stylesheet>
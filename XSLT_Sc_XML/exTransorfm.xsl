<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href='style.css' type='text/css' media="all"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core" xmlns:ex="utc.fr/nf29/sc/exercice"
    xmlns:cnt="utc.fr/nf29/sc/contenu" xmlns:img="utc.fr/nf29/sc/image" xmlns:bs="scpf.org:base"
    xmlns:cont="utc.fr/nf29/sc/contenu" exclude-result-prefixes="xs" version="2.0">


    <xsl:template match="ex:Exercice">
        <xsl:element name="exercice">
            <xsl:namespace name="ns">utc.fr/nf29/pr/exercice</xsl:namespace>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sc:fullTitle">
        <xsl:element name="titre">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="ex:question">
        <xsl:element name="question">

            <xsl:if test="sp:enonce">
                <xsl:apply-templates select="sp:enonce"/>
            </xsl:if>

            <xsl:if test="sp:indice">
                <xsl:apply-templates select="sp:indice"/>
            </xsl:if>

            <xsl:if test="sp:SolutionGenerale">
                <xsl:apply-templates select="sp:SolutionGenerale"/>
            </xsl:if>

            <xsl:if test="sp:responseTexte">
                <xsl:apply-templates select="sp:responseTexte"/>
            </xsl:if>

            <xsl:if test="sp:reponseChoixMultiple">
                <xsl:element name="reponseChoixMultiple">
                    <xsl:for-each select="sp:reponseChoixMultiple">
                        <xsl:element name="choix">
                            <xsl:attribute name="valide">
                                <xsl:value-of select="ex:validate/sp:validate"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>

            <xsl:if test="sp:reponseChoixUnique">
                <xsl:element name="reponseChoixUnique">
                    <xsl:for-each select="sp:reponseChoixUnique">
                        <xsl:element name="choix">
                            <xsl:attribute name="valide">
                                <xsl:value-of select="ex:validate/sp:validate"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sp:enonce">
        <xsl:element name="enonce">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="cont:textContenu/sc:itemizedList">
        <xsl:element name="itemListe">
            <xsl:for-each select="sc:listItem">
                <xsl:element name="paragraphe">
                    <xsl:value-of select="sc:para"></xsl:value-of>
                </xsl:element>
                <xsl:if test="sc:itemizedList">
                    <xsl:element name="sousItemListe">
                        <xsl:for-each select="sc:itemizedList/sc:listItem">
                            <xsl:element name="paragraphe">
                                <xsl:value-of select="sc:para"></xsl:value-of>
                            </xsl:element>
                            <xsl:if test="sc:itemizedList">
                                <xsl:element name="sousSousItemListe">
                                    <xsl:for-each select="sc:itemizedList/sc:listItem">
                                        <xsl:element name="paragraphe">
                                            <xsl:value-of select="sc:para"></xsl:value-of>
                                        </xsl:element>
                                    </xsl:for-each>
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>
            </xsl:for-each>

        </xsl:element>

    </xsl:template>


    <xsl:template match="cnt:contenu">
        <xsl:element name="contenu">
            <xsl:namespace name="ns">utc.fr/nf29/pr/contenu</xsl:namespace>
             <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="cont:textContenu">
        <xsl:element name="paragraphe">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sp:para">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="img:image">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="img:image/sp:image">
        <xsl:element name="image">
            <xsl:attribute name="src">
                <xsl:value-of select="@sc:refUri"/>
            </xsl:attribute>

            <xsl:attribute name="label"/>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="sp:indice">
        <xsl:element name="indice">
            <xsl:apply-templates/>
        </xsl:element>

    </xsl:template>




    <xsl:template match="sp:SolutionGenerale">
        <xsl:element name="SolutionGenerale">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="sp:responseTexte">
        <xsl:element name="reponseTexte">
            <xsl:attribute name="valide">
                <xsl:value-of select="ex:validate/sp:validate"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>

    </xsl:template>

    <xsl:template match="sp:validate"/>


    <xsl:template match="sp:reponseTexte/bs:sTxt">
        <xsl:element name="reponse">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>



</xsl:stylesheet>

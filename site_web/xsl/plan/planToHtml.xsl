<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:pl="utc.fr/nf29/pr/plan"
    exclude-result-prefixes="xd pl"
    version="1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec 5, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Thibaud BOURGEOIS</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="pl:plan">
        <h1><xsl:value-of select="@titre"/></h1>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="pl:partie_plan">
        <ul>
            <li>
                <h2>
                    <xsl:value-of select="@titre"/>
                    <span style="margin-left:20px">
                     <a href="{concat('fusion.php?plan=',/pl:plan/@titre,'&amp;partie=',@titre)}">
                         <img src="images/merge.png"/>
                     </a>
                    </span>
                </h2>
            </li>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="pl:sous_partie_plan">
        <ul>
            <li>
                <h3>
                    <xsl:value-of select="@titre"/>
                    <span style="margin-left:20px">
                        <a href="{concat('fusion.php?plan=',/pl:plan/@titre,'&amp;partie=',@titre)}">
                            <img src="images/merge.png"/>
                        </a>
                    </span>
                </h3>
            </li>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="pl:sous_sous_partie_plan">
        <ul>
            <li>
                <h4><xsl:value-of select="@titre"/>
                    <span style="margin-left:20px">
                        <a href="{concat('fusion.php?plan=',/pl:plan/@titre,'&amp;partie=',@titre)}">
                            <img src="images/merge.png"/>
                        </a>
                    </span>
                </h4>
            </li>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="pl:ref_note">
        <a href="generate.php?uri={@uri}">
            <xsl:value-of select="@titre"/>
        </a>
        <a href="pdf.php?uri={@uri}" target="_blank">
            <img src="images/pdf.gif"/>
        </a>
    </xsl:template>
    <xsl:template match="pl:ref_segment">
        <a href="generate.php?uri={@uri}">
            <xsl:value-of select="substring-after(@uri,'uri_segment_')"/>
        </a>
    </xsl:template>
</xsl:stylesheet>
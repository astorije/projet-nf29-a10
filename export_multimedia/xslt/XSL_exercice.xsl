<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xd"
    version="1.0">
    
    <xsl:template match="exercice">
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <title>Exercices d'introduction au PHP</title>
                <link rel="stylesheet" href="css/global.css" type="text/css" />
                <link rel="stylesheet" href="css/exercises.css" type="text/css" />
                <script src="js/jquery-1.4.4.min.js"></script>
                <script src="js/jquery.flash.js"></script>
                <script src="js/exercises.js"></script>          
            </head>
            <body>
                <xsl:apply-templates select="titre"/>
                <div id="questions">
                    <div id="toggle_solutions">
                        <a href="#">Afficher les solutions</a>
                    </div>
                    <form method="post" action="#">
                       
                        <xsl:apply-templates select="question" />
                    </form>
                </div>
                <div id="score" class="rounded_box">
                    Votre score est de <strong><span id="score_value"></span> %</strong>.
                </div>
                
                <div id="footer" class="hidden">
                    <div id="indice_bloc">
                        <div id="indice_link">
                            <a href="#">Indice</a>
                        </div>
                        <div id="content"></div>
                    </div>
                    <ul>
                        <li class="right"><a id="previous" href="#">Précédent</a></li>
                        <li class="center"><span id="question_number">1</span> / <span id="count_questions"></span></li>
                        <li class="left"><a id="next" href="#">Suivant</a></li>
                    </ul>
                 </div>
            </body>
        </html>
    </xsl:template>
    <xsl:variable name="num" select="/exercice/question/position()"></xsl:variable>
    <xsl:template match="question">
       <div class="question rounded_box"> 
          <xsl:apply-templates select="enonce"/> 
           <xsl:apply-templates select="indice"/>
           <xsl:apply-templates select="reponse_texte"/>
           <xsl:apply-templates select="reponse_choix_multiple"/>
           <xsl:apply-templates select="reponse_choix_unique"/>
           <xsl:apply-templates select="solutionGenerale"/>
           
       </div>
    </xsl:template>
    
    <xsl:template match="question[last()]">
       
        <div class="question rounded_box" > 
            <xsl:apply-templates select="enonce"/> 
            <xsl:apply-templates select="indice"/>
            <ul>
                <span class="solution"><xsl:apply-templates select="reponse_texte"/>
                    <xsl:apply-templates select="reponse_choix_multiple"/>
                    <xsl:apply-templates select="reponse_choix_unique"/>
                </span>
            </ul>
        </div>
    </xsl:template>
    
    <xsl:template match="titre">
        <h1 id="title" class="hidden"><xsl:value-of select="."/>  </h1>
    </xsl:template>
    
    <xsl:template match="enonce">
        <xsl:value-of select="./paragraphe"/>
        <xsl:apply-templates select="image"/>
        <xsl:if test="../reponse_texte">
            <div class="enonce"><input type="text" name="question{/exercice/question/position()}" id="question{../position()}"/> </div>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="indice">
        <div class="indice">
            <a href="{./paragraphe/a/@href}"><xsl:value-of select="./paragraphe"/></a>  
            <xsl:apply-templates select="image" />  
        </div>
    </xsl:template>
    
    <xsl:template match="image">
            <IMG src="{@src}" border="0" align="center" width="5%" height="5%"/>
    </xsl:template>
    
    <xsl:template match="reponse_texte">
        <div class="solution"><xsl:value-of select="."/></div>
    </xsl:template>
    
    <xsl:template match="solutionGenerale">
        <div class="solution"><xsl:value-of select="."/></div>
    </xsl:template>
    
    <xsl:template match="reponse_choix_multiple">
        <div class="solution"></div>
            <ul>  
            <xsl:for-each select="choix">
                <li>
                    <input type="checkbox" name="question{ancestor::node()[2]/position()}" id="question[answer{position()}]"></input> 
                   
                    <span class="solution">
                        <xsl:if test="@solution='true'">
                            <span class="solution"><img src="images/checkbox_on.png" alt="Vrai" /></span>
                        </xsl:if>
                        <xsl:if test="@solution='false'">
                            <span class="solution"><img src="images/checkbox_off.png" alt="Faux" /></span>
                        </xsl:if>
                    </span>
                    <label for="question[answer{position()}]"><xsl:value-of select="."/></label>
                </li>
                <!-- <xsl:attribute name="solution">solution
                    <xsl:value-of select="."/>
                    </xsl:attribute> 
                    <xsl:apply-templates/>-->
            </xsl:for-each>
           </ul>
        
    </xsl:template>
   <xsl:template match="reponse_choix_unique">
        <div class="solution"></div>
        <ul>  
            <xsl:for-each select="choix">
                <li>
                    <input type="radio" name="question{ancestor::node()[2]/position()}" id="question[answer{position()}]" value="answer{position()}"></input>
                    <span class="solution">
                        <xsl:if test="@solution='true'">
                            <img src="images/radio_on.png" alt="Vrai" />
                        </xsl:if>
                        <xsl:if test="@solution='false'">
                            <img src="images/radio_off.png" alt="Faux" />
                        </xsl:if>
                    </span>
                    <label for="question5[answer1]"><xsl:value-of select="."/></label>
                </li>
                <!-- <xsl:attribute name="solution">solution
                    <xsl:value-of select="."/>
                    </xsl:attribute> 
                    <xsl:apply-templates/>-->
            </xsl:for-each>
        </ul>
    </xsl:template>
</xsl:stylesheet>
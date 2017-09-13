<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Case Problem 1

   Election Results XSLT Style Sheet
   Author: Efrem MCCrimon
   Date:   

   Filename:         polls.xsl
   Supporting Files: back.jpg, logo.jpg
   
    	non-breaking space 	&nbsp; 	&#160;
        
-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" />

<xsl:variable name="redcell">
    <td class="red"> </td>
</xsl:variable>  
<xsl:variable name="bluecell">
    <td class="blue"> </td>
</xsl:variable>
<xsl:variable name="greencell">
    <td class="green"> </td>
</xsl:variable>

<xsl:template match="/">
   <html>
   <head>
      <title>Election Night Results</title>
      <link href="polls.css" rel="stylesheet" type="text/css" />
   </head>
   <body>
      <div id="intro">
         <p><img src="logo.jpg" alt="Election Day Results" /></p>
         <a href="#">Election Home Page</a>
         <a href="#">President</a>
         <a href="#">Senate Races</a>
         <a href="#">Congressional Races</a>
         <a href="#">State Senate</a>
         <a href="#">State House</a>
         <a href="#">Local Races</a>
         <a href="#">Judicial</a>
         <a href="#">Referendums</a>
      </div>

      <div id="results">
         <h1>Congressional Races</h1>
         <xsl:apply-templates select="polls/race" />
      </div>
   </body>
   </html>
</xsl:template>

<xsl:template match="race">
   <h2><xsl:value-of select="title" /></h2>
   <table cellpadding="1" cellspacing="1">
      <tr><th>Candidate</th><th class="num">Votes</th></tr>
      <xsl:apply-templates select="candidate" />
   </table>
</xsl:template>

<xsl:template match="candidate">
   <xsl:variable name="percent">
    <xsl:value-of select="votes div sum(..//votes)" />
   </xsl:variable>   
   <tr>
      <td class="name"><xsl:value-of select="name" /> (<xsl:value-of select="party" />)</td>
      <td class="num"><xsl:value-of select="format-number(votes, '#,##0')" />
      &#160;<xsl:value-of select="format-number($percent,'(#0%)')" />
      </td>
         
      <xsl:call-template name="showBar">
          <xsl:with-param name="cells" select="$percent * 100" />
          <xsl:with-param name="partyType" select="party" />
      </xsl:call-template>    
      
   </tr>
</xsl:template>

<xsl:template name="showBar">
    <xsl:param name="cells" select="0"/>
    <xsl:param name="partyType" />
    
    <!-- Check the partyType 
 <xsl:if test="$cells >= 0">

    -->
    <xsl:if test="$cells > 0">
    <xsl:choose>
        <xsl:when test="($partyType = 'R') or ($partyType = 'D')">
            <!-- Calculate the Party -->
        
	    <xsl:if test="$partyType = 'D'">
               <xsl:copy-of select="$bluecell" />
               <!-- can not use a value-of for a Result treefragment
                    must use the copy-of select="$variable"
                   <xsl:value-of select="$bluecell" /> will convert to a string
                   <td class="blue"> </td>
                -->
               
	    </xsl:if>
	    <xsl:if test="$partyType = 'R'">
                 <xsl:copy-of select="$redcell" />
	    </xsl:if>            
        </xsl:when>   
        
        <xsl:otherwise>
            <!-- Display the other -->
             <xsl:copy-of select="$greencell" />

        </xsl:otherwise>
    </xsl:choose>   
    <xsl:call-template name="showBar">
        <xsl:with-param name="cells" select="$cells - 1" />
        <xsl:with-param name="partyType" select="$partyType" />
    </xsl:call-template>         
    </xsl:if>    
</xsl:template>  

</xsl:stylesheet>
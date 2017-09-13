<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Case Problem 3

   Datalia Templates
   Author: 
   Date:   

   Filename:         function.xsl
   Supporting Files: 
-->
<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="squareRoot">
   <xsl:param name="number" select="0" />
   <xsl:param name="estimate" select="1" />
   <xsl:variable name="nextEstimate" select="$estimate+($number - $estimate * $estimate) div (2 * $estimate)" />
   <xsl:variable name="diff" select="$estimate - $nextEstimate" />
   <xsl:choose>
      <xsl:when test="$diff > 0.001 or $diff &lt; -0.001">
         <xsl:call-template name="squareRoot">
            <xsl:with-param name="number" select="$number" />
            <xsl:with-param name="estimate" select="$nextEstimate" />
         </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="format-number($nextEstimate,'#.00')" />
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

</xsl:stylesheet>
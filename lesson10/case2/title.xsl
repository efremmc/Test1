<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 2

   Game Statistics Title


   Filename:         title.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />

<xsl:template match="/">
   <h2>
      <xsl:value-of select="game/team[position()=1]/@name" /> 
      vs. 
      <xsl:value-of select="game/team[position()=2]/@name" />
   </h2>
</xsl:template>


</xsl:stylesheet>


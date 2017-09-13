<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 4 - Show Price List

   Stock Reporter Stock Overview


   Filename:         overview.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="cdlist" select="//cd" />

<xsl:template match="/">
   <h2>Price List</h2>
   <xsl:apply-templates select="$cdlist">
      <xsl:sort select="artist" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="cd">
   <h3><xsl:value-of select="cd" />( by <xsl:value-of select="artist" />)</h3>
   <p><b>Price: </b><xsl:value-of select="price" /><br />
   
</xsl:template>


</xsl:stylesheet>


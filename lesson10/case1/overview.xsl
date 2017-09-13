<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 1

   Stock Reporter Stock Overview


   Filename:         overview.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="stocklist" select="//stock" />

<xsl:template match="/">
   <h2>Stock Overview</h2>
   <xsl:apply-templates select="$stocklist">
      <xsl:sort select="name/@symbol" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="stock">
   <h3><xsl:value-of select="name" />(<xsl:value-of select="name/@symbol" />)</h3>
   <p><b>Category: </b><xsl:value-of select="category" /><br />
   <xsl:value-of select="description" /></p>
</xsl:template>


</xsl:stylesheet>


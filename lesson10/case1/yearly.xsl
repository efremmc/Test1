<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 1

   Stock Reporter Yearly Stock Summary

   Filename:         yearly.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="stocklist" select="//stock" />

<xsl:template match="/">
   <h2>Yearly Summary</h2>
   <xsl:apply-templates select="$stocklist">
      <xsl:sort select="name/@symbol" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="stock">
   <h3><xsl:value-of select="name" />(<xsl:value-of select="name/@symbol" />)</h3>

   <table class="summary">
   <tr>
      <th class="summary">Year High</th>
      <td class="number"><xsl:value-of select="year_high" /></td>
   </tr>
   <tr>
      <th class="summary">Year Low</th>
      <td class="number"><xsl:value-of select="year_low" /></td>
   </tr>
   <tr>
      <th class="summary">Price/Earnings Ratio</th>
      <td class="number"><xsl:value-of select="pe_ratio" /></td>
   </tr>
   <tr>
      <th class="summary">Earnings per Share</th>
      <td class="number"><xsl:value-of select="earnings" /></td>
   </tr>
   <tr>
      <th class="summary">Yield</th>
      <td class="number"><xsl:value-of select="yield" /></td>
   </tr>
   </table>
</xsl:template>

</xsl:stylesheet>


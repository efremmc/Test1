<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 1

   Stock Reporter Five-Day Stock Values


   Filename:         fiveday.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="stocklist" select="//stock" />

<xsl:template match="/">
   <h2>Five-Day Report</h2>
   <xsl:apply-templates select="$stocklist">
      <xsl:sort select="name/@symbol" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="stock">
   <h3><xsl:value-of select="name" />(<xsl:value-of select="name/@symbol" />)</h3>
   <xsl:apply-templates select="five_day" />
</xsl:template>

<xsl:template match="five_day">
   <table class="today">
   <tr>
      <th class="today">&#160;</th>
      <th class="today">Day</th>
      <th class="today">Open</th>
      <th class="today">High</th>
      <th class="today">Low</th>
      <th class="today">Close</th>
      <th class="today">Volume</th>
   </tr> 

   <xsl:apply-templates select="day">
      <xsl:sort order="descending" data-type="number" />
   </xsl:apply-templates>
</table>
</xsl:template>

<xsl:template match="day">
   <tr>
      <td class="number">
         <xsl:choose>
            <xsl:when test="@close &lt; @open">
               <img src="down.gif" alt="down" />
            </xsl:when>
            <xsl:when test="@close > @open">
               <img src="up.gif" alt="up" />
            </xsl:when>
            <xsl:otherwise>
               <img src="same.gif" alt="same" />
            </xsl:otherwise>
         </xsl:choose>
      </td>
      <td class="number"><xsl:value-of select="@date"/></td>
      <td class="number"><xsl:value-of select="@open"/></td>
      <td class="number"><xsl:value-of select="@high"/></td>
      <td class="number"><xsl:value-of select="@low"/></td>
      <td class="number"><xsl:value-of select="@close"/></td>
      <td class="number"><xsl:value-of select="@vol"/></td>
   </tr>
</xsl:template>

</xsl:stylesheet>


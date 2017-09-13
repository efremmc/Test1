<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 1

   Stock Reporter Current Stock Values


   Filename:         current.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="stocklist" select="//stock" />

<xsl:template match="/">
   <h2>Current Values</h2>
   <xsl:apply-templates select="$stocklist">
      <xsl:sort select="name/@symbol" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="stock">
   <h3><xsl:value-of select="name" />(<xsl:value-of select="name/@symbol" />)</h3>
   <xsl:apply-templates select="today" />
</xsl:template>

<xsl:template match="today">
   <table class="today">
   <tr>
      <th class="today">Current</th>
      <th class="today">Open</th>
      <th class="today">High</th>
      <th class="today">Low</th>
      <th class="today">Volume</th>
   </tr>
   <tr>
      <td class="number">
         <xsl:choose>
            <xsl:when test="@current &lt; @open">
               <img src="down.gif" />
            </xsl:when>
            <xsl:when test="@current > @open">
               <img src="up.gif" />
            </xsl:when>
            <xsl:otherwise>
               <img src="same.gif" />
            </xsl:otherwise>
         </xsl:choose>
         <xsl:value-of select="@current" />
      </td>
      <td class="number">
         <xsl:value-of select="@open" />
      </td>
      <td class="number">
         <xsl:value-of select="@high" />
      </td>
      <td class="number">
         <xsl:value-of select="@low" />
      </td>
      <td class="number">
         <xsl:value-of select="@vol" />
      </td>
   </tr>
   </table>
</xsl:template>

</xsl:stylesheet>


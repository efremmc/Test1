<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 3

   Computer Lab Style Sheet


   Filename:         lab.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />

<xsl:template match="/">
   <table id="labs">
      <xsl:apply-templates select="labs" />
   </table>
</xsl:template>

<xsl:template match="labs">
   <tr>
      <th colspan="9" class="title">Schedule for <xsl:value-of select="@date" /></th>
   </tr>
   <tr>
      <th>Lab</th>
      <th>9:00 am</th>
      <th>10:00 am</th>
      <th>11:00 am</th>
      <th>12:00 pm</th>
      <th>1:00 pm</th>
      <th>2:00 pm</th>
      <th>3:00 pm</th>
      <th>4:00 pm</th>
   </tr>
   <xsl:apply-templates select="lab" />
</xsl:template>


<xsl:template match="lab">
   <tr>
      <th>
         <xsl:value-of select="@name" />
      </th>
      <xsl:apply-templates select="slot" />
   </tr>
</xsl:template>

<xsl:template match="slot">
   <xsl:choose>
      <xsl:when test=".='free'">
         <td class="free"><xsl:value-of select="." /></td>
      </xsl:when>
      <xsl:otherwise>
         <td class="reserved"><xsl:value-of select="." /></td>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

</xsl:stylesheet>
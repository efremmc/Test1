<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Review Assignment

   Grant List XSLT style sheet

   Filename:         grants.xsl
   Supporting Files: 

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="group" select="//grant" />

<xsl:template match="/">
   <table cellspacing="0" cellpadding="2">
      <xsl:apply-templates select="$group">
         <xsl:sort select="date" data-type="text" order="descending" /> 
      </xsl:apply-templates>
   </table>
</xsl:template>

<xsl:template match="grant">
   <tr>
      <td width="100"><xsl:value-of select="category" /></td>
      <td width="70"><xsl:value-of select="date" /></td>
      <td width="100"><xsl:value-of select="title" /></td>
      <td width="130"><xsl:value-of select="street" /><br />
         <xsl:value-of select="city" />, 
         <xsl:value-of select="state" /> &#160;
         <xsl:value-of select="zip" />
      </td>
      <td width="70" class="total">
         <xsl:value-of select="format-number(amount,'$#,##0')" />
      </td>
   </tr>
   <xsl:if test="position()=last()">
      <tr>
         <td colspan="4" class="total">Total</td>
         <td class="total">
            <xsl:value-of select="format-number(sum($group/amount),'$#,##0')" />
         </td>
      </tr>
   </xsl:if>
</xsl:template>

</xsl:stylesheet>
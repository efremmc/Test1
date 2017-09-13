<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Tutorial Case

   Contribution List XSLT style sheet

   Filename:         clist.xsl
   Supporting Files: clist.xml

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="group" select="//person" />

<xsl:template match="/">
   <table width="370" cellspacing="0" cellpadding="2">
   <tr>
      <th colspan="3">Contributor List</th>
      <th id="total">Total: 
         <xsl:value-of select="format-number(sum($group/amount),'$#,##0')" />
      </th>
   </tr>
   <tr>
      <th>Date</th>
      <th>Name</th>
      <th>Address</th>
      <th>Amount</th>
   </tr>

   <xsl:apply-templates select="$group">
      <xsl:sort select="date" data-type="text" order="descending" />
   </xsl:apply-templates>

   <xsl:apply-templates select="$group">
      <xsl:sort select="last_name" data-type="text" order="descending" />
   </xsl:apply-templates>
   <xsl:apply-templates select="$group">
      <xsl:sort select="city" data-type="text" order="descending" />
   </xsl:apply-templates>
   <xsl:apply-templates select="$group">
      <xsl:sort select="amount" data-type="text" order="descending" />
   </xsl:apply-templates>


   <xsl:apply-templates select="$group">
      <xsl:sort select="date" data-type="text" order="ascending" />
   </xsl:apply-templates>

   </table>
</xsl:template>

<xsl:template match="person">
   <tr>
      <td width="70"><xsl:value-of select="date" /></td>
      <td width="100"><xsl:value-of select="last_name" />, 
         <xsl:value-of select="first_name" />
      </td>
      <td width="130">
         <xsl:value-of select="street" /><br />
         <xsl:value-of select="city" />, 
         <xsl:value-of select="state" />&#160;
         <xsl:value-of select="zip" />
      </td>
      <td width="70" align="right">
         <xsl:value-of select="format-number(amount,'$#,##0')" />
      </td>
   </tr>
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Review Assignment

   Wizard Works XSLT Style Sheet
   Author: 
   Date:   

   Filename:         items.xsl
   Supporting Files: items.css, logo.jpg, shared.xsl

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" />

<xsl:template match="/">
   <html>
   <head><title>Wizard Works Products</title></head>
   <link href="items.css" rel="stylesheet" type="text/css" />
   <body>

   <table class="Summary" border="2" cellpadding="2">
   <tr>
      <th colspan="2">Summary Information</th>
   </tr>
   <tr>
      <th class="Summary">Filter</th>
      <td class="Summary">
      </td>
   </tr>
   <tr>
      <th class="Summary">Products</th>
      <td class="Summary"></td>
   </tr>
   <tr>
      <th class="Summary">Quantity</th>
      <td class="Summary"></td>
   </tr>
   <tr>
      <th class="Summary">Revenue</th>
      <td class="Summary">
      </td>
   </tr>
   </table>
   
   <p><img src="logo.jpg" alt="Wizard Works" /></p>

   <xsl:apply-templates select="catalog/group" />
   </body>
   </html>
</xsl:template>


<xsl:template match="group">
   <h1><xsl:value-of select="@type" /></h1>
   <table class="prod" border="10" cellpadding="5" bordercolor="blue" bordercolorlight="lightblue">
   <tr>
      <th>Name</th>
      <th>Order ID</th>
      <th>Date</th>
      <th>Qty</th>
      <th>Price</th>
      <th>Total</th>
   </tr>
   <xsl:apply-templates select="product">
      <xsl:sort select="pName" />
   </xsl:apply-templates>
   <tr>
      <th colspan="3" class="num">Total</th>
      <th class="num"></th>
      <th colspan="2" class="num">
      </th>
   </tr>
   </table>
</xsl:template>

<xsl:template match="product">
   <xsl:apply-templates select="order">
      <xsl:sort select="@OID" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="order">
<tr>
   <td><xsl:value-of select="../pName" /></td>
   <td><xsl:value-of select="@OID" /></td>
   <td><xsl:value-of select="@date" /></td>
   <td class="num"><xsl:value-of select="@qty" /></td>
   <td class="num"><xsl:value-of select="@price" /></td>
   <td class="num"></td>
</tr>
</xsl:template>


</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Review Assignment

   Wizard Works XSLT Style Sheet
   Author: Efrem McCrimon
   Date:   3-8-2011

   Filename:         items.xsl
   Supporting Files: items.css, logo.jpg, shared.xsl

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="shared.xsl"/>
<xsl:output method="html" version="4.0" />

<xsl:param name="filter" select="'Fountain'" />
<!--
<xsl:param name="filter" select="'Rings'" />  - Just rings
<xsl:param name="filter" select="''" />  - all 
<xsl:param name="filter" select="''" /> - case
-->
<xsl:param name="productList"
select="catalog/group[starts-with(@type,$filter)]" />

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
          <xsl:if test="$filter=''">all</xsl:if>
          <xsl:value-of select="$filter" />
      </td>
   </tr>
   <tr>
      <th class="Summary">Products</th>
      <td class="Summary">
          <xsl:value-of select="count($productList//product)" />
      </td>
   </tr>
   <tr>
      <th class="Summary">Quantity</th>
      <td class="Summary">
          <xsl:value-of select="sum($productList//@qty)" />
      </td>
   </tr>
   <tr>
      <th class="Summary">Revenue</th>
      <td class="Summary">
          <xsl:call-template name="totalRevenue">
              <xsl:with-param name="list" select="$productList//order" />
          </xsl:call-template>          
      </td>
   </tr>
   </table>
   
   <p><img src="logo.jpg" alt="Wizard Works" /></p>

   <xsl:apply-templates select="$productList" />
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

   <th class="num">
       <xsl:value-of select="count(product/order)" /> items
   </th>
   <th colspan="2" class="num">
       <xsl:call-template name="totalRevenue">
           <xsl:with-param name="list" select="product/order" />
       </xsl:call-template>         
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
    <xsl:if test="position()=1">
   
        <td rowspan="{count(../order)}">
            <xsl:value-of select="../pName" />
        </td>
    </xsl:if>
     
   <td><xsl:value-of select="@OID" /></td>
   <td><xsl:value-of select="@date" /></td>
   <td class="num"><xsl:value-of select="@qty" /></td>
   <td class="num"><xsl:value-of select="@price" /></td>
   <td class="num"><xsl:value-of select="format-number(@qty * @price, '#,##0.00')" /></td>

</tr>
</xsl:template>


</xsl:stylesheet>
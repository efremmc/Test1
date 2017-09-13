<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Tutorial Case

   Wizard Works XSLT Style Sheet
   Author: 
   Date:   

   Filename:         works.xsl
   Supporting Files: library.xsl, logo.jpg, works.css

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" />

<xsl:template match="/">
   <html>
   <head>
      <title>Customer Orders</title>
      <link href="works.css" rel="stylesheet" type="text/css" />
   </head>

   <body>
   <table class="summary" border="2" cellpadding="2">
   <tr>
      <th colspan="2" id="summtitle">Summary Information</th>
   </tr>
   <tr>
      <th>Filter</th>
      <td>
      </td>
   </tr>
   <tr>
      <th>Customers</th>
      <td></td>
   </tr>
   <tr>
      <th>Orders</th>
      <td></td>
   </tr>
   <tr>
      <th>Items</th>
      <td></td>
   </tr>
   <tr>
      <th>Quantity</th>
      <td></td>
   </tr>
   <tr>
      <th>Total</th>
      <td></td>
   </tr>
   </table>
   
   <p><img src="logo.jpg" alt="Wizard Works" /></p>

   <h1>Customer Orders</h1>
   <xsl:apply-templates select="customers/customer" />
   </body>
   </html>
</xsl:template>


<xsl:template match="customer">
    <table class="custinfo" border="3" cellpadding="2">
    <tr>
       <th>Customer</th>
       <td><xsl:value-of select="cName/lName" />
           <xsl:if test="cName/fName !=''">, </xsl:if>
           <xsl:value-of select="cName/fName" />
       </td>
    </tr>
    <tr>
       <th>Customer ID</th>
       <td><xsl:value-of select="@CID" /></td>
    </tr>
    <tr>
       <th>Address</th>
       <td><xsl:value-of select="street" /><br />
           <xsl:value-of select="city" />, 
           <xsl:value-of select="state" /> <xsl:value-of select="postalCode" />
       </td>
    </tr>
    <tr>
       <th>Phone Number</th>
       <td><xsl:value-of select="phone" /></td>
    </tr>  
    </table>

    <xsl:apply-templates select="orders" />
</xsl:template>


<xsl:template match="orders">
   <table class="orderinfo" border="10" cellpadding="2">
   <tr>
      <th>Date</th>
      <th>Item</th>
      <th>Description</th>
      <th>Qty</th>
      <th>Price</th>
      <th>Total</th>
   </tr>

   <xsl:apply-templates select="order/items" />

   <tr>
      <th class="grand" colspan="3">Grand Total</th>
      <td class="grand"></td>
      <td class="grand"></td>
      <td class="grand"></td>
   </tr>

   </table>
</xsl:template>


<xsl:template match="items">
   <xsl:apply-templates select="item" />

   <tr>
      <th class="sub" colspan="3">Subtotal</th>
      <td class="sub"></td>
      <td class="sub"></td>
      <td class="sub"></td>
   </tr>
</xsl:template>


<xsl:template match="item">
   <tr>
      <td class="tdtext"><xsl:value-of select="../../@date" /></td> 
      <td class="tdtext"></td>
      <td class="tdtext"><xsl:value-of select="." /></td>
      <td><xsl:value-of select="@qty" /></td>
      <td><xsl:value-of select="@price" /></td>
      <td></td>
   </tr>
</xsl:template>

</xsl:stylesheet>
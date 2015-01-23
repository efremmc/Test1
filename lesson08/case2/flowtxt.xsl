<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 8
   Case Problem 2

   WebFlowers XSLT Style Sheet
   Author: 
   Date:   

   Filename:         flowers.xsl
   Supporting Files: customers.xml, flowers.css, items.xml
-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
   <html>
   <head>
      <title>Flower Orders</title>
      <link href="flowers.css" rel="stylesheet" type="text/css" />
   </head>
   <body>
      <h1>Flower Orders</h1>
      <table>
      <tr>
         <th>Date</th>
         <th>Customer</th>
         <th>Item</th>
         <th>Price</th>
         <th>Qty</th>
         <th>Total</th>
      </tr>

      <tr>
         <td colspan="4" class="grand">Grand Total</td>
         <td class="grand"></td>
         <td class="grand">
        </td>
      </tr>
      </table>
   </body>
   </html>
</xsl:template>

<xsl:template match="order">

   <tr>
      <!-- Display order date -->


      <!-- Display customer information -->


      <!-- Display item name and price-->

    
      <!-- Display item quantity -->
      <td class="num"><xsl:value-of select="@qty" /></td>  

      <!-- Display cost of items ordered -->


   </tr>

   <!-- Display subtotals -->
   <xsl:if test="position()=last()">
      <tr><td colspan="5"><hr /></td></tr>
      <tr>
         <td colspan="3" class="sub">Subtotal</td>
         <td class="sub"></td>
         <td class="sub">
        </td>
      </tr>
      <tr><td colspan="6"><hr /></td></tr>
   </xsl:if>

</xsl:template>


</xsl:stylesheet>
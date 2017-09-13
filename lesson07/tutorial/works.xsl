<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Tutorial Case

   Wizard Works XSLT Style Sheet
   Author: Efrem McCrimon
   Date:   3-8-2011

   Filename:         works.xsl
   Supporting Files: library.xsl, logo.jpg, works.css

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="filter" select="''" />
    <xsl:variable name="group" select="customers/customer[starts-with(@CID,$filter)]" />
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
          <xsl:if test="$filter=''">all</xsl:if>
          <xsl:value-of select="$filter" />
      </td>
   </tr>
   <tr>
      <th>Customers</th>
      <td><xsl:value-of select="count($group)" /></td>
   </tr>
   <tr>
      <th>Orders</th>
      <td><xsl:value-of select="count($group//order)" /></td>
   </tr>
   <tr>
      <th>Items</th>
      <td><xsl:value-of select="count($group//item)" /></td>
   </tr>
   <tr>
      <th>Quantity</th>
      <td><xsl:value-of select="sum($group//@qty)" /></td>
   </tr>
   <tr>
      <th>Total</th>
      <td>
          <xsl:call-template name="totalCost">
              <xsl:with-param name="list" select="$group//item" />
          </xsl:call-template>
      </td>
   </tr>
   </table>
   
   <p><img src="logo.jpg" alt="Wizard Works" /></p>

   <h1>Customer Orders</h1>
   <xsl:apply-templates select="$group" />
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
           <xsl:value-of select="state" /> &#160;&#160;<xsl:value-of select="postalCode" />
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
      <td class="grand"><xsl:value-of select="sum(order/items/item/@qty)" /></td>
      <td class="grand"></td>
      <td class="grand">
         <xsl:call-template name="totalCost">
              <xsl:with-param name="list" select="order/items/item" />
         </xsl:call-template>
      </td>
   </tr>

   </table>
</xsl:template>


<xsl:template match="items">
   <xsl:apply-templates select="item" />

   <tr>
      <th class="sub" colspan="3">Subtotal</th>
      <td class="sub"><xsl:value-of select="sum(item/@qty)" /></td>
      <td class="sub"></td>
      <td class="sub">
         <xsl:call-template name="totalCost">
              <xsl:with-param name="list" select="item" />
         </xsl:call-template>          
      </td>
   </tr>
</xsl:template>


<xsl:template match="item">
   <tr>
       <xsl:if test="position()=1">
           <td class="tdtext" rowspan="{count(../../items/item)}">
               <xsl:value-of select="../../@date" />
           </td>
       </xsl:if>
      
      <td class="tdtext"><xsl:number value="position()" format="1)" /></td>
      <td class="tdtext"><xsl:value-of select="." /></td>
      <td><xsl:value-of select="@qty" /></td>
      <td><xsl:value-of select="@price" /></td>
      <td><xsl:value-of select="format-number(@qty * @price, '#,##0.00')" /></td>
   </tr>
</xsl:template>

<xsl:template name="totalCost">
    <xsl:param name="list"></xsl:param>
    <xsl:param name="total" select="0" />
    
    <!-- Calculate the total item cost -->
    <xsl:choose>
        <xsl:when test="$list">
            <!-- Calculate the first item -->
            <xsl:variable name="first" select="$list[1]/@qty * $list[1]/@price" />
            
            <!-- Call the totalCost template -->
            <xsl:call-template name="totalCost">
                <xsl:with-param name="list" select="$list[position() > 1]" />
                <xsl:with-param name="total" select="$first + $total" />
            </xsl:call-template>
            
        </xsl:when>
        <xsl:otherwise>
            <!-- Display the total cost -->
            <xsl:value-of select="format-number($total, '$#,#00.00')" />
        </xsl:otherwise>
    </xsl:choose>
    
</xsl:template>
</xsl:stylesheet>
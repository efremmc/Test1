	

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
       <xsl:variable name="items" select="document('items.xml')" />
       <xsl:variable name="customers" select="document('customers.xml')" />
       <xsl:key name="itemID" match="item" use="@id" />
       <xsl:key name="custID" match="customer" use="@id" />
       <xsl:key name="date" match="order" use="@date" />
       
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
                   
                   <xsl:for-each select="//order[generate-id()=generate-id(key('date', @date)[1])]">
                      <xsl:sort select="@date" />
                      <xsl:apply-templates select="key('date', @date)">
                            <xsl:sort select="@customer" />
                         </xsl:apply-templates>
                   </xsl:for-each>
                   
                   <tr>
                      <td colspan="4" class="grand">Grand Total</td>
                      <td class="grand"><xsl:value-of select="sum(//order/@qty)" /></td>
                      <td class="grand">
                         <xsl:call-template name="totalCost">
                            <xsl:with-param name="list" select="//order"/>
                         </xsl:call-template>
                      </td>
                   </tr>
                </table>
             </body>
          </html>
       </xsl:template>
       
       <xsl:template match="order">
          <xsl:variable name="cID" select="@customer" />
          <xsl:variable name="iID" select="@item" />
          <xsl:variable name="qtyValue" select="@qty" />
          <tr>
             <!-- Display order date -->
             <xsl:if test="position() = 1">
                <td rowspan="{count(key('date', @date))+2}" class="date">
                   <xsl:value-of select="@date" />
                </td>
             </xsl:if>
     
             <!-- Display customer information -->
             <xsl:for-each select="$customers">
                <td>
                   <xsl:value-of select="key('custID', $cID)/name" /><br />
                   <xsl:value-of select="key('custID', $cID)/street" /><br />
                   <xsl:value-of select="key('custID', $cID)/city" />,
                   <xsl:value-of select="key('custID', $cID)/state" />&#160;&#160;
                   <xsl:value-of select="key('custID', $cID)/zip" />
                </td>
             </xsl:for-each>
             
             <!-- Display item name and price-->
             <xsl:for-each select="$items">
                <td>
                   <xsl:value-of select="key('itemID', $iID)/name" />
                </td>
                <td class="num">
                   <xsl:value-of select="key('itemID', $iID)/price" />
                </td>
             </xsl:for-each>
             
             <!-- Display item quantity -->
             <td class="num"><xsl:value-of select="@qty" /></td>  
             
             <!-- Display cost of items ordered -->
             <xsl:for-each select="$items">
                <td class="num">
                   <xsl:value-of select="format-number(key('itemID', $iID)/price * $qtyValue, '#0.00')" />
                </td>
             </xsl:for-each>
          </tr>
         
          <!-- Display subtotals -->
          <xsl:if test="position()=last()">
             <tr><td colspan="5"><hr /></td></tr>
             <tr>
                <td colspan="3" class="sub">Subtotal</td>
                <td class="sub"><xsl:value-of select="sum(key('date', @date)/@qty)" /></td>
                <td class="sub">
                   <xsl:call-template name="totalCost">
                      <xsl:with-param name="list" select="key('date', @date)" />
                   </xsl:call-template>
                </td>
             </tr>
             <tr><td colspan="6"><hr /></td></tr>
          </xsl:if>
       </xsl:template>
       
       <xsl:template name="totalCost">
          <xsl:param name="list" />
          <xsl:param name="total" select="0" />
          <xsl:choose>
             <xsl:when test="$list">
                <xsl:variable name="first" select="$list[1]" />
                <xsl:variable name="iID" select="$first/@item" />
                <xsl:variable name="itemQty" select="$first/@qty" />
                <xsl:for-each select="$items">
                   <xsl:variable name="itemPrice" select="key('itemID', $iID)/price" />
                   <xsl:call-template name="totalCost">
                      <xsl:with-param name="list" select="$list[position() > 1]" />
                      <xsl:with-param name="total" select="$itemQty * $itemPrice + $total" />
                   </xsl:call-template>
                </xsl:for-each>
             </xsl:when>   
             <xsl:otherwise>
                <xsl:value-of select="format-number($total, '$#,#00.00')" />
             </xsl:otherwise>
          </xsl:choose>
       </xsl:template>  
    </xsl:stylesheet>


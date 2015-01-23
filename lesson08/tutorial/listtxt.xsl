<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 8
   Tutorial Case

   MidWest Homes XSLT style sheet
   Author: 
   Date:   

   Filename:         listings.xsl
   Supporting Files: agents.xml, firms.xml, listings.css, logo.jpg

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
   <html>
   <head>
      <title>Real Estate Listings</title>
      <link href="listings.css" rel="stylesheet" type="text/css" />
   </head>
   <body>
      <p><img src="logo.jpg" alt="MidWest Homes" /></p>
      <h2>New Listings</h2>

      <div id="city_list"><b>Cities: </b> |
      </div>

      <xsl:apply-templates select="listings/property">
         <xsl:sort select="city" />
         <xsl:sort select="price" />
      </xsl:apply-templates>
   
   </body>
   </html>
</xsl:template>

<xsl:template match="property">

   <table class="head" cellpadding="2">
   <tr>
      <th>Price</th>
      <td><xsl:value-of select="format-number(price,'$#,##0')" /></td>
      <th>Sq. Feet</th>
      <td><xsl:value-of select="sqfeet" /></td>
   </tr>
   <tr>
      <th rowspan="2">Address</th>
      <td rowspan="2">
         <xsl:value-of select="street" /><br />
         <xsl:value-of select="city" />, <xsl:value-of select="state" />
         <xsl:text> </xsl:text><xsl:value-of select="zip" />
      </td>
      <th>Baths</th>
      <td><xsl:value-of select="bathrooms" /></td>
   </tr>
   <tr>
      <th>Bedrooms</th>
      <td><xsl:value-of select="bedrooms" /></td>
   </tr>
   <tr>	
      <th>Style</th>
      <td><xsl:value-of select="style" /></td>
      <th>Garage</th>
      <td><xsl:value-of select="garage" /></td>
   </tr>
   <tr>
      <th>Age</th>
      <td><xsl:value-of select="age" /></td>
      <th>Listing #</th>
      <td><xsl:value-of select="@rln" /></td>
   </tr>
   <tr>
      <td id="description" colspan="4">
         <xsl:value-of select="description" />
      </td>
   </tr>
   </table>
</xsl:template>

</xsl:stylesheet>
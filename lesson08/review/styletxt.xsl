<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 8
   Review Assignment

   MidWest Homes XSLT style sheet
   Author: 
   Date:   

   Filename:         style.xsl
   Supporting Files: agencies.xml, logo.jpg, styles.css

-->
<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/">
   <html>
   <head>
      <title>Real Estate Listings</title>
      <link href="style.css" rel="stylesheet" type="text/css" />
   </head>
   <body>
      <p><img src="logo.jpg" alt="MidWest Homes" /></p>
      <h2>New Listings</h2>

      <div><b>Styles: </b> |

      </div>
   
   </body>
   </html>
</xsl:template>

<xsl:template match="property">

   <table cellpadding="2">
   <tr>
      <th class="head2">Realty Agency</th>
      <th>Price</th>
      <td>
         <xsl:value-of select="format-number(price,'$#,##0')" />
      </td>
      <td id="desc" rowspan="9">
         <xsl:value-of select="description" />
      </td>
   </tr>
   <tr>
      <td rowspan="4">
         <!-- Place Firm Data Here -->

      </td>
      <th>Sq. Feet</th>
      <td>
         <xsl:value-of select="sqfeet" />
      </td>
   </tr>
   <tr>
      <th>Address</th>
      <td>
         <xsl:value-of select="street" /><br />
         <xsl:value-of select="city" />, <xsl:value-of select="state" />
         <xsl:text> </xsl:text><xsl:value-of select="zip" />
      </td>
   </tr>
   <tr>
      <th>Baths</th>
      <td>
         <xsl:value-of select="bathrooms" />
      </td>
   </tr>
   <tr>
      <th>Bedrooms</th>
      <td>
         <xsl:value-of select="bedrooms" />
      </td>
   </tr>
   <tr>
      <th class="head2">Agent</th>	
      <th>Style</th>
      <td>
         <xsl:value-of select="style" />
      </td>
   </tr>
   <tr>
      <td rowspan="3">
         <!-- Place Agent Data Here -->

      </td>
      <th>Garage</th>
      <td>
         <xsl:value-of select="garage" />
      </td>
   </tr>
   <tr>
      <th>Age</th>
      <td>
         <xsl:value-of select="age" />
      </td>
   </tr>
   <tr>
      <th>Listing #</th>
      <td>
         <xsl:value-of select="@rln" />
      </td>
   </tr>

   </table>
</xsl:template>


</xsl:stylesheet>
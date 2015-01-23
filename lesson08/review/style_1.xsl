<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 8
   Review Assignment

   MidWest Homes XSLT style sheet
   Author: Efrem McCrimon
   Date:   3-29-2011

   Filename:         style.xsl
   Supporting Files: agencies.xml, logo.jpg, styles.css

-->
<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="agencies" select="document('agencies.xml')" />
<xsl:variable name="styleone" select="document('style.xml')" />
<xsl:key name="agentID" match="agent" use="@agentNum" />
<xsl:key name="firmID" match="firm" use="@firmNum" />

<xsl:key name="styles" match="property" use="style" />



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
           <xsl:apply-templates
               select="listings/property[not(style=preceding::property/style)]">
               <xsl:sort select="style" order="descending"></xsl:sort>
           </xsl:apply-templates>
      </div>


      <xsl:for-each select="//property[generate-id()=generate-id(key('styles', style)[1])]">
          <xsl:sort select="style"></xsl:sort>
          <h1 id="{generate-id()}"><xsl:value-of select="style"></xsl:value-of></h1>

          <xsl:apply-templates select="key('styles', style)">
              <xsl:sort select="sqfeet" order="descending" />
          </xsl:apply-templates>

      </xsl:for-each>


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
           <xsl:variable name="fID" select="@firm" />
           <xsl:for-each select="$agencies">
               <!-- Retrieve firm data -->
               <xsl:value-of select="key('firmID', $fID)/name" /><br />
               <xsl:value-of select="key('firmID', $fID)/street" /><br />
               <xsl:value-of select="key('firmID', $fID)/city" />,
               <xsl:value-of select="key('firmID', $fID)/state" /> &#160;&#160;
               <xsl:value-of select="key('firmID', $fID)/zip" /><br />
               <xsl:value-of select="key('firmID', $fID)/phone" /><br />
               <xsl:value-of select="key('firmID', $fID)/web" />
           </xsl:for-each>

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
           <xsl:variable name="aID" select="@agent" />
           <xsl:for-each select="$agencies">
               <!-- Retrieve agent data -->
               <xsl:value-of select="key('agentID', $aID)/name" /><br />
               <xsl:value-of select="key('agentID', $aID)/phone" /><br />
               <xsl:value-of select="key('agentID', $aID)/email" />
           </xsl:for-each>
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

<xsl:template match="property" >
    <xsl:value-of select="style"></xsl:value-of> |
</xsl:template>

</xsl:stylesheet>  
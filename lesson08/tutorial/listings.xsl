<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 8
   Tutorial Case

   MidWest Homes XSLT style sheet
   Author: Efrem McCrimon
   Date:   3-29-2011

   Filename:         listings.xsl
   Supporting Files: agents.xml, firms.xml, listings.css, logo.jpg

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="agents" select="document('agents.xml')" />
    <xsl:variable name="firms" select="document('firms.xml')" />
    <xsl:key name="agentID" match="agent" use="@id" />
    <xsl:key name="firmID" match="firm" use="@id" />
    
    <xsl:key name="cityNames" match="property" use="city" />

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
           <xsl:apply-templates
           select="listings/property[not(city=preceding::property/city)]">
               <xsl:sort select="city"></xsl:sort>
           </xsl:apply-templates>
      </div>

      <xsl:for-each select="//property[generate-id()=generate-id(key('cityNames',city)[1])]">
          <xsl:sort select="city"></xsl:sort>
          <h1 id="{generate-id()}"><xsl:value-of select="city"></xsl:value-of></h1>
          <xsl:apply-templates select="key('cityNames', city)">
              <xsl:sort select="price" order="descending" />
          </xsl:apply-templates>
      </xsl:for-each>


   
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
   <tr>
       <th colspan="2">Realty Agency</th>
       <th colspan="2">Agent</th>
   </tr>
   <tr>
       <td colspan="2">
           <xsl:variable name="fID" select="@firm" />
           <xsl:for-each select="$firms">
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
       <td colspan="2">
           <xsl:variable name="aID" select="@agent" />
           <xsl:for-each select="$agents">
               <!-- Retrieve agent data -->
               <xsl:value-of select="key('agentID', $aID)/name" /><br />
               <xsl:value-of select="key('agentID', $aID)/phone" /><br />
               <xsl:value-of select="key('agentID', $aID)/email" />
           </xsl:for-each>
       </td>
   </tr>
   </table>
</xsl:template>

<xsl:template match="property" mode="cityList">
    <a href="#{generate-id()}">
    <xsl:value-of select="city"></xsl:value-of>
    </a>
    (<xsl:value-of select="count(key('cityNames', city))" />) |
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8" ?>

<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 4

   Jazz Warehouse Specials Style Sheet
   Author:      Efrem McCrimon
   Date:   

   Filename:         jazz.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="cdlist" select="//cd" />

<xsl:template match="/">
   <link href="jazz.css" rel="stylesheet" type="text/css"/>
   <h3 class="title">CD Titles</h3>
   
   
   <xsl:apply-templates select="/specials">
      <xsl:sort select="cd" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="cd">
   <h3 class="title"><xsl:value-of select="text()" />( by <xsl:value-of select="artist" />)
   - <xsl:value-of select="price" />
   </h3>
   <br />


   <xsl:for-each select="track">
       <tr>     
           <td class="track">
               <xsl:value-of select="."/> - <xsl:value-of select="@length"/><br />
           </td>              
          
       </tr>
   </xsl:for-each>


</xsl:template>

</xsl:stylesheet>
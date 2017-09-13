<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 1, for Case 4

   CD Title Listings


   Filename:         details.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />
<xsl:param name="cdlist" select="//cd" />

<xsl:template match="/">
   <h2>CD Title:</h2>
   <xsl:apply-templates select="$cdlist">
      <xsl:sort select="cd" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="cd">
   <h3><xsl:value-of select="cd" />( by <xsl:value-of select="artist" />)</h3>
   <xsl:apply-templates select="track" />
</xsl:template>



<xsl:template match="track">
   <table class="today">
   <tr>
      <th class="today">Price</th>
      <th class="today">Tracks</th>

   </tr>
   <tr>
       <td><xsl:value-of select="price" /></td>
       <td>
           <xsl:for-each select="track">
               <tr>                   
                  <td><xsl:value-of select="track"/></td>
                  - <td><xsl:value-of select="@length"/></td>
               </tr>
           </xsl:for-each>
       </td>
   </tr>
   </table>
</xsl:template>

</xsl:stylesheet>


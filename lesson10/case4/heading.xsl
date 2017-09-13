<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 1

   Stock Reporter Heading
   Author:      Efrem McCrimon
   Date:   

   Filename:         heading.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />

<xsl:template match="/">
   <form id="cdform" name="cdform">


   <h1 class="title">The Jazz Warehouse</h1>
   <h2 class="title">CD Titles</h2>

   <table style="width: 300px">
   <tr>
      <td>
         <select  id="cdtitle" name="cdtitle" onchange="showReport()" >
            <option value="">Select a CD Title</option>
            <option value="all_titles">ALL CD TITLES</option>
            
            <xsl:apply-templates select="specials">
               <xsl:sort select="specials/cd" data-type="text" order="ascending" />
            </xsl:apply-templates>

         </select>
      </td>
      <td>Select a Report:<br />
         <input type="radio" name="reports" onclick="showReport()" /> Title details<br />
         <input type="radio" name="reports" onclick="showReport()" /> Price List
         
      </td>
   </tr>
   </table>

   </form>
</xsl:template>

<xsl:template match="specials">
   <option value="{cd}">
      <xsl:value-of select="artist" />
   </option>
</xsl:template>

</xsl:stylesheet>


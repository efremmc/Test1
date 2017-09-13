<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 1

   Stock Reporter Heading
   Author: 
   Date:   

   Filename:         heading.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />

<xsl:template match="/">
   <form id="stockform" name="stockform">

   <div id="datetime"><b>Last Updated: </b>
      <xsl:apply-templates select="portfolio/date" /> at
      <xsl:value-of select="portfolio/time" />
   </div>
   <h1 class="title">Hardin Financial</h1>
   <h2 class="title">Stock Reporter</h2>

   <table style="width: 300px">
   <tr>
      <td>
         <select id="symbol" name="symbol">
            <option value="">Select a Stock</option>
            <option value="all_stocks">ALL STOCKS</option>

            <xsl:apply-templates select="//stock">
               <xsl:sort select="name/@symbol" data-type="text" order="ascending" />
            </xsl:apply-templates>

         </select>
      </td>
      <td>Select a Report:<br />
         <input type="radio" name="reports" /> Stock Overview<br />
         <input type="radio" name="reports" /> Current Values<br />
         <input type="radio" name="reports" /> Five-Day Reports<br />
         <input type="radio" name="reports" /> Yearly Summaries
      </td>
   </tr>
   </table>

   </form>
</xsl:template>

<xsl:template match="stock">
   <option value="{name/@symbol}">
      <xsl:value-of select="name/@symbol" />
   </option>
</xsl:template>

</xsl:stylesheet>


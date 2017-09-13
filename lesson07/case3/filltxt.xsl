<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Case Problem 3

   Datalia XSLT Style Sheet
   Author: 
   Date:   

   Filename:         fill.xsl
   Supporting Files: fill.css, function.xsl
-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" />

<xsl:template match="/">
   <html>
      <head>
         <link href="fill.css" rel="stylesheet" type="text/css" />
      </head>
   <body>
      <h1>Datalia, Inc.</h1>
      <h3>Filler Sample Values</h3>
      <p><b>Date: </b> <xsl:value-of select="heads/date" /><br />
      </p>
      <table border="5" cellpadding="5">
      <tr>
         <th>Filler Head</th><th>N</th><th>Average</th><th>Minimum</th><th>Maximum</th><th>Std. Dev</th>
      </tr>
      <xsl:apply-templates select="heads/head" />
      </table>
   </body>
   </html>
</xsl:template>

<xsl:template match="head">
   <tr>
      <th class="row">
      </th>

      <td>
      </td>

      <td>
      </td>

      <td>
      </td>

      <td>
      </td>

      <td>
      </td>
   </tr>
</xsl:template>


</xsl:stylesheet>
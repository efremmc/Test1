<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 8
   Case Problem 1

   Best American Comedies XSLT Style Sheet
   Author: 
   Date:   

   Filename:         comedy.xsl
   Supporting Files: comedy.css
-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
   <html>
   <head>
      <title>Top American Comedies</title>
      <link href="comedy.css" rel="stylesheet" type="text/css" />
   </head>
   <body>
      <h2>The Top American Comedy Films</h2>

      <table>
      <tr>
          <th>Rank</th>
          <th>Movie</th>
          <th>Votes</th>
          <th>%</th>
      </tr>

      </table>
   
   </body>
   </html>
</xsl:template>

</xsl:stylesheet>
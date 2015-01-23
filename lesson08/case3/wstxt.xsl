<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 8
   Case Problem 3

   World Series XSLT Style Sheet
   Author: 
   Date:   

   Filename:         ws.xsl
   Supporting Files: ws.css
-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/">
   <html>
   <head>
      <title>World Series Statistics</title>
      <link href="ws.css" rel="stylesheet" type="text/css" />
   </head>
   <body>
      <h2>World Series Results</h2>


      <div id="div1h">World Series History</div>
      <div id="div1">
         <table>
         <tr><th>Year</th><th>Result</th></tr>

         </table>
      </div>


      <div id="div2h">Club Records</div>
      <div id="div2">
         <table>
         <tr>
            <th class="cname">Club</th><th>Series</th>
            <th>Won</th><th>Lost</th><th>Record</th>
         </tr>

         </table>
      </div>


      <div id="div3h">Club Appearances</div>
      <div id="div3">
         <table>
         <tr><th class="cname">Club</th><th>Year(s)</th></tr>


         </table> 
      </div>

   </body>
   </html>
</xsl:template>


</xsl:stylesheet>
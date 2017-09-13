<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Case Problem 1

   Election Results XSLT Style Sheet
   Author: 
   Date:   

   Filename:         polls.xsl
   Supporting Files: back.jpg, logo.jpg
-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" />

<xsl:template match="/">
   <html>
   <head>
      <title>Election Night Results</title>
      <link href="polls.css" rel="stylesheet" type="text/css" />
   </head>
   <body>
      <div id="intro">
         <p><img src="logo.jpg" alt="Election Day Results" /></p>
         <a href="#">Election Home Page</a>
         <a href="#">President</a>
         <a href="#">Senate Races</a>
         <a href="#">Congressional Races</a>
         <a href="#">State Senate</a>
         <a href="#">State House</a>
         <a href="#">Local Races</a>
         <a href="#">Judicial</a>
         <a href="#">Referendums</a>
      </div>

      <div id="results">
         <h1>Congressional Races</h1>
         <xsl:apply-templates select="polls/race" />
      </div>
   </body>
   </html>
</xsl:template>

<xsl:template match="race">
   <h2><xsl:value-of select="title" /></h2>
   <table cellpadding="1" cellspacing="1">
      <tr><th>Candidate</th><th class="num">Votes</th></tr>
      <xsl:apply-templates select="candidate" />
   </table>
</xsl:template>

<xsl:template match="candidate">
   <tr>
      <td class="name"><xsl:value-of select="name" /> (<xsl:value-of select="party" />)</td>
      <td class="num"><xsl:value-of select="votes" /></td>
   </tr>
</xsl:template>

</xsl:stylesheet>
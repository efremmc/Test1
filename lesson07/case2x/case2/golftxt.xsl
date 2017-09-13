<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Case Problem 2

   Golf Score XSLT Style Sheet
   Author: 
   Date:   

   Filename:         golf.xsl
   Supporting Files: golf.css
-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" />


<xsl:template match="/">
   <html>
   <head>
      <title><xsl:value-of select="tournament/name" /> / <xsl:value-of select="tournament/golfer/name" /></title>
      <link href="golf.css" rel="stylesheet" type="text/css" />
   </head>
   <body>
      <xsl:apply-templates select="tournament" />
   </body>
   </html>
</xsl:template>

<xsl:template match="tournament">
   <h1><xsl:value-of select="name" /></h1>
   <h5><xsl:value-of select="date" /></h5>
   <xsl:apply-templates select="golfer" />
</xsl:template>

<xsl:template match="golfer">
   <h3><xsl:value-of select="name" /></h3>
   <p></p>

   <xsl:apply-templates select="round">
      <xsl:sort select="@roundNumber" order="descending" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="round">
   <table  cellspacing="1" cellpadding="2" id="scorecard">
   <tr class="title">
      <th colspan="22">Round <xsl:value-of select="@roundNumber" /></th>
   </tr>

   <tr class="holeList">
      <th style="text-align: left">Hole</th><th>1</th><th>2</th><th>3</th>
      <th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th>
      <th class="sub">Out</th><th>10</th><th>11</th><th>12</th><th>13</th>
      <th>14</th><th>15</th><th>16</th><th>17</th><th>18</th>
      <th class="sub">In</th><th class="final">Total</th>
   </tr>

   <tr class="par">
      <th>Par</th>

   </tr>

   <tr class="scores">
      <th>Scores</th>

   </tr>

   <tr class="runningTotal">
      <th>Round Total</th>

   </tr>

   </table>
</xsl:template>


</xsl:stylesheet>
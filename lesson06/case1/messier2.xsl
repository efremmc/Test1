<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 6
   Case Problem 1

   Messier Objects XSLT Style Sheet
   Author:  Efrem McCrimon
   Date:   5-13-2011

   Filename:         messier.xsl
   Supporting Files: m01.jpg, m13.jpg, m16.jpg, m20.jpg, m27.jpg, m31.jpg,
                     m42.jpg, m51.jpg, m57.jpg, skyweb.css, skyweb.jpg
-->

<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      
      <xsl:output method="html" version="4.0" />



<xsl:template match="/">
<html>
<head>
<title> The Messier Objects </title>
<link href="skyweb.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<h1 id="logo"><img src="skyweb.jpg" alt="SkyWeb" /></h1>
</body>

</html>
</xsl:template>
<!--#5-->
<xsl:template match="distance|size|mag|ra|dec">
<table>
<tr>
<td>"."</td>
</tr>
</table>
</xsl:template>
<!--#7-->
<xsl:template match="object">
<div>
<h2>
<xsl:value-of select="messier/object"/>
(<xsl:value-of select="@id"/>)
</h2>
<for-each select="description/p{1}"/>
<for-each select="description/p">
<p><img src="id.jpg"/></p>
<xsl:value-of select="."/>
<xsl:value-of select="../../@id"/>

</for-each>
</div>

<apply-templates select="data"/>
</xsl:template>


<!--#6-->
<xsl:template match="data">
<table border="5">
<tr>
<th>Distance (light Years) </th>
<th>Size (arc min) </th>
<th>Magnitude </th>
<th>Right Acension </th>
<th>Declination </th>
</tr>
<tr>
<apply-templates select="data/distance"/>
<apply-templates select="data/size"/>
<apply-templates select="data/mag"/>
<apply-templates select="data/ra"/>
<apply-templates select="data/dec"/>
</tr>
</table>

</xsl:template>
</xsl:stylesheet> 

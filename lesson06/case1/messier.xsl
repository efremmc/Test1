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
            <title>The Messier Objects</title>
            <link href="skyweb.css" rel="stylesheet" type="text/css"></link>

        </head>
        <body>
            <h1 id="logo"><img src="skyweb.jpg" alt="SkyWeb" /></h1>

            <xsl:apply-templates select="distance"></xsl:apply-templates>
            <h1>The Messier Objects</h1>
            <xsl:apply-templates select="messier/object">
                  <xsl:sort select="id" /> 
            </xsl:apply-templates>
            
        </body>
    </html>
    
</xsl:template>



<xsl:template match="object">
    <div>
        <h2>

            <xsl:value-of select="name" />
            (<xsl:value-of select="@id" />)
        </h2>
            <xsl:for-each select="description/p[1]">
                <p><img src="{../../@id}.jpg" />
                   <xsl:value-of select="." />
                   <xsl:value-of select="../../@id" />
                </p>
            </xsl:for-each>
            <xsl:for-each select="description/p[position()>1]">
                <p><xsl:value-of select="." /></p>
            </xsl:for-each>
            
            <xsl:apply-templates select="data"></xsl:apply-templates>
        
    </div>

</xsl:template>


<xsl:template match="data">
    <td>
        <table border="5">
            <tr>
                <th>Distance (light years)</th>
                <th>Size (arc min)</th>
                <th>Magniudes</th>
                <th>Right Ascension</th>
                <th>Declination</th>
            </tr>
            <tr>
                <xsl:apply-templates select="distance" />
                <xsl:apply-templates select="size" />
                <xsl:apply-templates select="mag" />
                <xsl:apply-templates select="ra" />
                <xsl:apply-templates select="dec" />
            </tr>
        </table>


    </td>
</xsl:template>

<xsl:template match="distance|size|mag|ra|dec">
    <td><xsl:value-of select="."></xsl:value-of></td>
</xsl:template>

</xsl:stylesheet>

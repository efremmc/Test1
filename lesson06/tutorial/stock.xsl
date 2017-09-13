<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 6
   Tutorial Case

   Hardin Financial XSL Style Sheet
   Author: Efrem McCrimon
   Date:   02-25-2011
   


   Filename:         stock.xsl
   Supporting Files: down.gif, same.gif, stock.css, up.gif

-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      


<xsl:output method="html" version="4.0" />
  

<!-- A root template for stock.xml  -->
<xsl:template match="/" >
    <html>
    <head>
        <title>Stock Information</title>
        <link href="stock.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="datetime"><b>Last updated: </b>
          <xsl:value-of select="portfolio/date" /> at
          <xsl:value-of select="portfolio/time" />

        </div>
        <h1>Hardin Financial</h1>
        <h2>Stock Information</h2>

        <h2 class="category">Industrials</h2>
        <xsl:apply-templates select="portfolio/stock[category='Industrial']">
            <xsl:sort select="sName" />
        </xsl:apply-templates>

        <h2 class="category">Utilities</h2>
        <xsl:apply-templates select="portfolio/stock[category='Utilities']">
            <xsl:sort select="sName" />
        </xsl:apply-templates>

        <h2 class="category">Transportation</h2>
        <xsl:apply-templates select="portfolio/stock[category='Transportation']">
            <xsl:sort select="sName" />
        </xsl:apply-templates>


    </body>
    </html>

    
</xsl:template>

<xsl:template match="stock">
    <div>
        <xsl:apply-templates select="sName" />
        <xsl:apply-templates select="today" />
        <p> <xsl:value-of select="description" /></p>
        <p><xsl:apply-templates select="five_day" /></p>
    </div>
</xsl:template>


<xsl:template match="sName">
        <h3>
            <a href="{../link}">
            <xsl:value-of select="." />
            (<xsl:value-of select="@symbol" />)
            </a>
        </h3>
</xsl:template>

<xsl:template match="today">
    <table>
        <tr>
            <th>Current</th>
            <th>Open</th>
            <th>High</th>
            <th>Low</th>
            <th>Volume</th>

        </tr>
        <tr>
            <td>
                <xsl:choose>
                    <xsl:when test="@current &lt; @open">
                        <img src="down.gif" />
                    </xsl:when>
                    <xsl:when test="@current > @open">
                        <img src="up.gif" />
                    </xsl:when>
                    <xsl:otherwise>
                        <img src="same.gif" />
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="@current" />
            </td>
            <xsl:apply-templates select="@open" />
            <xsl:apply-templates select="@high" />
            <xsl:apply-templates select="@low" />
            <xsl:apply-templates select="@vol" />

        </tr>
    </table>
    
</xsl:template>

<xsl:template match="five_day">
    <table>
        <tr>
            <th colspan="6">Recent History</th>
        </tr>
        <tr>
            <th>Day</th>
            <th>Open</th>
            <th>High</th>
            <th>Low</th>
            <th>Close</th>
            <th>Volume</th>
        </tr>
        <xsl:apply-templates select="day">
            <xsl:sort data-type="number" order="descending" />
        </xsl:apply-templates>
    </table>
</xsl:template>

<xsl:template match="day">
    <tr>
        <xsl:apply-templates select="@date" />
        <xsl:apply-templates select="@open" />
        <xsl:apply-templates select="@high" />
        <xsl:apply-templates select="@low" />
        <xsl:apply-templates select="@close" />
        <xsl:apply-templates select="@vol" />
    </tr>
</xsl:template>

<xsl:template match="@open|@high|@low|@vol|@date|@close">
    <td><xsl:value-of select="." /></td>
</xsl:template>




</xsl:stylesheet>


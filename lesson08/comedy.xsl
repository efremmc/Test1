<?xml version="1.0" encoding="UTF-8" ?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:key name="movies" match="movie" use="."/> 

<xsl:variable name="single-movie" select="//movie[generate-id(.) = generate-id(key('movies', .))]/."/>
<xsl:template match="/">
<html>
<head>
<title>Top American Comedies</title>
<link href="comedy.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
<h2>The Top American Comedy Films</h2>
<table border="0" width="550">
<tr><td colspan="4">Number of the Ballots: <xsl:value-of select="count(poll/ballot)"/></td></tr>

<tr>
<th>%</th>
<th>Rank</th>
<th>Movie</th>
<th>Votes</th>

</tr>


<xsl:for-each select="$single-movie">

<xsl:sort select="count(key('movies', current()))" order="descending" data-type="number" />
<xsl:variable select="count(key('movies', current()))" name="votes" />
    <tr>
        <td align="right"><xsl:value-of select="format-number($votes div count(//ballot), '#.00%')" /></td>
        <td>
            <xsl:value-of select="position()" />.
        </td>
        <td>
            <xsl:value-of select="." /> 
        </td>
        <td align="right"><xsl:value-of select="$votes" /></td>
    </tr>
    <xsl:if test="position() mod 10 = 0">
    <tr>
        <td colspan="4"><hr /></td>
    </tr>
    </xsl:if>

</xsl:for-each>

</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

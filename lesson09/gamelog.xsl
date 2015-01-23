<?xml version='1.0' ?>
<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" />
<xsl:key name="player_key" match="action" use="@player" />
<xsl:key name="action_key" match="action" use="@action" />

<xsl:template match="/">
   <xsl:apply-templates select="game" />
</xsl:template>

<xsl:template match="game">
  <xsl:apply-templates select="plays" />
</xsl:template>

<xsl:template match="plays">
<table class="actions">
<tr><th>Game Log</th></tr>
<tr><td>
<select name="actionlist" size="30">
   <xsl:apply-templates select="play" />
</select>
</td></tr>
</table>
</xsl:template>

<xsl:template match="play">
   <option>
   [<xsl:value-of select="@time" />] <xsl:value-of select="@player" /> (<xsl:value-of select="@team" />) <xsl:value-of select="@action" />
   </option>
</xsl:template>

</xsl:stylesheet>
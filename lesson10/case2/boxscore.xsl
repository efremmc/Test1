<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 2

   Game Box Score Style Sheet


   Filename:         boxscore.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />

<xsl:template match="/">
   <xsl:apply-templates select="game" />
</xsl:template>

<xsl:template match="game">
   <xsl:apply-templates select="team" />
</xsl:template>

<xsl:template match="team">
   <xsl:variable name="team" select="@name" />
   <xsl:variable name="tfgmade2" select="count(//play[@team=$team and @action='makes 2-pt shot'])" />
   <xsl:variable name="tfgmade3" select="count(//play[@team=$team and @action='makes 3-pt shot'])" />
   <xsl:variable name="tfgmissed2" select="count(//play[@team=$team and @action='misses 2-pt shot'])" />
   <xsl:variable name="tfgmissed3" select="count(//play[@team=$team and @action='misses 3-pt shot'])" />
   <xsl:variable name="tfgm" select="$tfgmade2+$tfgmade3" />
   <xsl:variable name="tfga" select="$tfgm+$tfgmissed2+$tfgmissed3" />
   <xsl:variable name="tftm" select="count(//play[@team=$team and @action='makes free throw'])" />
   <xsl:variable name="tfta" select="count(//play[@team=$team and @action='misses free throw'])+$tftm" />
   <xsl:variable name="toff" select="count(//play[@team=$team and @action='grabs offensive rebound'])" />
   <xsl:variable name="tdef" select="count(//play[@team=$team and @action='grabs defensive rebound'])" />
   <xsl:variable name="ttotr" select="$toff+$tdef" />
   <xsl:variable name="tasst" select="count(//play[@team=$team and @action='assists'])" />
   <xsl:variable name="tst" select="count(//play[@team=$team and @action='steals ball'])" />
   <xsl:variable name="tto" select="count(//play[@team=$team and @action='commits turn-over'])" />
   <xsl:variable name="tpf" select="count(//play[@team=$team and @action='commits personal foul'])" />
   <xsl:variable name="tpts" select="2*$tfgmade2+3*$tfgmade3+$tftm" />

   <table class="bs">
   <tr>
      <th colspan="9" class="title">
         <xsl:value-of select="@name" /> [<xsl:value-of select="$tpts" />] 
      </th>
   </tr>
   <tr>
       <th>Player</th>
       <th>FGM-FGA</th>
       <th>FTM-FTA</th>
       <th>OFF-DEF-TOT</th>
       <th>ASST</th>
       <th>ST</th>
       <th>TO</th>
       <th>PF</th>
       <th>PTS</th>
   </tr>

   <xsl:apply-templates select="player" />

   <tr>
      <td colspan="9"><hr /></td>
   </tr>
   <tr>
      <td class="name">Total</td>
      <td>
         <xsl:value-of select="$tfgm" />-<xsl:value-of select="$tfga" />
      </td>
      <td>
         <xsl:value-of select="$tftm" />-<xsl:value-of select="$tfta" />
      </td>
      <td>
         <xsl:value-of select="$toff" />-<xsl:value-of select="$tdef" />-<xsl:value-of select="$ttotr" />
      </td>
      <td>
         <xsl:value-of select="$tasst" />
      </td>
      <td>
         <xsl:value-of select="$tst" />
      </td>
      <td>
         <xsl:value-of select="$tto" />
      </td>
      <td>
         <xsl:value-of select="$tpf" />
      </td>
      <td>
         <xsl:value-of select="$tpts" />
      </td>
   </tr>
   </table>

   <table class="tpfg">
   <tr>
      <td class="tpfg" width="100">Three-pt. FGs</td>
      <td class="tpfg" width="50">
         <xsl:value-of select="$tfgmade3" />
      </td>
      <td class="tpfg">
         <xsl:apply-templates select="player" mode="threepoints" />
      </td>
   </tr>
   </table>
</xsl:template>

<xsl:template match="player">
   <xsl:variable name="player" select="@name" />
   <xsl:variable name="fgmade2" select="count(//play[@player=$player and @action='makes 2-pt shot'])" />
   <xsl:variable name="fgmade3" select="count(//play[@player=$player and @action='makes 3-pt shot'])" />
   <xsl:variable name="fgmissed2" select="count(//play[@player=$player and @action='misses 2-pt shot'])" />
   <xsl:variable name="fgmissed3" select="count(//play[@player=$player and @action='misses 3-pt shot'])" />
   <xsl:variable name="fgm" select="$fgmade2+$fgmade3" />
   <xsl:variable name="fga" select="$fgm+$fgmissed2+$fgmissed3" />
   <xsl:variable name="ftm" select="count(//play[@player=$player and @action='makes free throw'])" />
   <xsl:variable name="fta" select="count(//play[@player=$player and @action='misses free throw'])+$ftm" />
   <xsl:variable name="off" select="count(//play[@player=$player and @action='grabs offensive rebound'])" />
   <xsl:variable name="def" select="count(//play[@player=$player and @action='grabs defensive rebound'])" />
   <xsl:variable name="totr" select="$off+$def" />
   <xsl:variable name="asst" select="count(//play[@player=$player and @action='assists'])" />
   <xsl:variable name="st" select="count(//play[@player=$player and @action='steals ball'])" />
   <xsl:variable name="to" select="count(//play[@player=$player and @action='commits turn-over'])" />
   <xsl:variable name="pf" select="count(//play[@player=$player and @action='commits personal foul'])" />
   <xsl:variable name="pts" select="2*$fgmade2+3*$fgmade3+$ftm" />

   <tr>
      <td class="name">
         <xsl:value-of select="@name" /> (<xsl:value-of select="@position" />)
      </td>
      <td>
         <xsl:value-of select="$fgm" />-<xsl:value-of select="$fga" />
      </td>
      <td>
         <xsl:value-of select="$ftm" />-<xsl:value-of select="$fta" />
      </td>
      <td>
         <xsl:value-of select="$off" />-<xsl:value-of select="$def" />-<xsl:value-of select="$totr" />
      </td>
      <td>
         <xsl:value-of select="$asst" />
      </td>
      <td>
         <xsl:value-of select="$st" />
      </td>
      <td>
         <xsl:value-of select="$to" />
      </td>
      <td>
         <xsl:value-of select="$pf" />
      </td>
      <td>
         <xsl:value-of select="$pts" />
      </td>
   </tr>
</xsl:template>

<xsl:template match="player" mode="threepoints">
      <xsl:variable name="player" select="@name" />
      <xsl:variable name="pmade3" select="count(//play[@player=$player and @action='makes 3-pt shot'])" />
      <xsl:if test="$pmade3 > 0">
         <xsl:value-of select="$player" /> (<xsl:value-of select="$pmade3" />) &#160;
      </xsl:if>
</xsl:template>

</xsl:stylesheet>
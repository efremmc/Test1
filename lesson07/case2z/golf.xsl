<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Case Problem 2

   Golf Score XSLT Style Sheet
   Author: Efrem MCCrimon
   Date:   

   Filename:         golf.xsl
   Supporting Files: golf.css, golf.xml
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
   <p>
       <b>Score: 
           <!---
            <xsl:value-of select="sum(round/score)" /> equals 284
            Par numbers:  4 4 5 3 4 4 5 3 4 4 5 4 3 4 5 4 3 4  = 72
            R1 numbers :  4 4 5 2 4 4 5 4 4 4 3 4 3 4 5 5 3 3  = ??
            Sum of par score:         -<xsl:value-of select="sum(//par)"/>
           -->
       <xsl:value-of select="sum(round/score//@holeNumber)" />-r2-r3-r4
       <xsl:value-of select="sum(//score)" />

       (<xsl:value-of select="sum(//score) - (sum(//par)*4)" />)
       </b>
   </p>

   <xsl:apply-templates select="round">
      <xsl:sort select="@roundNumber" order="ascending" />
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="round">
   <table  cellspacing="1" cellpadding="2" id="scorecard">
   <tr class="title">
      <th colspan="22">Round <xsl:value-of select="@roundNumber" /></th>
   </tr>
<!-- Display Row of Hole Numbers -->
   <tr class="holeList">
      <th style="text-align: left">Hole</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th class="sub">Out</th>
      <th>10</th>
      <th>11</th>
      <th>12</th>
      <th>13</th>
      <th>14</th>
      <th>15</th>
      <th>16</th>
      <th>17</th>
      <th>18</th>
      <th class="sub">In</th>
      <th class="final">Total</th>
   </tr>

   <tr class="par">
      <th>Par</th>
        <!-- 
        <th>Par<xsl:value-of select="par" /></th>
      Place Par Scores for First Nine Holes Here 
        <xsl:for-each select="//par">
            <th> <xsl:value-of select="." /></th>
        </xsl:for-each>


        <xsl:for-each select="//hole[Number &lt;= 9]">
            <td>
                <xsl:value-of select="@par"/>
            </td>
        </xsl:for-each>
        
        
        -->
        <!-- Place Par Subtotal for First Nine Holes Here -->
        <td class="sub">
            <xsl:value-of select="sum(//hole[Number &lt;= 9]/par)"/>
        </td>
        <!-- Place Par Scores for the Second Nine Holes Here -->
        <xsl:for-each select="//hole[Number > 9]">
            <td>
                <xsl:value-of select="@par"/>
            </td>
        </xsl:for-each>
        <!-- Place Par Subtotal for Second Nine Holes Here -->
        <td class="sub">
            <xsl:value-of select="sum(//hole[Number > 9]/par)"/>
        </td>
        <!-- Place Par Total for all Eighteen Holes Here -->
        <td class="final">
            <xsl:value-of select="sum(//par)"/>
        </td>      
    </tr>

   <tr class="scores">
      <th>Scores</th>
        <td>
        <!-- 
        
      Place  Scores for First Nine Holes Here
      
        <xsl:for-each select="//score">
            <th> <xsl:value-of select="." /></th>
        </xsl:for-each>
         -->
        </td> 
      
   </tr>

   <tr class="runningTotal">
      <th>Round Total</th>

   </tr>

   </table>
</xsl:template>

<xsl:template match="par">
    <td>
        <xsl:value-of select="//par" />
    </td>
    <xsl:choose>
        <xsl:when test="(par[@holeScore = 9])">
            <td class="sub">
                <!-- Frontnine pars  -->
                 <!--  

                  if the value of the holeNumber attribute = 9, then write 
                
                
                pars  -->

                <xsl:value-of select="holeScore"/>  
            </td>
        </xsl:when>
        <xsl:when test="(par[@holeNumber = 18])">
            <td class="sub">
                 <!-- backNine pars  -->
                 <!-- backNine 
                backNine pars is the SUM() of all par elements whose holeNumber attribute
                  is greater than 9 and less than equal to 18,
                  and ALL PARS is the SUM of ALL PAR elements in the source document.
                  
                  
                  if the value of the holeNumber attribute = 9, then write 
                
                
                pars  -->
                <xsl:value-of select="holeScore"/> 
            </td>
            <td class="final">
                <xsl:value-of select="//par"/>
            </td>
        </xsl:when>        
        <xsl:otherwise>
            <xsl:value-of select="holeScore" />
        </xsl:otherwise>

    </xsl:choose>   
</xsl:template>
 


<xsl:template match="formatHole">
    <xsl:param name="parScore"></xsl:param>
    <xsl:param name="holeScore"></xsl:param>

   
    <xsl:choose>
        <xsl:when test="($holeScore &lt; $parScore)">
            <td class="low">
                <xsl:value-of select="holeScore"/>
            </td>
        </xsl:when>
        <xsl:when test="($holeScore &gt; $parScore)">
            <td class="high">
                <xsl:value-of select="holeScore"/>
            </td>
        </xsl:when>        
        <xsl:otherwise>
            <xsl:value-of select="holeScore" />
        </xsl:otherwise>

    </xsl:choose>        

    

</xsl:template>

<xsl:template match="formatScore">
    <xsl:param name="scoreValue"></xsl:param>
    
    <xsl:if test="$scoreValue = 0">
        <xsl:choose>
            <xsl:when test="($scoreValue = 0)">
                <xsl:text>E</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="format-number($scoreValue,'-#;+#')" />
            </xsl:otherwise>
        
        </xsl:choose>        
    </xsl:if>


</xsl:template>



</xsl:stylesheet>
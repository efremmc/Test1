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
           Calculate the header part of the scores - below is my reference:
           
            <xsl:value-of select="sum(round/score)" /> equals 284
            Par numbers:  4 4 5 3 4 4 5 3 4 4 5 4 3 4 5 4 3 4  = 72
            R1 numbers :  4 4 5 2 4 4 5 4 4 4 3 4 3 4 5 5 3 3  = ??
            Sum of par score:         -<xsl:value-of select="sum(//par)"/>
            A for-each loop or for each @roundNumber 
<xsl:text>&nbsp;</xsl:text>
           -->
           
       <xsl:value-of select="sum(./round[@roundNumber=1]/score)" />-
       <!-- -r2-r3-r4  -->
       <xsl:value-of select="sum(./round[@roundNumber=2]/score)" />-
       <xsl:value-of select="sum(./round[@roundNumber=3]/score)" />-
       <xsl:value-of select="sum(./round[@roundNumber=4]/score)" />:&#160;
      
       <xsl:value-of select="sum(//score)" />

       (<xsl:value-of select="sum(//score) - (sum(//par)*4)" />)
       </b>
   </p>

   <xsl:apply-templates select="round">
      <xsl:sort select="@roundNumber" order="descending" />
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
      
      <xsl:apply-templates select="//par"></xsl:apply-templates>
     
   </tr>

  <!-- Calculate the score for the current round, need only the
       descendants of the content node named 'score', .//score
   -->
   <tr class="scores">
      <th>Scores</th>
      <xsl:apply-templates select=".//score"></xsl:apply-templates>
   </tr>

   <tr class="runningTotal">
      <th>Round Total</th>
      
      <xsl:call-template name="calcScores">
          <!--
          Context node is @roundNumber or "."
          -->
          <xsl:with-param name="currentRound" select="."></xsl:with-param>
          <xsl:with-param name="currentHole" select="1"></xsl:with-param>
      </xsl:call-template> 

   </tr>

   </table>
</xsl:template>


<xsl:template match="par">
    <td >
        <!-- Front nine pars  -->
        <xsl:value-of select="." />
    </td>    
    
    <xsl:choose>
           
        <xsl:when test="(@holeNumber = 18)">
            <td class="sub">
                <!-- Calculates the score total of strokes
                      and (@holdNumber &lt;= 18)]
                         We were given 18 hole numbers, 
                         too bad we can say @holeNumber &gt; 9..18
                -->
                <xsl:value-of select="sum(//par[(@holeNumber &gt; 9)] ) - sum(//par[@holeNumber &gt; 18]) " />
                
            </td>
            <td class="final">
                <xsl:value-of select="sum(//par)" />
            </td>
        </xsl:when>    
        
   
        <xsl:when test="(@holeNumber = 9)">
            <td class="sub">
                <xsl:value-of select="sum(//par[@holeNumber &lt;= 9])"/>
            </td>
        </xsl:when>
 
    </xsl:choose>   
    
  
</xsl:template>


<!--  Dispaly the score of each round  in score -->
<xsl:template match="score">
    <xsl:variable name="holeNum" select="@holeNumber"></xsl:variable>
    
    <!--    
    The trick language, for the parameters XML441:
    For the parScore parameter use the value of the par element whole holeNumber 
    aatribute equals the holeNum variable.
    This got me cofused and I went back to XML304-XML310 on References nodes
    
    -->
    <xsl:call-template name="formatHole">
        <xsl:with-param name="parScore" select="//par[@holeNumber=$holeNum]" />
        <xsl:with-param name="holeScore" select="."/>
    </xsl:call-template> 
    
    <xsl:choose>
        
        <xsl:when test="($holeNum = 18)">           
            <td class="sub">
                 <!-- Back nine pars  -->
                <xsl:value-of select="sum(../score[(@holeNumber &gt; 9) and (@holeNumber &lt;= 18)])"/> 
            </td>
            <td class="final">
                <xsl:value-of select="sum(../score)"/>
            </td>                                         
        </xsl:when>
        
        <xsl:when test="($holeNum = 9)">
            <td class="sub">
                 <!-- Front nine pars  -->
                <xsl:value-of select="sum(../score[@holeNumber &lt;= 9])"/>
            </td>                                  
        </xsl:when>        
        
    </xsl:choose>
    
</xsl:template>

<xsl:template name="calcScores">
    <xsl:param name="currentRound"></xsl:param>
    <xsl:param name="currentHole"></xsl:param>
      
        <!--        
          sum(//par[@holeNumber &lt;= @currentHole])            
            sum(//par/[(@holeNumber &lt;= $currentHole)])           
            next:
            select="sum(@currentRound/score[@holeNumber &lt; currentHole])"
        -->
    <xsl:variable name="parTotal" select=" sum(//par[@holeNumber &lt;= $currentHole])"></xsl:variable>
    <xsl:variable name="golferTotal" select="sum($currentRound/score[@holeNumber &lt;= $currentHole])"></xsl:variable>
        
    <xsl:variable name="currentScore" select="$parTotal - $golferTotal"></xsl:variable>
    <xsl:variable name="currentScoreText">
        <xsl:call-template name="formatScore">
            <xsl:with-param name="scoreValue" select="$currentScore"></xsl:with-param>
        </xsl:call-template>
    </xsl:variable>
   

    <td>
       <xsl:value-of select="$currentScoreText"/>
    </td>

    <xsl:choose>
        <xsl:when test="$currentHole = 18">
            <xsl:variable name="backNinePar" select="sum(par[(@holeNumber &gt; 9) and (@holeNumber &lt;= 18)])"></xsl:variable>
            <xsl:variable name="backNineGolfer" select="sum($currentRound/score[@holeNumber &gt; 9 and @holeNumber &lt;= 18])"></xsl:variable>
            <xsl:variable name="backNineScore" select="$backNinePar - $backNineGolfer"></xsl:variable>
            <!--
            Calculate the back nine using the formatScore template with the back nine score           
            -->
            <xsl:variable name="backNineScoreText" >
                <!--  We need the "Text String return message" -->
               
                <xsl:call-template name="formatScore">
                    <xsl:with-param name="scoreValue" select="$backNineScore"></xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            
            <td class="sub">
                <xsl:value-of select="$backNineScoreText" />
            </td>
            <td class="final">
                  <xsl:value-of select="$currentScoreText" />
            </td>           
            
        </xsl:when>
        <!--
        condition at hole9
        -->
        <xsl:when test="$currentHole = 9">
            <td class="sub">
                <xsl:value-of select="$currentScoreText" />
            </td>
        </xsl:when>
        
    </xsl:choose>
 <!--
    Write out the score using the template.
 -->  
    <xsl:if test="$currentHole &lt; 18">
        <xsl:call-template name="calcScores">
            <xsl:with-param name="currentRound" select="$currentRound"></xsl:with-param>
            <xsl:with-param name="currentHole" select="$currentHole+1"></xsl:with-param>
        </xsl:call-template> 
    </xsl:if>
        
</xsl:template>

<xsl:template name="formatHole">
    <xsl:param name="parScore"></xsl:param>
    <xsl:param name="holeScore"></xsl:param>
   
    <xsl:choose>
        
        <xsl:when test="($holeScore &lt; $parScore)" >
            <td class="low">
                <xsl:value-of select="$holeScore"/>
            </td>
        </xsl:when>
        <xsl:when test="($holeScore &gt; $parScore)">
            <td class="high">
                <xsl:value-of select="$holeScore"/>
            </td>
        </xsl:when>            

        <xsl:otherwise>
            <td>
                <xsl:value-of select="$holeScore" />
            </td>
            
        </xsl:otherwise>
        
    </xsl:choose>        

</xsl:template>

<xsl:template name="formatScore">
    <xsl:param name="scoreValue"></xsl:param>
    
    <xsl:choose>
        <xsl:when test="($scoreValue = 0)">
            <xsl:text>E</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="format-number($scoreValue,'-#;+#')" />
        </xsl:otherwise>

    </xsl:choose>        

</xsl:template>


</xsl:stylesheet>
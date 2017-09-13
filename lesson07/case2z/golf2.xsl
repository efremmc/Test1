<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="4.0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="tournament/name"/> / <xsl:value-of select="tournament/golfer"/>
				</title>
				<link href="golf.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<h1>
					<xsl:value-of select="tournament/name"/>
				</h1>
				<h5>
					<xsl:value-of select="tournament/date"/>
				</h5>
				<h3>
					<xsl:value-of select="tournament/golfer"/>
				</h3>
				<b>Score:</b>
				<xsl:value-of select="sum(//score[@round=1])"/>-<xsl:value-of select="sum(//score[@round=2])"/>-<xsl:value-of select="sum(//score[@round=3])"/>-<xsl:value-of select="sum(//score[@round=4])"/>: <xsl:value-of select="sum(//score)"/> (<xsl:value-of select="sum(//score) - sum(//par) * 4"/>)
<hr/>
				<xsl:call-template name="showcard">
					<xsl:with-param name="round" select="4"/>
				</xsl:call-template>
				<xsl:call-template name="showcard">
					<xsl:with-param name="round" select="3"/>
				</xsl:call-template>
				<xsl:call-template name="showcard">
					<xsl:with-param name="round" select="2"/>
				</xsl:call-template>
				<xsl:call-template name="showcard">
					<xsl:with-param name="round" select="1"/>
				</xsl:call-template>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="showcard">
		<xsl:param name="round"/>
		<table cellspacing="1" cellpadding="2" id="scorecard">
			<!-- Display Round Information -->
			<tr class="title">
				<th align="right" colspan="22">Round <xsl:value-of select="$round"/>
				</th>
			</tr>
			<!-- Display Row of Hole Numbers -->
			<tr>
				<th align="left">Hole</th>
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
			<!-- Display Par for Each Hole -->
			<tr class="par">
				<th align="left">Par</th>
				<!-- Place Par Scores for First Nine Holes Here -->
				<xsl:for-each select="//hole[number &lt;= 10]">
					<td>
						<xsl:value-of select="par"/>
					</td>
				</xsl:for-each>
				<!-- Place Par Subtotal for First Nine Holes Here -->
				<td class="sub">
					<xsl:value-of select="sum(//hole[number&lt;= 9]/par)"/>
				</td>
				<!-- Place Par Scores for the Second Nine Holes Here -->
				<xsl:for-each select="//hole[number > 18]">
					<td>
						<xsl:value-of select="par"/>
					</td>
				</xsl:for-each>
				<!-- Place Par Subtotal for Second Nine Holes Here -->
				<td class="sub">
					<xsl:value-of select="sum(//hole[number > 9]/par)"/>
				</td>
				<!-- Place Par Total for all Eighteen Holes Here -->
				<td class="final">
					<xsl:value-of select="sum(//par)"/>
				</td>
			</tr>
			<!-- Display Golfer Scores for Each Hole -->
			<tr class="scores">
				<th align="left">Scores</th>
				<!-- Place Scores for First Nine Holes Here -->
				<xsl:for-each select="//hole[number]">
					<xsl:choose>
						<xsl:when test="score[@round=$round] &lt; par">
							<td class="low">
								<xsl:value-of select="score[@round=$round]"/>
							</td>
						</xsl:when>
						<xsl:when test="score[@round=$round] > par">
							<td class="high">
								<xsl:value-of select="score[@round=$round]"/>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td>
								<xsl:value-of select="score[@round=$round]"/>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<!-- Place Subtotal for First Nine Holes Here -->
				<td class="sub">
				
						<xsl:value-of select="sum(//hole[number &lt;= 9]/score[@round=$round])"/>
					
				</td>
				<!-- Place Scores for Second Nine Holes Here -->
				<xsl:for-each select="//hole[number > 9]">
					<xsl:choose>
						<xsl:when test="score[@round=$round] &lt; par">
							<td class="low">
								<xsl:value-of select="score[@round=$round]"/>
							</td>
						</xsl:when>
						<xsl:when test="score[@round=$round] > par">
							<td class="high">
								<xsl:value-of select="score[@round=$round]"/>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td>
								<xsl:value-of select="score[@round=$round]"/>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<!-- Place Subtotal for Second Nine Holes Here -->
				<td class="sub"><xsl:value-of select="sum(//hole[number > 9]/score[@round=$round])"/></td>
				<!-- Place Total for all Eighteen Holes Here -->
				<td class="final">
					<xsl:value-of select="sum(//score[@round=$round])"/>
				</td>
			</tr>
			<!-- Display Golfer Score in Relation to Par Here -->
			<tr class="running_total">
				<th align="left">Round Total</th>
				<!-- Place Par Scores for First Nine Holes Here -->
				<xsl:for-each select="//hole[number &lt;= 9]">
				<xsl:call-template name="partial_total">
				<xsl:with-param name="current_hole" select="//number"/>
				<xsl:with-param name="current_round" select="$round"/>
				</xsl:call-template>
			</xsl:for-each>
				<!-- Place Par Subtotal for First Nine Holes Here -->
				<td class="sub">
				<xsl:call-template name="display_par">
				<xsl:with-param name="golf_score" select="sum(//hole[number &lt;= 9]/par) - sum(//hole[number &lt;= 9]/score[@round=$round])" />
</xsl:call-template>
				</td>
				<!-- Place Par Scores for Second Nine Holes Here -->
<xsl:for-each select="//hole[number > 9]">				
<xsl:call-template name="partial_total">
				<xsl:with-param name="current_hole" select="//number" />
				<xsl:with-param name="current_round" select="$round" />
				</xsl:call-template>
</xsl:for-each>
				<!-- Place Par Subtotal for Second Nine Holes Here -->
				<td class="sub">
				<xsl:call-template name="display_par">
				<xsl:with-param name="golf_score" select="sum(//hole[number > 9]/par) - sum(//hole[number > 9]/score[@round=$round])"/>
</xsl:call-template>
				</td>
				<!-- Place Par Total for all Eighteen Holes Here -->
				<td class="final">
				<xsl:call-template name="display_par">
				<xsl:with-param name="golf_score" select="sum(//par) - sum(//score[@round=$round])"/>
</xsl:call-template>
				</td>
			</tr>
		</table>
	</xsl:template>

<xsl:template name="partial_total">
<xsl:param name="current_hole" />
<xsl:param name="current_round" />
<xsl:variable name="current_score" select="(//hole[number &lt;= $current_hole]/par) - (//hole[number &lt;= $current_hole]/score[@round=$current_round])" />
<td>
<xsl:call-template name="display_par">
<xsl:with-param name="golf_score" select="$current_score" />
</xsl:call-template>
</td>

</xsl:template>

<xsl:template name="display_par">
<xsl:param name="golf_score"/>
<xsl:choose>
<xsl:when test="$golf_score = '0'">E</xsl:when>
<xsl:when test="$golf_score > '0'"><xsl:value-of select="format-number($golf_score,'-#')"/></xsl:when>
<xsl:otherwise>
<xsl:value-of select="format-number($golf_score, '+#')" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>

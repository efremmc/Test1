<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 7
   Tutorial Case

   Wizard Works Style Sheet Library
   Author: EFrem McCrimon
   Date:   3-8-2011

   Filename:         library.xsl
   Supporting Files: 

-->

<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="library.xsl" />
<xsl:param name="filter" select="''" />
<xsl:variable name="group" select="customers/customer [starts-with(@CID, $filter)]" />
<xsl:output method="html" version="4.o" /> 

<xsl:template name="totalCost">
    <xsl:param name="list"></xsl:param>
    <xsl:param name="total" select="0" />
    
    <!-- Calculate the total item cost -->
    <xsl:choose>
        <xsl:when test="$list">
            <!-- Calculate the first item -->
            <xsl:variable name="first" select="$list[1]/@qty * $list[1]/@price" />
            
            <!-- Call the totalCost template -->
            <xsl:call-template name="totalCost">
                <xsl:with-param name="list" select="$list[position() > 1]" />
                <xsl:with-param name="total" select="$first + $total" />
            </xsl:call-template>
            
        </xsl:when>
        <xsl:otherwise>
            <!-- Display the total cost -->
            <xsl:value-of select="format-number($total, '$#,#00.00')" />
        </xsl:otherwise>
    </xsl:choose>
    
</xsl:template>


</xsl:stylesheet>
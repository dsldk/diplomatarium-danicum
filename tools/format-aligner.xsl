<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="xs tei" version="2.0">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness//tei:physDesc">
    <physDesc xmlns="http://www.tei-c.org/ns/1.0">
      <xsl:if test="tei:objectDesc//tei:support/tei:ab[text()!='empty']">
        <xsl:value-of select="tei:objectDesc//tei:support/tei:ab[text()!='empty']"/><xsl:text>. </xsl:text>
      </xsl:if>
      <xsl:if test="tei:objectDesc//tei:extent//tei:width[text()!='0']">
        <xsl:value-of select="tei:objectDesc//tei:extent//tei:width"/><xsl:text> × </xsl:text> 
        <xsl:value-of select="tei:objectDesc//tei:extent//tei:height"/><xsl:text>. </xsl:text>
      </xsl:if>      
      <xsl:apply-templates select="tei:objectDesc//tei:condition/tei:ab[text()!='empty']"/>
      <xsl:apply-templates select="tei:handDesc//tei:ab[text()!='empty']"/>
      <xsl:apply-templates select="tei:additions//tei:ab[text()!='empty']"/>
      <xsl:for-each select="tei:sealDesc/tei:seal[@n!='0']">
        <xsl:value-of select="@n"/><xsl:text>. </xsl:text><xsl:value-of select="tei:ab[text()!='empty']"/><xsl:text>. </xsl:text>
      </xsl:for-each>
    </physDesc>
  </xsl:template>
  <xsl:template match="tei:q">
    <q xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates/></q>
  </xsl:template>
  <xsl:template match="tei:ex">
    <ex xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates/></ex>
  </xsl:template>
  <xsl:template match="tei:abstract//tei:ab">
    <ab xmlns="http://www.tei-c.org/ns/1.0">
      <xsl:apply-templates/><xsl:text> </xsl:text>
    </ab>
  </xsl:template>
</xsl:stylesheet>

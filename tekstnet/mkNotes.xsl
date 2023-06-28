<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="dest_dir" select="dest_dir"/>
    <xsl:variable name="file-name">
        <xsl:value-of select="substring-after(document-uri(), '_')"/>
    </xsl:variable>
    <xsl:template match="/">
        <xsl:if test="(//tei:text//tei:cit) | (//tei:text//tei:note)">
            <xsl:variable name="note_number">
                <xsl:number count="." level="single"/>
            </xsl:variable>
        <xsl:result-document href="toml/dd_{$file-name}.toml">
# Notes for dd_<xsl:value-of select="$file-name"/><xsl:text>
    
</xsl:text>        
            <xsl:for-each select=".//tei:text//tei:note | .//tei:text//tei:cit"> 
[drb<xsl:value-of select="position()"/>] 
lemma = "<xsl:value-of select="tei:quote/normalize-space()"/>"
note = "<xsl:choose>
    <xsl:when test="tei:bibl"><xsl:apply-templates select="tei:bibl"/></xsl:when>
    <xsl:otherwise><xsl:apply-templates select="normalize-space()"/></xsl:otherwise></xsl:choose>"
</xsl:for-each>
        </xsl:result-document>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:bibl"><xsl:apply-templates select="normalize-space()"/></xsl:template>
    <xsl:template match="tei:ref"><xsl:apply-templates select="normalize-space()"/></xsl:template>
    <xsl:template match="tei:q">_<xsl:value-of select="normalize-space(.)"/>_</xsl:template>
</xsl:stylesheet>

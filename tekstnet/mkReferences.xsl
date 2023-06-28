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
    <xsl:template match="tei:note|tei:cit">
        <xsl:variable name="noteNumber">
            <xsl:number count="tei:note|tei:cit" level="any" from="//tei:text"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="self::tei:note">
                <xsl:element name="ref" xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="target">drb<xsl:value-of select="$noteNumber"/>
                    </xsl:attribute>
                </xsl:element>
                
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="tei:quote"/><xsl:element name="ref" xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="target">drb<xsl:value-of select="$noteNumber"/></xsl:attribute>
            </xsl:element></xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>

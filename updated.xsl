<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:php="http://php.net/ns/releases"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

    <xsl:output method="text"/>

    <xsl:template match="atom:feed">
        <xsl:value-of select="atom:updated"/>
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei html" version="2.0">
    <xsl:output method="text"/>
    
    <!-- transform the root element (TEI) into an HTML template -->
    <xsl:template match="tei:TEI">
 
           <xsl:for-each select="//tei:line">
               <xsl:value-of select="."/>
               <xsl:text>&#xa;</xsl:text>
           </xsl:for-each>
   
    </xsl:template>


</xsl:stylesheet>

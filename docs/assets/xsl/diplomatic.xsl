<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei html" version="2.0">
    <xsl:output method="html"/>
    
    <!-- transform the root element (TEI) into an HTML template -->
    <xsl:template match="tei:TEI">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text><xsl:text>&#xa;</xsl:text>
        <html lang="en" xml:lang="en">
            <head>
                <title>
                    Essäer om Bror Barsk och andra dikter
                </title>
                <!-- load bootstrap css (requires internet!) so you can use their pre-defined css classes to style your html -->
                <link rel="stylesheet"
                    href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
                    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
                    crossorigin="anonymous"/>
                <!-- load the stylesheets in the assets/css folder, where you can modify the styling of your website -->
                <link rel="stylesheet" href="assets/css/main.css"/>
                <link rel="stylesheet" href="assets/css/desktop.css"/>
            </head>
            <body>
                <header>
                    <h1>
                        <xsl:apply-templates select="//tei:TEI//tei:title[@xml:id='source_title']"/>
                    </h1>
                </header>
                <nav id="sitenav">
                    <a href="index.html">Om</a> |
                    <a href="text_image.html">Bild/text</a> |
                    <a href="image.html">Bild</a> |
                    <a href="text.html">Text</a> |
                </nav>
                <main id="manuscript">
                    <!-- bootstrap "container" class makes the columns look pretty -->
                    <div class="container">
                        <!-- define a row layout with bootstrap's css classes (two columns) -->
                        <div class="row">
                            <!-- first column: load the image based on the IIIF link in the graphic above -->
                            <div class="col-sm">
                                <article id="thumbnail">
                                    <img>
                                        <xsl:attribute name="src">
                                            <xsl:value-of select="//tei:sourceDoc/tei:surface//tei:graphic/@url"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="//tei:sourceDoc/tei:surface//tei:graphic[@xml:id='sid_9']//tei:label"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:value-of select="//tei:sourceDoc/tei:surface//tei:graphic[@xml:id='sid_9']//tei:figDesc"/>
                                        </xsl:attribute>
                                    </img>
                                </article>
                            </div>
                            <!-- second column: apply matching templates for anything nested underneath the tei:text element -->
                            <div class="col-sm">
                                <article id="transcription">
                                    <h3>Transkribering</h3>
                                    <xsl:for-each select="//tei:line">
               <xsl:value-of select="."/>
               <br/>
           </xsl:for-each>
                                </article>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm">
                            <article id="details">
                                <p>
                                    <strong>Författare:</strong><br/>
                                    <xsl:apply-templates select="//tei:TEI//tei:author [@xml:id='source_author']"/>
                                </p>
                                <p>
                                    <strong>Källtext publicerad:</strong><br/>
                                    <xsl:apply-templates select="//tei:TEI//tei:sourceDesc//tei:date"/>
                                </p>
                                <p>
                                    <strong>Källtext publicerad av:</strong><br/>
                                    <xsl:apply-templates select="//tei:TEI//tei:sourceDesc//tei:publisher"/>
                                </p>
                                <p>
                                    <strong>Transkriberat av:</strong><br/>
                                    <xsl:apply-templates select="//tei:TEI//tei:name [@xml:id='transcribe']"/>
                                </p>
                                <p>
                                    <strong>Digitaliserat av:</strong><br/>
                                    <xsl:apply-templates select="//tei:TEI//tei:name [@xml:id='digitise']"/>
                                </p>
                                <p>
                                    <strong>Kommentarer till transkriberingen:</strong>
                                    <xsl:apply-templates select="//tei:TEI//tei:encodingDesc"/>
                                </p>
                            </article>
                        </div>
                    </div>
                </main>
                <footer>
                <div class="row" id="footer">
                  <div class="col-sm copyright">
                      <div class="copyright_logos"> 
                        © Bengt Emil Johnson
                      </div>
                      <div>
                         2022.
                      </div>
                    </div>
                </div>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- by default all text nodes are printed out, unless something else is defined.
    We don't want to show the metadata. So we write a template for the teiHeader that
    stops the text nodes underneath (=nested in) teiHeader from being printed into our
    html-->
    <xsl:template match="tei:teiHeader"/>

    <!-- turn tei linebreaks (line) into html linebreaks (br) -->
    <xsl:template match="tei:line">
        <br/>
    </xsl:template>
    <!-- not: in the previous template there is no <xsl:apply-templates/>. This is because there is nothing to
    process underneath (nested in) tei lb's. Therefore the XSLT processor does not need to look for templates to
    apply to the nodes nested within it.-->

    <!-- we turn the tei head element (headline) into an html h1 element-->
    <xsl:template match="tei:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <!-- transform tei paragraphs into html paragraphs -->
    <xsl:template match="tei:p">
        <p>
            <!-- apply matching templates for anything that was nested in tei:p -->
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- transform tei del into html del -->
    <xsl:template match="tei:del">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>

    <!-- transform tei add into html sup -->
    <xsl:template match="tei:add">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <!-- transform tei hi (highlighting) with the attribute @rend="u" into html u elements -->
    <!-- how to read the match? "For all tei:hi elements that have a rend attribute with the value "u", do the following" -->
    <xsl:template match="tei:hi[@rend = 'u']">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>


</xsl:stylesheet>

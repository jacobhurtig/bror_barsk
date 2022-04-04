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
                                        <xsl:value-of select="test"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">
                                        <xsl:value-of select="test"/>
                                    </xsl:attribute>
                                </img>
                               </article>
                            </div>
                            <!-- second column: apply matching templates for anything nested underneath the tei:text element -->
                            <div class="col-sm">
                                <article id="transcription">
                                  <p>
                                    <strong>Om:</strong>
                                    <xsl:apply-templates select="//tei:TEI//tei:projectDesc"/>
                                  </p>
                                </article>
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
                                </article>
                            </div>
                        </div>
                        </div>
                </main>
                <footer>
                    <div class="row" id="footer">
                        <div class="col-sm copyright">
                            <div>
                                <a href="https://creativecommons.org/licenses/by/4.0/legalcode">
                                    <img src="assets/img/logos/cc.svg" class="copyright_logo" alt="Creative Commons License"/><img src="assets/img/logos/by.svg" class="copyright_logo" alt="Attribution 4.0 International"/>
                                </a>
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
</xsl:stylesheet>

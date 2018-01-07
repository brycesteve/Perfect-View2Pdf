# View2Pdf

![Swift](http://img.shields.io/badge/swift-4.0-orange.svg)

This project is intended to create PDF files from html strings using
[wkhtmltopdf](http://wkhtmltopdf.org/).  There are also helpers to create pdf files straight from your mustache views.

Css is mostly supported either inline, or from absolute urls.  Relative links can be problematic, as the files are rendered in a tmp directory.


## Versions
First working release is tagged "1.1.0"

_This module was created to satisfy a requirement for my project. If you find any bugs, or it doesn't satisfy your needs, then please feel free to modify it._

# Quick Start

Install wkhtmltopdf on your server. 

NOTE: The screen dpi affects pdf creation.  As I only use this for rendering from a linux server it works for what I need.
If you want pdfs to render correctly on another os (macOS), then you will have to tweak your font sizes.
For accurate layout, css percentage widths are recommended

MacOS:
``` 
brew install wkhtmltopdf

```

Linux:
``` bash
#Linux apt-get package for wkhtmltopdf won't run headless, so this installer will install a version that will
wget https://raw.githubusercontent.com/brycesteve/Perfect-View2Pdf/master/wkhtml_install.sh && chmod +x ./wkhtml_install.sh && ./wkhtml_install.sh

#Whilst this isn't required to run, I have found that on Linux, for better rendering of pdf better fonts are required.  I installed Windows fonts with:
sudo apt-get install ttf-mscorefonts-installer
#However, this was a personal choice, and any other fonts may be installed to match your css.
```

Configure Package.swift:

``` swift
.package(url: "https://github.com/brycesteve/Perfect-View2Pdf.git", from: "1.1.0")

...

.target( name: "YourProjectName",
	dependencies: ["View2Pdf"]),
	
```

Import library into your code:

``` swift
import View2Pdf
```

To create a PDF from a html string, create and configure a `PdfDocument`, add one or more `PdfPage`s,
and then call `toPDF()`.


``` swift
import View2Pdf

// Create document. Margins in mm, can be set individually or all at once.
// If no margins are set, the default is 20mm.
let document = PdfDocument(margins: 15)

// Create a page from an HTML string.
let page = PdfPage("<p>Page from HTML String</p>")

// Add the pages to the document
document.pages = [page]

// Render to a PDF
let pdf = try document.toPdf()

// Now you can return the PDF as a response
response.addHeader(HTTPResponseHeader.Name.contentType, value: "application/pdf")
response.status = .ok
response.setBody(bytes: (pdf.exportBytes(count: (pdf.availableExportBytes))))
response.completed()
```

### Mustache Helpers

Two helpers are available for Perfect-Mustache to return a pdf file in your RequestHandler

One will return a pdf view, and the other will return a pdf file download.

``` swift
import View2Pdf

//Create context if required
var ctx = [String:Any]()
ctx["pageTitle"] = "Home"

try? response.renderPdfFile(template: "/test/pdf", downloadFileName: "test.pdf", context: ctx)

//OR

try? response.renderPdfView(template: "/test/pdf", context: ctx)

```

`context` is optional.  There is a further parameter for these helpers `documentRoot`.  This defaults to "./webroot", you only need to use this, if you use something other than webroot for you mustache templates.


### Acknowledgements

This project uses [wkhtmltopdf](https://wkhtmltopdf.org) and is heavily based on the Vapor module [wkhtmltopdf](https://github.com/vapor-community/wkhtmltopdf)
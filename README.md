# View2Pdf

![Swift](http://img.shields.io/badge/swift-4.0-orange.svg)

This project is intended to create PDF files from html strings using
[wkhtmltopdf](http://wkhtmltopdf.org/).  There are also helpers to create pdf files straight from your mustache views.

Css is mostly supported either inline, or from absolute urls.  Relative links can be problematic, as the files are rendered in a tmp directory.


## Quick Start

## NOTE: This project is still in development
#### Please do not use this module in your apps, as it is currently incomplete

Install wkhtmltopdf on your server. 

NOTE: The screen dpi affects pdf creation.  As I only use this for rendering from a linux server it works for what I need.
If you want pdfs to render correctly on another os (macOS), then you will have to tweak your font sizes.
For accurate layout, css percentaage widths are recommended

MacOS:
``` 
brew install wkhtmltopdf

```

Linux:
```
//Linux apt-get package for wkhtmltopdf won't run headless, so this installer will install a version that will
wget https://raw.githubusercontent.com/brycesteve/Perfect-View2Pdf/master/wkhtml_install.sh && chmod +x ./wkhtml_install.sh && ./wkhtml_install.sh

//Whilst this isn't required to run, I have found that on Linux, for better rendering of pdf better fonts are required.  I installed Windows fonts with:
sudo apt-get install ttf-mscorefonts-installer
//However, this was a personal choice, and any other fonts may be installed to match your css.
```

Configure Package.swift:

``` swift
.package(url: "https://github.com/brycesteve/Perfect-View2Pdf.git", from: "1.0.0")

...

.target( name: "YourProjectName",
	dependencies: ["View2Pdf"]),
	
```

Import library into your code:

``` swift
import View2Pdf
```

To create a PDF from a view, create and configure a `PdfDocument`, add one or more `PdfPage`s,
and then call `toPDF()`.


```
import View2Pdf

// Create document. Margins in mm, can be set individually or all at once.
// If no margins are set, the default is 20mm.
let document = PdfDocument(margins: 15)

// Create a page from an HTML string.
let page = PdfPage("<p>Page from HTML String</p>")

// Create a page from a mustache template
let mustachePage = PdfPage(TODO)
])

// Add the pages to the document
document.pages = [page, mustachePage]

// Render to a PDF
let pdf = try document.toPdf()

// Now you can return the PDF as a response, if you want
let response = Response(status: .ok, body: .data(pdf))
response.headers["Content-Type"] = "application/pdf"
return response
```

### Acknowledgements

This project uses [wkhtmltopdf](https://wkhtmltopdf.org) and is heavily based on the Vapor module [wkhtmltopdf](https://github.com/vapor-community/wkhtmltopdf)
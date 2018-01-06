# View2Pdf

![Swift](http://img.shields.io/badge/swift-4.0-orange.svg)

This project is intended to create PDF files from html strings using
[wkhtmltopdf](http://wkhtmltopdf.org/).  There are also helpers to create pdf files straight from your mustache views.

## Quick Start

## NOTE: This project is still in development
#### Please do not use this module in your apps, as it is currently incomplete

Install wkhtmltopdf on your server.

MacOS:
``` 
brew install wkhtmltopdf

```

Linux:
```
apt-get install wkhtmltopdf
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
TODO: Add example
```

### Acknowledgements

This project uses [wkhtmltopdf](https://wkhtmltopdf.org) and is heavily based on the Vapor module [wkhtmltopdf](https://github.com/vapor-community/wkhtmltopdf)
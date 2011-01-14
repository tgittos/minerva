minerva
=======

minerva is a document/ebook library management tool.

If you've ever used Safari Books Online, they have the capability of searching and reading ebooks online. This tool is an effort to duplicate this for the home user, with their own libraries.

Requirements
============

* Ruby 1.9 (that's what I'm using to develop it)
* Rails 3.03 (again, that's what I'm using)
* [SWFTools](http://www.swftools.org) installed
* [Ghostscript](http://www.ghostscript.com) installed
* [xpdf](http://www.foolabs.com/xpdf/) installed

Features
========

* Bootstrapped FlexPaper viewer
* Ruby file to do the conversion from pdf to swf
* Ruby file to sanitise and extract text from the pdf

Technical
=========

* Uses Rails for the interface
* MySQL for the backend
* SWFTools for pdf conversion
* [flexpaper](http://flexpaper.devaldi.com/) viewer

Notes
=====

This is still very much a work in progress

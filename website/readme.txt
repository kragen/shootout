The Computer Language Benchmarks Game PHP pages Release 2.11
===========================================================

The PHP files in the different websites directories just include
the "real" PHP files from the lib directory.

The "real" PHP files instantiate a page template with a body template
from the lib directory. 
The templates pull together content from the data directory.

The csv files in the data directory can be edited in a spreadsheet.
Edit the csv files to hide any benchmark, language, or program.


websites directory
==================
config.php      Set file paths, set constants for this particular site

index.php, faq.php, benchmark.php, chart.php, io.php, benchmark.css 

                Links to the real page definitions in the lib directory

Optional customized lang.csv & test.csv 
    

dev directory
================
Same as "fp site" but include languages marked as dev "X"





lib directory
=============

blib.php, lib.php  Library functions        
      
benchmark.php      benchmarks, rankings, programs and scorecard

chart.php          PNG charts for each benchmark

faq.php            FAQ page

home.php           home page

io.php             input files & output files




lib directory templates
=======================

page.tpl.php       Default page template

faq.tpl.php        FAQ content

benchmark.tpl.php  Benchmarks content template

ranking.tpl.php    Rankings content template

program.tpl.php    Programs content template

scorecard.tpl.php  Scorecard content template

pre.tpl.php        Pre-formated text template


homepage.tpl.php   Homepage page template

home.tpl.php       Homepage content template




data 
====

lang.csv        Every language that can be shown

test.csv        Every benchmark test that can be shown

data.csv        Every program that can be shown

*.about         HTML text about a language, benchmark, or program 

*.code          Program source code

*.log           Program build log and run log


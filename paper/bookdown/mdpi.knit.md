--- 
Title: "R bookdownplus: Authoring Articles, Mails, Guitar Chords, Chemical Molecular Formulae and Equations with R bookdown"
date: "Sep. 3, 2018"
# Authors, for the paper (add full first names)
Author: "Peng Zhao, Samwell Tarly and Lyanna Mormont*"
#Authors, for metadata in PDF
AuthorNames: "Peng Zhao, Samwell Tarly and Lyanna Mormont"
# Affiliations / Addresses (Add [1] after \address if there is only one affiliation.)
address: "Innsbruck, Citadel, Bear Island"

#Contact information of the corresponding author
corres: "Correspondence: e-mail@e-mail.com; Tel.: +x-xxx-xxx-xxxx"

# Current address and/or shared authorship
firstnote: "Current address: Affiliation 3"
secondnote: "These authors contributed equally to this work."
# The commands \thirdnote{} till \eighthnote{} are available for further notes

# Keywords
keyword: "dragon; dagger; bear; keyword 3 (list three to ten pertinent keywords specific to the article, yet reasonably common within the subject discipline.)"
abstract: " Everyone knows that `bookdown` is an excellent package for authoring books on programming languages. But it is only one side of the coin.  It can do more than expected. Therefore I am developing `bookdownplus`. `bookdownplus` is an extension of `bookdown`. It helps you write academic journal articles, guitar books, chemical equations, mails, calendars, and diaries."
acknowledgements: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
doinum: "10.3390/------"
pubvolume: "xx"
pubyear: "2017"
copyrightyear: "2017"
externaleditor: "Academic Editor: name"
history: "Received: date; Accepted: date; Published: date"

supplementary: "The following are available online at www.mdpi.com/link, Figure S1: title, Table S1: title, Video S1: title."

acknowledgments: "All sources of funding of the study should be disclosed. Please clearly indicate grants that you have received in support of your research work. Clearly state if you received funds for covering the costs to publish in open access."

authorcontributions: "For research articles with several authors, a short paragraph specifying their individual contributions must be provided. The following statements should be used ``X.X. and Y.Y. conceived and designed the experiments; X.X. performed the experiments; X.X. and Y.Y. analyzed the data; W.W. contributed reagents/materials/analysis tools; Y.Y. wrote the paper.'' Authorship must be limited to those who have contributed substantially to the work reported."

conflictsofinterest: "The authors declare no conflict of interest. The founding sponsors had no role in the design of the study; in the collection, analyses, or interpretation of data; in the writing of the manuscript, and in the decision to publish the results." 

abbreviations: "The following abbreviations are used in this manuscript: GOT: Games of Thrones."

journal: atmosphere #actuators, admsci, aerospace, agriculture, agronomy, algorithms, animals, antibiotics, antibodies, antioxidants, applsci, arts, atmosphere, atoms, axioms, batteries, bdcc, behavsci, beverages, bioengineering, biology, biomedicines, biomimetics, biomolecules, biosensors, brainsci, buildings, carbon, cancers, catalysts, cells, challenges, chemengineering, chemosensors, children, chromatography, climate, coatings, computation, computers, condensedmatter, cosmetics, cryptography, crystals, data, dentistry, designs, diagnostics, diseases, diversity, econometrics, economies, education, electronics, energies, entropy, environments, epigenomes, fermentation, fibers, fishes, fluids, foods, forests, fractalfract, futureinternet, galaxies, games, gastrointestdisord, gels, genealogy, genes, geosciences, geriatrics, healthcare, horticulturae, humanities, hydrology, informatics, information, infrastructures, inorganics, insects, instruments, ijerph, ijfs, ijms, ijgi, ijtpp, inventions, jcdd, jcm, jcs, jdb, jfb, jfmk, jimaging, jof, jintelligence, jlpea, jmmp, jmse, jpm, jrfm, jsan, land, languages, laws, life, literature, logistics, lubricants, machines, magnetochemistry, marinedrugs, materials, mathematics, mca, mti, medsci, medicines, membranes, metabolites, metals, microarrays, micromachines, microorganisms, minerals, molbank, molecules, mps, nanomaterials, ncrna, neonatalscreening, nitrogen, nutrients, ohbm, particles, pathogens, pharmaceuticals, pharmaceutics, pharmacy, philosophies, photonics, plants, polymers, proceedings, processes, proteomes, publications, quaternary, qubs, recycling, religions, remotesensing, resources, risks, robotics, safety, scipharm, sensors, separations, sexes, sinusitis, socsci, societies, soilprocesses, soils, sports, standards, sustainability, symmetry, systems, technologies, toxics, toxins, tropicalmed, universe, urbansci, vaccines, vetsci, viruses, vision, water
article: article # addendum, article, benchmark, book, bookreview, briefreport, casereport, changes, comment, commentary, communication, conceptpaper, correction, conferenceproceedings, conferencereport, expressionofconcern, meetingreport, creative, datadescriptor, discussion, editorial, essay, erratum, hypothesis, interestingimage, letter, newbookreceived, opinion, obituary, projectreport, reply, reprint, retraction, review, perspective, preprints, protocol, shortnote, supfile, technicalnote, viewpoint
output:
  bookdown::pdf_book:
    template: tex/template_article_mdpi.tex
    keep_tex: yes
    citation_package: natbib
#    latex_engine: xelatex
    toc_depth: 3
    toc_unnumbered: no
    toc_appendix: yes
    quote_footer: ["\\begin{flushright}", "\\end{flushright}"]
bibliography: [bib/bib.bib]
biblio-style: apalike
link-citations: yes
colorlinks: no  
# toc: no
lot: no
lof: no
site: bookdown::bookdown_site
---

<!--chapter:end:index.Rmd-->

# Introduction

The R package `bookdownplus` [@R-bookdownplus] is an extension of `bookdown` [@R-bookdown]. It is a collection of
multiple templates on the basis of LaTeX, which are tailored so that I can work happily under the umbrella of `bookdown`. `bookdownplus` helps you write academic journal articles, guitar books, chemical equations, mails, calendars, and diaries.

`bookdownplus` extends the features of `bookdown`, and simplifies the procedure. Users only have to choose a template, clarify the book title and author name, and then focus on writing the text. No need to struggle in YAML and LaTeX. 

With `bookdownplus` users can

-   record guitar chords,

-   write a mail in an elegant layout,

-   write a laboratory journal, or a personal diary,

-   draw a monthly or weekly or conference calendar,

-   and, of course, write academic articles in your favourite way,

-   with chemical molecular formulae and equations,

-   even in Chinese,

-   and more wonders will come soon.

Full documentation can be found in the book [R bookdownplus Textbook](https://bookdown.org/baydap/bookdownplus). The webpage looks so-so, while the [pdf file](https://bookdown.org/baydap/bookdownplus/bookdownplus.pdf) might give you a little surprise.  

# Materials and Methods

Although this section might not be the latest version, the general idea won't change. Please see [R bookdownplus Textbook](https://bookdown.org/baydap/bookdownplus) to keep up with the update.

## Preparation

Before starting, you have to install R, RStudio, bookdown package, and
other software and packages (i.e. Pandoc, LaTeX, rmarkdown, rticle,
knitr, etc.) which bookdown depends on. See the official [manual](https://bookdown.org/yihui/bookdown/) of
bookdown for details. Additionally, if you want to produce a poster, phython must be installed before using, and the path of phython might have to be added to the environmental variables for Windows users.

## Installation

```
install.package("bookdownplus")
# or
devtools::
  install_github("pzhaonet/bookdownplus")
```

## Generate demo files

Run the following codes, and you will get some files (e.g. `index.Rmd`, `body.Rmd`, `bookdownplus.Rproj`) and folders in your working directory.

```
getwd() # this is your working directory. run setwd() to change it.
bookdownplus::bookdownplus()
```

## Build a demo book

Now open `bookdownplus.Rproj` with RStudio, and press `ctrl+shift+b` to compile it. Your will get a book file named `*.pdf` in `_book/`folder.

## Write your own

Write your own text in `index.Rmd` and `body.Rmd`, and build your own lovely book.

## More outputs

By default, the book is in a pdf file. From 'bookdownplus' 1.0.3, users can get more output formats, including 'word', 'html' and 'epub'. Run:

```
bookdownplus::
  bookdownplus(template = 'article', 
               more_output = c('html', 'word', 'epub'))
```

## Recommendations

I have been developing some other packages, which bring more features into 'bookdown', such as:

- mindr [@R-mindr], which can extract the outline of your book and turn it into a mind map, and

- pinyin [@R-pinyin], which can automatically generate ['{#ID}'](https://bookdown.org/yihui/bookdown/cross-references.html) of the chapter headers even if there are Chinese characters in them.

Both of them have been released on CRAN and can be installed via:

```
install.packages('mindr')
install.packages('pinyin')
```

Enjoy your bookdowning!

## Models

Eq. \@ref(eq:mc2) is an equation.

\begin{equation} 
E = mc^2
  (\#eq:mc2)
\end{equation} 

It can be written as $E = mc^2$.


# Results and Discussions

Fig. \@ref(fig:fig1) psum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

\begin{figure}

{\centering \includegraphics[width=0.8\linewidth]{mdpi_files/figure-latex/fig1-1} 

}

\caption{caption}(\#fig:fig1)
\end{figure}

Tab. \@ref(tab:tab1) psum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

\begin{table}

\caption{(\#tab:tab1)Here is a nice table!}
\centering
\begin{tabular}[t]{rrrrl}
\toprule
Sepal.Length & Sepal.Width & Petal.Length & Petal.Width & Species\\
\midrule
5.1 & 3.5 & 1.4 & 0.2 & setosa\\
4.9 & 3.0 & 1.4 & 0.2 & setosa\\
4.7 & 3.2 & 1.3 & 0.2 & setosa\\
4.6 & 3.1 & 1.5 & 0.2 & setosa\\
5.0 & 3.6 & 1.4 & 0.2 & setosa\\
\addlinespace
5.4 & 3.9 & 1.7 & 0.4 & setosa\\
4.6 & 3.4 & 1.4 & 0.3 & setosa\\
5.0 & 3.4 & 1.5 & 0.2 & setosa\\
4.4 & 2.9 & 1.4 & 0.2 & setosa\\
4.9 & 3.1 & 1.5 & 0.1 & setosa\\
\addlinespace
5.4 & 3.7 & 1.5 & 0.2 & setosa\\
4.8 & 3.4 & 1.6 & 0.2 & setosa\\
4.8 & 3.0 & 1.4 & 0.1 & setosa\\
4.3 & 3.0 & 1.1 & 0.1 & setosa\\
5.8 & 4.0 & 1.2 & 0.2 & setosa\\
\addlinespace
5.7 & 4.4 & 1.5 & 0.4 & setosa\\
5.4 & 3.9 & 1.3 & 0.4 & setosa\\
5.1 & 3.5 & 1.4 & 0.3 & setosa\\
5.7 & 3.8 & 1.7 & 0.3 & setosa\\
5.1 & 3.8 & 1.5 & 0.3 & setosa\\
\bottomrule
\end{tabular}
\end{table}

# Conclusions

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum

<!--chapter:end:body.Rmd-->

---
title: "AAR: Fire Science Methods Workshop"
subtitle: 'aka Dunn Ranch Academy aka Nerd TREX'
author: DAM
date: "2022-05-18"
output:
  html_document:
  keep_md: false
toc: false
toc_float: false
theme: united
highlight: tango
---
  





![](mdpi_files/figure-latex/likert_gg-1.pdf)<!-- --> 

![](mdpi_files/figure-latex/obstacles_gg-1.pdf)<!-- --> 
  

<!--chapter:end:figures.Rmd-->


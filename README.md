# Geneset

[![CRANstatus](https://www.r-pkg.org/badges/version/geneset)](https://cran.r-project.org/package=geneset) [![](https://img.shields.io/badge/devel%20version-0.2.6-green.svg)](https://github.com/GangLiLab/genekitr) [![](https://cranlogs.r-pkg.org/badges/grand-total/geneset?color=orange)](https://cran.r-project.org/package=geneset) [![lifecycle](https://img.shields.io/badge/lifecycle-stable-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html) 

![Alt](https://repobeats.axiom.co/api/embed/1398fe8b05f49210229b9c8bca9b50a59337a7f7.svg "Repobeats analytics image")



### Overview

Omic-age brings huge amoung of gene data, which bring a problem of how to uncover their potential biological effects. One effective way is gene enrichment analysis.

Inside gene enrichment analysis, the central and fundamental part is the access of gene sets, no matter of traditional Over-representation analysis (ORA) method or advanced Functional class scoring (FCS) method (e.g. Gene Set Enrichment Analysis (GSEA) ).

Currently, many available enrichment analysis tools provide built-in data sets for few model species or ask users to download online. This causes a problem that user needs to download different gene sets from various public database for non-model species. For example, `enrichGO() and gseGO()` of `clusterProfiler` utilized organism-level annotation package for about 20 species. If research target is not listed in these organisms, user needs to build one via [AnnotationHub](http://bioconductor.org/packages/AnnotationHub) or download from [biomaRt](http://bioconductor.org/packages/biomaRt) or [Blast2GO](https://www.blast2go.com/), which is time-comsuming and hard task for biologists without programming skills.

Here, we develop an R package name "geneset", aimming at accessing for updated gene sets with less time. 

It includes [GO](http://geneontology.org/) (BP, CC and MF), [KEGG](https://www.kegg.jp/kegg/) (pathway, module, enzyme, network, drug and disease), [WikiPathway](https://wikipathways.org/), [MsigDb](https://www.gsea-msigdb.org/gsea/msigdb/), [EnrichrDb](https://maayanlab.cloud/Enrichr/), [Reactome](https://reactome.org/), [MeSH](https://www.ncbi.nlm.nih.gov/mesh/), [DisGeNET](https://www.disgenet.org/), [Disease Ontology](https://disease-ontology.org/) (DO), [Network of Cancer Gene](http://ncg.kcl.ac.uk/) (NCG) (version 6 and v7) and [COVID-19](https://maayanlab.cloud/covid19/). Besides, it supports both model and non-model species.

#### Supported organisms

> For more details, please refer to [this site](https://genekitr.online/docs/species.html).

- GO supports **143** species
- KEGG supports **8213** species
- MeSH supports **71** species
- MsigDb supports **20** species
- WikiPahtwaysupports **16** species
- Reactome supports **11** species
- EnrichrDB supports **5** species 
- Disease-related only support **human** (DO, NCG, DisGeNET and COVID-19)

#### About the data

All gene sets are stored on our website and could be easily accessed with simple functions. 

We will follow a monthly-update frequency to make better user experience.

## 🛠 Installation

#### Install stable version from CRAN:

```
install.packages("geneset")
```

#### Install development version from GitHub:

```
remotes::install_github("GangLiLab/geneset")
```

#### Install development version from Gitee (for CHN mainland users):

```
remotes::install_git("https://gitee.com/genekitr/pacakge_geneset")
```

## 📚 Usage

> For more details, please refer to [genekitr book](https://www.genekitr.fun/get-gene-sets-1.html).

The package now includes eight functions: `getGO()`, `getKEGG()` , `getMesh()`, `getMsigdb()`, `getWiki()`, `getReactome()`, `getEnrichrdb()`, `getHgDisease()`

All functions take  `org` (organism) as input. Several functions have unique argument such as `ont` (ontology) of `genGO()`.

Take Human GO MF gene sets for example:

```R
library(geneset)
x = getGO(org = "human",ont = "mf")

str(x)
# List of 4
# $ geneset     :'data.frame':	280115 obs. of  2 variables:
#   ..$ mf  : chr [1:280115] "GO:0000009" "GO:0000009" "GO:0000010" "GO:0000010" ...
# ..$ gene: chr [1:280115] "PIGV" "ALG12" "PDSS1" "PDSS2" ...
# $ geneset_name:'data.frame':	4878 obs. of  2 variables:
#   ..$ go_id: chr [1:4878] "GO:0000009" "GO:0000010" "GO:0000014" "GO:0000016" ...
# ..$ Term : chr [1:4878] "alpha-1,6-mannosyltransferase activity" "trans-hexaprenyltranstransferase activity" "single-stranded DNA endodeoxyribonuclease activity" "lactase activity" ...
# $ organism    : chr "hsapiens"
# $ type        : chr "mf"

head(x$geneset)
# mf  gene
# GO:0000009  PIGV
# GO:0000009 ALG12
# GO:0000010 PDSS1
# GO:0000010 PDSS2
# GO:0000014 ENDOG
# GO:0000014 ERCC1

head(x$geneset_name)
# go_id                                               Term
# GO:0000009             alpha-1,6-mannosyltransferase activity
# GO:0000010          trans-hexaprenyltranstransferase activity
# GO:0000014 single-stranded DNA endodeoxyribonuclease activity
# GO:0000016                                   lactase activity
# GO:0000026             alpha-1,2-mannosyltransferase activity
# GO:0000030                       mannosyltransferase activity
```

##### How many terms/pathways in specific gene set?

Take human KEGG Pathway as an example:

```R
gs <- geneset::getKEGG('hsa','pathway')
gs_df <- gs$geneset
table(gs_df$id) %>% length()
# 347
```

##### Pass gene set to GSVA/ssGSEA

```R
library(GSVA)
# firstly: turn gs to list
gs_list <- split(gs_df$gene, gs_df$id)  

# secondly: pass your expression dataset: "express_data" to gsva() function
ssgsea_mat <- gsva(expr=express_data, 
                 method="ssgsea", # "gsva"(default), "zscore", "plage"
                 gset.idx.list=gs_list,  
                 verbose=F, 
                 parallel.sz = 4 )
```

##### Pass gene set to ORA/GSEA

```R
hg_gs <- geneset::getGO(org = "human",ont = "mf")
# ORA
go_ent <- genekitr::genORA(input_id, geneset = hg_gs)
# GSEA (input is a pre-ranked gene list with logFC value)
gse <- genGSEA(genelist = geneList, geneset = hg_gs)
```



## ✍️ Author

[Yunze Liu](https://www.jieandze1314.com/)

[![](https://img.shields.io/badge/follow%20me%20on-WeChat-orange.svg)](https://genekitr.online/img/bioinfoplanet.png)










% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getMsigdb.R
\name{getMsigdb}
\alias{getMsigdb}
\title{Get MsigDb geneset and geneset_name
Geneset is a data.frame of 2 columns with term id and gene id}
\usage{
getMsigdb(
  org = "human",
  category = c("H", "C1", "C2-CGP", "C2-CP-BIOCARTA", "C2-CP-KEGG", "C2-CP-PID",
    "C2-CP-REACTOME", "C2-CP-WIKIPATHWAYS", "C3-MIR-MIRDB", "C3-MIR-MIR_Legacy",
    "C3-TFT-GTRD", "C3-TFT-TFT_Legacy", "C4-CGN", "C4-CM", "C5-GO-BP", "C5-GO-CC",
    "C5-GO-MF", "C5-HPO", "C6", "C7-IMMUNESIGDB", "C7-VAX", "C8"),
  download.method = NULL,
  data_dir = NULL
)
}
\arguments{
\item{org}{Organism name from `msigdb_org`.}

\item{category}{Choose one of "H", "C1", "C2-CGP", "C2-CP-BIOCARTA", "C2-CP-KEGG", "C2-CP-PID",
"C2-CP-REACTOME", "C2-CP-WIKIPATHWAYS", "C3-MIR-MIRDB","C3-MIR-MIR_Legacy", "C3-TFT-GTRD",
"C3-TFT-TFT_Legacy","C4-CGN", "C4-CM", "C5-GO-BP", "C5-GO-CC", "C5-GO-MF","C5-HPO", "C6",
"C7-IMMUNESIGDB", "C7-VAX", "C8" (refer to: http://www.gsea-msigdb.org/gsea/msigdb/collections.jsp)}

\item{download.method}{"auto" (as default if NULL), "wininet" (for windows)}

\item{data_dir}{data saving location, default is the package data directory}
}
\value{
A list including geneset.
}
\description{
Get MsigDb geneset and geneset_name
Geneset is a data.frame of 2 columns with term id and gene id
}
\examples{
\donttest{
x = getMsigdb(org = "human", category = "H", data_dir = tempdir())
}
}

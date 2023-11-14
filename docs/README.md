# Transcriptomics sandbox

In this app you will find transcriptomics related courses you can learn from, and datasets and tools you can work with for your own research/learning purposes. The included materials and tools are organized by the **[Danish Health Data Science sandbox](https://hds-sandbox.github.io)**.

Most items of this sandbox are currently based on [Rstudio server](https://www.rstudio.com/). Rstudio server is a web-based integrated development environment for R programming language, including Rmarkdowns, code, and data. Usually, each item includes a dedicated webpage with additional informations, guides, and material.

## Available items

Items are periodically added to this app and can be chosen from the menu. Each item can be a course, a setup to work with specific software, a research example, etc. In addition, items come with all necessary packages installed, eventual notebooks with computer code and explanations, and a dedicated webpage with additional material (notes, slides, recordings, ...).

The available tools are:

| Tool name | Description | Links | Programming language |
| :-----------: | :-----------: | :-----------: | :-----------: |
| **RNAseq in Rstudio**  | <div style="text-align: justify"> Rstudio session with common bulk and single cell RNAseq packages such as DESeq2, Seurat and clusterProfiler. </div> | [Webpage](https://posit.co/) | R, Rstudio |
| **Cirrocumulus**  | <div style="text-align: justify"> Cirrocumulus is an interactive visualization tool for large-scale single-cell genomics data. </div> | [Webpage](https://cirrocumulus.readthedocs.io/en/latest/) | Python, JavaScript |
| **RNAseq_CLI**  | <div style="text-align: justify"> Jupyter lab session within a mamba environment containing common RNAseq tools, ideal to create your own pipelines using snakemake | Jupyter lab, Conda, Mamba, Snakemake |

### Packages installed in *RNAseq in Rstudio*

Additional R packages have been installed in order to work with RNAseq data. Other packages and dependencies might be installed but are not shown here.

| CRAN         | Bioconductor    | Remotes         |
|--------------|-----------------|-----------------|
| BiocManager  | GenomeInfoDb    | seurat-wrappers |
| tidyverse    | clusterProfiler | seurat-data     |
| RColorBrewer | DOSE            | annotables      |
| pheatmap     | org.Hs.eg.db    | seurat-disk     |
| ggrepel      | org.Mm.eg.db    |                 |
| cowplot      | org.Dm.eg.db    |                 |
| Seurat       | pathview        |                 |
| patchwork    | DEGreport       |                 |
| sctransform  | tximport        |                 |
| DESeq2       | AnnotationHub   |                 |
| Signac       | ensembldb       |                 |
| factoextra   | apeglm          |                 |
| FactoMineR   | ggnewscale      |                 |
| NMF          | rhdf5           |                 |
| hexbin       | slingshot       |                 |
| statmod      | gprofiler2      |                 |
| Goplot       | vsn             |                 |
| ggpubr       | airway          |                 |
| ggsci        |

## Courses

The available courses are:

| Course title | Course code | Description | Links | Programming language |
| :-----: | :-----: | :-----: | :-----: | :-----: |
| **Introduction to bulk RNAseq analysis** | Intro_to_bulkRNAseq |<div style="text-align: justify"> A 3-day course to introduce bulk RNAseq analysis, from data alignment to bioinformatics analysis </div> | [Webpage](https://hds-sandbox.github.io/bulk_RNAseq_course/) | R, bash, Nextflow |
| **Introduction to single cell RNAseq analysis** | Intro_to_scRNAseq_R |<div style="text-align: justify"> A 2-day course to introduce single cell RNAseq analysis in R </div> | [Webpage](https://hds-sandbox.github.io/scRNAseq_course/) | R, Rstudio |

**Note**: Course materials will automatically downloaded unless you have "Added a folder" called `Intro_to_bulkRNAseq` or `Intro_to_scRNAseq_R`, respectively, in the submission page ([see below](#additional-options)).

## Save your work

Everything saved in the `/work` folder will be saved in your user folder after you finish your job in UCloud. 

## Additional options

Before submitting the app, you can choose the amount of resources you need. Additionally, you can add folders so that they will be visible when using the app. Adding folders is useful if:

- you want to use a folder containing **your own data and code**, with which you want to perform analysis with the Transcriptomics tools of a course/module
- you want to continue working on the material **from a previous session** of the Transcriptomics Sandbox. In such a case, add the folder containing the material using the option `Add folder`.

# Transcriptomics sandbox

In this app you will find transcriptomics related courses you can learn from, and datasets and tools you can work with for your own research/learning purposes. The included materials and tools are organized by the **[Danish Health Data Science sandbox](https://hds-sandbox.github.io)**.

The coding modules of this sandbox are currently based on [Rstudio server](https://www.rstudio.com/) and [Jupyterlab](https://jupyter.org/). Rstudio server and Jupyterlab are web-based integrated development environments for (and not limited to) `R`, `python` and `bash` programming languages. They can create interactive coding material (Rmarkdown and Jupyter notebooks) which includes, text, animations, code, and data. 

## Available modules

Learning material and tools are periodically added to this sandbox and can be chosen from the menu. Each module can be a course, a setup to work with specific software, a research example, etc. Each module come with all necessary packages installed, eventual notebooks with computer code and explanations, and a dedicated webpage with additional material (notes, slides, recordings, ...) when this is available.

The available modules are:

| Modules name | Description | Links | Programming language |
| :-----------: | :-----------: | :-----------: | :-----------: |
| **RNAseq in Rstudio**  | <div style="text-align: justify"> Rstudio session with common bulk and single cell RNAseq packages such as DESeq2, Seurat and clusterProfiler. </div> | [Webpage](https://posit.co/) | R, Rstudio |
| **Cirrocumulus**  | <div style="text-align: justify"> Cirrocumulus is an interactive visualization tool for large-scale single-cell genomics data. </div> | [Webpage](https://cirrocumulus.readthedocs.io/en/latest/) | Python, JavaScript |
| **RNAseq_CLI**  | <div style="text-align: justify"> Jupyter lab session containing common transcriptomics tools (for single cell-RNA and bulk-RNA data analysis), ideal to create your own pipelines (snakemake, nextflow or gwf). It includes all packages from the Rstudio session as well. | Jupyterlab, Snakemake, R, python |
| **Introduction to bulk RNAseq analysis** |<div style="text-align: justify"> A 3-day course to introduce bulk RNAseq analysis, from data alignment to bioinformatics analysis </div> | [Webpage](https://hds-sandbox.github.io/bulk_RNAseq_course/) | R, bash, Nextflow (in Rstudio) |
| **Introduction to single cell RNAseq analysis** |<div style="text-align: justify"> A 2-day course to introduce single cell RNAseq analysis in R </div> | [Webpage](https://hds-sandbox.github.io/scRNAseq_course/) | R (in Rstudio) |
| **Advanced single cell analysis** |<div style="text-align: justify"> Research-based examples for advanced topics in single cell analysis </div> | [Webpage](https://hds-sandbox.github.io/AdvancedSingleCell/) | R, python, bash (in jupyterlab) |

**Note**: Course materials will automatically downloaded unless you have "Added a folder" called `Intro_to_bulkRNAseq` or `Intro_to_scRNAseq_R`, respectively, in the submission page ([see below](#additional-options)).

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


## Save your work

Everything saved in the `/work` folder will be saved in your user folder after you finish your job in UCloud. 

## Additional options

Before submitting the app, you can choose the amount of resources you need. Additionally, you can add folders so that they will be visible when using the app. Adding folders is useful if:

- you want to use a folder containing **your own data and code**, with which you want to perform analysis with the Transcriptomics tools of a course/module
- you want to continue working on the material **from a previous session** of the Transcriptomics Sandbox. In such a case, add the folder containing the material using the option `Add folder`.

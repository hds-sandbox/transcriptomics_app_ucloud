# Welcome to the RNAseq in Rstudio environment

**Note:** In order to visualize this document better, please use "Visual" mode in the toolbar above.

In this Rstudio environment you will find transcriptomics related courses you can learn from, and datasets and tools you can work with for your own research/learning purposes. The included materials and tools are organized by the **[Danish Health Data Science sandbox](https://hds-sandbox.github.io)**. 

## Packages installed in *RNAseq in Rstudio*
Additional R packages have been installed in order to work with RNAseq data. Other packages and dependencies might be installed but are not shown here.

| CRAN | Bioconductor | Remotes |
| :-----------: | :-----------:| :-----------: |
| BiocManager   | GenomeInfoDb     | seurat-wrappers |
| tidyverse     | clusterProfiler  | seurat-data     |
| RColorBrewer  | DOSE             | annotables      |
| pheatmap      | org.Hs.eg.db     | seurat-disk     |
| ggrepel       | org.Mm.eg.db     |                 |
| cowplot       | org.Dm.eg.db     |                 |
| Seurat        | pathview         |                 |
| patchwork     | DEGreport        |                 |
| sctransform   | tximport         |                 |
| DESeq2        | AnnotationHub    |                 |
| Signac        | ensembldb        |                 |
|               | apeglm           |                 |
|               | ggnewscale       |                 |
|               | rhdf5            |                 |
|               | slingshot        |                 |
|               | gprofiler2       |                 |

## Courses

The available courses are:

| Course title | Course code | Description | Links | Programming language |
| :-----: | :-----: | :-----: | :-----: | :-----: |
| **Introduction to bulk RNAseq analysis** | Intro_to_bulkRNAseq | A 3-day course to introduce bulk RNAseq analysis, from data alignment to bioinformatics analysis | [Webpage](https://hds-sandbox.github.io/bulk_RNAseq_course/) | R, bash, Nextflow |

## Loading course materials

Materials for courses are available under `/usr/[course_code]`. In order to work with the course materials, please use a *soft link* to link it to the `/work` folder using the **terminal**. For example, in the Rstudio session, I would like to access the "Intro to bulk RNAseq" course material. Enter the following line in the **Terminal** tab of Rstudio:

```{bash}
ln -s /usr/Intro_to_bulkRNAseq /work/Intro_to_bulkRNAseq
```

![](soft_link.png)

### Introduction to bulk RNASeq analysis

This course is an introduction for how to approach bulk RNAseq data, starting from the sequencing reads. It will provide an overview of the fundamentals of RNAseq analysis, including read preprocessing, data normalization, data exploration with PCAs and heatmaps, performing differential expression analysis and annotation of the differentially expressed genes. In this course will also learn how to evaluate confounding and batch effects in the data. The course will further touch upon laboratory protocols, library preparation, and experimental design of RNA sequencing experiments, especially about how they influence downstream bioinformatic analysis.

In order to load this course, run this line of code in the **Terminal** Tab:

```{bash}
ln -s /usr/Intro_to_bulkRNAseq /work/Intro_to_bulkRNAseq
```

## Save your work

Everything saved in the `/work` folder will be saved in your personal folder after you finish your job in UCloud. 

**Note** Soft linked folders in `/work` will not be saved. If you want a copy of the materials, copy the material instead using the **Terminal** as before:

```{bash}
cp -r /usr/Intro_to_bulkRNAseq /work/Intro_to_bulkRNAseq
```

## Additional options

Before submitting the app, you can choose the amount of resources you need. Additionally, you can add folders so that they will be visible when using the app. Adding folders is useful if:

- you want to use a folder containing **your own data and code**, with which you want to perform analysis with the Transcriptomics tools of a course/module
- you want to continue working on the material **from a previous session** of the Transcriptomics Sandbox. In such a case, add the folder containing the material using the option `Add folder`. 


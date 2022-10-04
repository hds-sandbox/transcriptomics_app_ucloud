#!/bin/bash

while getopts c:f: option
do
    case "${option}"
    in
        c) COURSE=${OPTARG};;
        f) CIRRO_FOLDER=${OPTARG};; #only for cirrocumulus choice of module
        \?) ## Invalid option
            printf "Error: invalid option.\n\n"
            exit;;
    esac
done

printf  "\n==================  "
printf  "\n Selecting Course  \n"
printf  "==================  \n\n"

# Intro to Single Cell RNAseq analysis with python
if [ "${COURSE}" == "Intro_to_NGS" ]
then
    echo "-----> Chosen course: Introduction to NGS data"
    if [ ! -d "Intro_to_NGS" ];
    then
        echo "-----> Linking fresh course material."
        ln -s /usr/Intro_to_NGS /work/Intro_to_NGS
    else
        echo "-----> Using your own course material."
    fi

    ### install kernels - this goes into start-jupyter
    echo "-----> Installing course kernels on jupyterlab"
    "${CONDA_DIR}"/envs/NGS_aarhus_py/bin/python -m ipykernel install --user --name="NGS_python" --display-name "NGS (Python)" && \
    "${CONDA_DIR}"/envs/NGS_aarhus_r/bin/R -e "IRkernel::installspec(user=TRUE, name = 'NGS_R', displayname = 'NGS (R)')"

    ### modify kernel files with system variables
    cp /usr/Intro_to_NGS/Environments/kernel_py_docker.json ~/.local/share/jupyter/kernels/ngs_python/kernel.json && \
    cp /usr/Intro_to_NGS/Environments/kernel_R_docker.json ~/.local/share/jupyter/kernels/ngs_r/kernel.json

    printf  "\n==================  "
    printf  "\n Start JupyterLab  \n"
    printf  "==================  \n\n"
    #add course name as variable to be used
    bash -c "COURSE=${COURSE} jupyter lab --port=8787 --NotebookApp.token='' "
    
# Intro to single cell RNAseq with Rstudio
elif [ "${COURSE}" == "Intro_to_bulkRNAseq" ]
then
    echo "-----> Chosen course: Introduction to bulk RNAseq analysis"
    if [ ! -d "Intro_to_bulkRNAseq" ];
    then
        echo "-----> Linking fresh course material."
        ln -s /usr/Intro_to_bulkRNAseq /work/Intro_to_bulkRNAseq
    else
        echo "-----> Using your own course material."
    fi

    printf  "\n===================  "
    printf  "\n== Start RStudio ==  \n"
    printf  "=================== \n\n"

    sudo /init

# Start cirrocumulus    
elif [ "${COURSE}" == "Cirrocumulus" ]
then
    echo "-----> Chosen course: Introduction to bulk RNAseq analysis"

    printf  "\n===================  "
    printf  "\n== Start Cirrocumulus ==  \n"
    printf  "=================== \n\n"

    cirro launch --port 8787 `ls -d ${CIRRO_FOLDER}/` 

elif [ "${COURSE}" == "Intro_to_bulkRNAseq" ]
then
    echo "-----> Chosen course: Introduction to bulk RNAseq analysis"
    if [ ! -d "Intro_to_bulkRNAseq" ];
    then
        echo "-----> Linking fresh course material."
        ln -s /usr/Intro_to_bulkRNAseq /work/Intro_to_bulkRNAseq
    else
        echo "-----> Using your own course material."
    fi

    printf  "\n===================  "
    printf  "\n== Start RStudio ==  \n"
    printf  "=================== \n\n"

    sudo /init
    
fi

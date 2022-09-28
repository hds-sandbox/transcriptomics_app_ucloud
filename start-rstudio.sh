#!/bin/bash

while getopts d:m:c* option
do
    case "${option}"
    in
       d) DEPS=${OPTARG};;
       m) BATCH=${OPTARG};;
    esac
done

if [ -f "${DEPS}" ]
then

      printf  "\n=============================  "
      printf  "\n== Installing dependencies ==  \n"
      printf  "=============================  \n\n"

      if [[ "$DEPS" == *.sh ]]
      then

        bash "$DEPS"

      else

      echo "File format not correct."
      echo ""

      fi
fi

if [ -f "$BATCH" ]
then
      printf  "\n==================================  "
      printf  "\n== Execute script in batch mode ==  \n"
      printf  "================================== \n\n"

      if [[ "$BATCH" == *.R ]]
      then
            Rscript "$BATCH"

      elif [[ "$BATCH" == *.sh ]]
      then
            bash "$BATCH"
      else
            printf "Incorrect file format correct: expected *.R/*.sh.\n"
      fi
      
      exit 0
else
      printf  "\n===================  "
      printf  "\n== Start RStudio ==  \n"
      printf  "=================== \n\n"

      sudo /init
fi

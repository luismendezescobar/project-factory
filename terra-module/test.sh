#!/bin/bash
#validate if a file exists
count=`ls -1 ../files-projects/*.json 2>/dev/null | wc -l`
if [ $count == 0 ]
then 
echo "there are no files of .json type in the files-project directory"
GROUP_FOUND=1  # we assing 1 because if we want to delete the last project in the folder
else 
  cat ../files-projects/control-project.json

fi

#https://stackoverflow.com/questions/57903836/how-to-fail-a-job-in-github-actions
#https://stackoverflow.com/questions/70689512/terraform-check-if-resource-exists-before-creating-it
#this script should be called with source ./validate-group
#!/bin/bash
# Auto Generates Unit Tests using olama
# run in terminal with one of these commands: 
# bash llamaBash.sh --review 
# bash llamaBash.sh --storybook
# bash llamaBash.sh --test  


PROMPT=""

# Get the current working directory
directory_path=$(pwd)

# Create an array of files with .jsx, .js, .ts, or .tsx extensions
files_array=($(find "$directory_path" -maxdepth 1 -type f \( -name "*.jsx" -o -name "*.js" -o -name "*.ts" -o -name "*.tsx" \)))

# Check if there are matching files
if [ ${#files_array[@]} -eq 0 ]; then
  echo "No matching files found in the current directory."
  exit 0
fi


if [ "$1" = "--documentation" ]; then
    PROMPT="Review the following files in this React project. Create high level software documentation explaining how the application works for the end user. Do not output any code or recommendations."
    FILESCONTENT=""
    for file in "${files_array[@]}"; do
        INPUT=$(cat $file)
        FILESCONTENT+="NEW FILE: ${INPUT}"
    done
    echo "Documentation mode"
    ollama run mistral "${PROMPT} ${FILESCONTENT}" > "_llamaBashOutput-documentation.txt"
    exit 1
fi



for file in "${files_array[@]}"; do
    MODE=''
    if [ -z "$1" ]|| [ "$1" = "--review" ]; then
        PROMPT="Pretend you are a principal software engineer and summarize the following code, including opportunites for improvement with code examples"       
        MODE='review'
        echo "Review Mode"
    fi
    if [ "$1" = "--test" ]; then
        PROMPT="Create a JEST unit test using typescript to check the components functionality for this typescript file. Do not discuss the test, only output the test code:"
        MODE='test'
        echo "Test Mode"
    fi
    if [ "$1" = "--storybook" ]; then
        PROMPT="Create a React storybook file for this file in Typescript. Do not discuss the storybook, only output the storybook code."
        MODE='storybook'
    fi
        echo "Prompting with prompt: ${PROMPT}"
        echo "File: $file"
        INPUT=$(cat $file)
        # echo $INPUT
        filename="${file##*/}"
        ollama run dolphin-mixtral "${PROMPT} ${INPUT}" > "_llamaBash-${MODE}-${filename}.txt"
        # Other LLMs you could use: llama2, codellama, dolphin-mixtral
        # Removing models (they are big!): ollama rm dolphin-mixtral
done
exit 1

#!/bin/bash
# Auto Generates reviews, storybooks, tests and documentation using Ollama
# run in terminal with one of these commands: 
# bash llamaBash.sh --review 
# bash llamaBash.sh --storybook
# bash llamaBash.sh --test  
# bash llamaBash.sh --documentation


function runScript() {
    echo $1
     if [ -z "$1" ] || [[ "$1" != "--documentation" &&  "$1" != "--review" &&  "$1" != "--storybook" && "$1" != "--test" ]]; then

        echo "Missing or incorrect mode argument, try --test, --documentation or --review"
        echo $1

        exit 1
     fi




    PROMPT=""
    # Get the current working directory
    directory_path=$(pwd)

    # Create an array of files with .jsx, .js, .ts, or .tsx extensions
    files_array=($(find "$directory_path" -maxdepth 1 -type f \( -name "*.jsx" -o -name "*.js" -o -name "*.ts" -o -name "*.tsx" \)))


    # Check if there are matching files
    if [ ${#files_array[@]} -eq 0 ]; then
    echo "No matching files found in the current directory."
        # exit 0
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

    fi

    for file in "${files_array[@]}"; do
        MODE=''        
 

        if [ "$1" = "--review" ]; then
            PROMPT="Pretend you are a principal software engineer and summarize the following code, including opportunites for improvement with code examples"       
            MODE='review'
            echo "Mode: ${MODE}"
            echo "Prompting with prompt: ${PROMPT}"
            echo "File: $file"
            INPUT=$(cat $file)
            filename="${file##*/}"
            ollama run mistral "${PROMPT} ${INPUT}" > "_llamaBash-${MODE}-${filename}.txt"
        fi
        if [ "$1" = "--test" ]; then
            PROMPT="Create a JEST unit test using typescript to check the components functionality for this typescript file. Do not discuss the test, only output the test code:"
            MODE='test'
            echo "Mode: ${MODE}"
            echo "Prompting with prompt: ${PROMPT}"
            echo "File: $file"
            INPUT=$(cat $file)
            filename="${file##*/}"
            ollama run mistral "${PROMPT} ${INPUT}" > "_llamaBash-${MODE}-${filename}.txt"
        fi
        if [ "$1" = "--storybook" ]; then
            PROMPT="Create a React storybook file for this file in Typescript. Do not discuss the storybook, only output the storybook code."
            MODE='storybook'
            echo "Mode: ${MODE}"
            echo "Prompting with prompt: ${PROMPT}"
            echo "File: $file"
            INPUT=$(cat $file)
            filename="${file##*/}"
            ollama run llama2 "${PROMPT} ${INPUT}" > "${directory_path}_llamaBash-${MODE}-${filename}.txt"
        fi
            # Other LLMs you could use: llama2, codellama
            # Removing models (they are big!): ollama rm mistral
    done
}
export -f runScript



if [ "$2" = "--recursive" ]; then   
    # Recursive execution without a separate function

    echo "recursive" 
    initialDirectory="$(pwd)"
    directories=$(find "$initialDirectory" -type d -print)
    for dir in $directories; do
        if [[ "$dir" != *".git"* && "$dir" != *"node_modules"* ]]; then
            echo "$dir"
            cd $dir
            runScript "$1"
            cd $initialDirectory
        fi
    done
else runScript "$1"
fi
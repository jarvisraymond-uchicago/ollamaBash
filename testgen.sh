#!/bin/bash
# Auto Generates Unit Tests using olama
# run in terminal with command: bash testgen.sh
# bash testgen.sh OR bash testgen.sh --test OR bash testgen.sh --storybook


INPUT=$(cat TableRow.tsx)
OUTPUTTYPE='code-review'
PROMPT="Pretend you are a principal software engineer and summarize the following code, including opportunites for improvement with examples"

if [ -z "$1" ]; then
    PROMPT="Pretend you are a principal software engineer and summarize the following code, including opportunites for improvement with examples"
fi

if [ "$1" = "--test" ]; then
    PROMPT="Create a JEST unit test using typescript to check the components functionality for this typescript file. Do not discuss the test, only output the test code:"
fi
if [ "$1" = "--storybook" ]; then
    PROMPT="Create a React storybook file for this typescript file. Do not discuss the storybook, only output the storybook code:"
fi
   echo "Prompting with prompt: ${PROMPT}"
# INPUT=$(cat ExampleComponent.jsx)
# echo $INPUT

# echo "Writing a JEST unit test for this file:${INPUT}"
ollama run codellama "${PROMPT} ${INPUT}" > _CodeLlamaOutput.ts
ollama run llama2 "${PROMPT} ${INPUT}" > _llama2Output.ts
ollama run mistral "${PROMPT} ${INPUT}" > _mistralOutput.ts
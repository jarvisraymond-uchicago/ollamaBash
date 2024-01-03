#!/bin/bash
# Auto Generates Unit Tests using olama
# run in terminal with one of these commands: 
# bash llamaCodeBash.sh --review 
# bash llamaCodeBash.sh --storybook
# bash llamaCodeBash.sh --test  


INPUT=$(cat TableRow.tsx)
PROMPT="Pretend you are a principal software engineer and summarize the following code, including opportunites for improvement with examples"
STORYBOOKEXAMPLE='import React from 'react'; import { QueryClient, QueryClientProvider } from 'react-query'; import SharedContext from '../../Utils/SharedContext'; import Execution from './Execution'; import { rest } from 'msw'; import './../../GWASResultsContainer.css';export default { title: 'Tests2/GWASResults/Views/Execution', component: 'Execution', };const mockedQueryClient = new QueryClient({ defaultOptions: { queries: { retry: false }, }, });const setCurrentView = (input) => }; const selectedRowData = { name: 'gwas-workflow-787571537', wf_name: "user created name", uid: '4b125c09-9712-486f-bacd-ec1451aae935', startedAt: '2022-02-15T13:00:00Z', finishedAt: '2022-02-15T14:00:00Z', phase: 'Failed', DateTimeSubmitted: '2022-02-15T13:30:00Z', }; const { name, uid } = selectedRowData;const MockedFailureJSON = [ { name: 'gwas-workflow-7875715375', step_name: 'attrition-table', step_template: 'get-attrition-table', error_message: "exit code 1", error_interpreted: "Timeout occurred while fetching attrition table information." }, { name: 'gwas-workflow-7875715375.get-pheno-csv', step_name: 'pheno-csv', step_template: 'get-pheno-csv', error_message: "exit code 1", error_interpreted: "" }, ];const MockTemplateFailure = () => { return ( <QueryClientProvider client={mockedQueryClient}> <SharedContext.Provider value={{ selectedRowData, setCurrentView, }} > <Execution /> </SharedContext.Provider> </QueryClientProvider> ); };const MockTemplateSuccess = () => { return ( <QueryClientProvider client={mockedQueryClient}> <SharedContext.Provider value={{ selectedRowData: { ...selectedRowData, phase: 'Succeeded' }, setCurrentView, }} > <Execution /> </SharedContext.Provider> </QueryClientProvider> ); }; export const MockedFailure = MockTemplateFailure.bind({}); MockedFailure.parameters = { msw: { handlers: [ rest.get('http://:argowrapperpath/ga4gh/wes/v2/logs/', (req, res, ctx) => { const { argowrapperpath } = req.params; return res(ctx.delay(100), ctx.json(MockedFailureJSON)); } ), ], }, }; export const MockedSuccess = MockTemplateSuccess.bind({}); MockedSuccess.parameters = { msw: { handlers: [ rest.get( 'http://:argowrapperpath/ga4gh/wes/v2/logs/', (req, res, ctx) => { const { argowrapperpath } = req.params; // Successful executions return an empty array return res(ctx.delay(100), ctx.json([])); } ), ], }, };export const MockedErrorObject = MockTemplateFailure.bind({}); MockedErrorObject.parameters = { msw: { handlers: [ rest.get( 'http://:argowrapperpath/ga4gh/wes/v2/logs/', (req, res, ctx) => { const { argowrapperpath } = req.params; return res( ctx.delay(100), // Some errroneous responses can return an error object ctx.json({ error: 'Mocked Server error response' }) ); } ), ], }, }; export const MockedError403Response = MockTemplateFailure.bind({}); MockedError403Response.parameters = { msw: { handlers: [ rest.get( 'http://:argowrapperpath/ga4gh/wes/v2/logs/', (req, res, ctx) => { const { argowrapperpath } = req.params; return res( ctx.delay(100), ctx.status(403) ); } ), ], }, }; '

# Get the current working directory
directory_path=$(pwd)

# Create an array of files with .jsx, .js, .ts, or .tsx extensions
files_array=($(find "$directory_path" -maxdepth 1 -type f \( -name "*.jsx" -o -name "*.js" -o -name "*.ts" -o -name "*.tsx" \)))

# Check if there are matching files
if [ ${#files_array[@]} -eq 0 ]; then
  echo "No matching files found in the current directory."
  exit 0
fi

for file in "${files_array[@]}"; do
    if [ -z "$1" ]|| [ "$1" = "--review" ]; then
        PROMPT="Pretend you are a principal software engineer and summarize the following code, including opportunites for improvement with examples"       
    fi

    if [ "$1" = "--test" ]; then
        PROMPT="Create a JEST unit test using typescript to check the components functionality for this typescript file. Do not discuss the test, only output the test code:"
    fi
    if [ "$1" = "--storybook" ]; then
        PROMPT="Create a React storybook file for this file in Typescript. Do not discuss the storybook, only output the storybook code. Use this storybook file as an example, Execution.stories.jsx:${STORYBOOKEXAMPLE}"
    fi
    echo "Prompting with prompt: ${PROMPT}"
    echo "File: $file"
    
    filename="${file##*/}"
    ollama run mistral "${PROMPT} ${INPUT}" > "_llamaCodeBashOutput-${filename}.txt"
done

# echo "Writing a JEST unit test for this file:${INPUT}"
# ollama run codellama "${PROMPT} ${INPUT}" > _CodeLlamaOutput.ts
# ollama run llama2 "${PROMPT} ${INPUT}" > _llama2Output.ts
# ollama run mistral "${PROMPT} ${INPUT}" > _mistralOutput.ts

# Iterate through the array and print the file names






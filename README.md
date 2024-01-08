# OllamaBash Readme

This bash script uses Ollama library https://ollama.ai/ to prompt a LLM and then generate test files, storybook files, code review files or a documentation file for each JS, JSX, TS or TSX in a directory or an entire codebase.

This bash script, named `ollamaBash`, is designed to automatically generate various
artefacts such as unit tests, Storybook files, and documentation for React projects
using the olama tool. Olama is a user-friendly tool designed to run large language models (LLMs) locally on a computer. It supports a variety of AI models including LLaMA-2, CodeLLaMA, Mistral, and others.

## Usage

To use this script in your terminal, place the script in a directory containing the relevant files types and run one of the following commands after installing Ollama:

- `bash ollamaBash --review`
- `bash ollamaBash --storybook`
- `bash ollamaBash --test`
- `bash ollamaBash --documentation`

This will then analyze and output file(s) in the current directory. You can clone this project and run these commands to have it analyze example components. 

To have the script operate on all sub directories, add the secondary parameter `--recursive`

- `bash ollamaBash --review --recursive`
- `bash ollamaBash --storybook --recursive`
- `bash ollamaBash --test --recursive`
- `bash ollamaBash --documentation --recursive`

To make the script global, put it in usr/local/bin and make sure it is executable, for example:  run `chmod 755 ollamaBash` and can be called from any directory with `ollama --test --recursive` 

## Features

The script supports the following features:

1. **Review**: In this mode, the script pretends it is a principal software
   engineer and attempts summarizes each code file in the project. It outputs suggestions for
   improvement along with code examples.
2. **Storybook**: The script attempts to generate a React Storybook file for the given
   Javscript or TypeScript file.
3. **Test**: In this mode, the script attempts to create Jest unit tests for each component in
   the project.
4. **Documentation**: In this mode, the script attempts to generate high-level software
   documentation for all files in the folder within a single file.

## Implementation

The script starts by setting an empty `PROMPT` variable and determining the current
working directory using the `pwd` command. It then searches for all files with
extensions `.jsx`, `.js`, `.ts`, or `.tsx` within that directory using the `find`
command and stores them in an array called `files_array`.

If no matching files are found, the script terminates with a message indicating no
files were found.

A user-provided argument is required; the script checks which mode to run in
(review, test, storybook, or documentation) based on the argument. The script then applies the corresponding prompt for each file and generates the required output using Ollama, storing the
results in files with the format `_llamaBash-<mode>-<filename>.txt` in the directory of the file.

If the user provides the secondary argument `--recursive`, the script will iterate through all subdirectories using the first argument provided and generate files in each directory containing the relevant file types.

## Prerequisites

To use this script effectively, ensure you can run bash scripts and have Ollama installed first:
https://ollama.ai/

## Future Improvements

The script currently outputs all the files alongside files in the project. Because Ollama is limited in its prompt size, it is currently unable to generate documentation for an entire code base with a single huge prompt.

Limitations by file type: This currently works on JS and TS type files, however the script can easily be updated to generate tests, reviews, documentation etc. for other computing languages by changing the file type extensions and prompts.

# llamaBash Readme

Uses Ollama library https://ollama.ai/ to prompt a LLM and then generate test files, storybook files, code review files or a documentation file for each JS, JSX, TS or TSX in a directory.

This bash script, named `llamaBash.sh`, is designed to automatically generate various
artefacts such as unit tests, Storybook files, and documentation for React projects
using the olama tool. Olama is a user-friendly tool designed to run large language models (LLMs) locally on a computer. It supports a variety of AI models including LLaMA-2, CodeLLaMA, Mistral, and others.

## Usage

To use this script in your terminal, run one of the following commands after installing Ollama:

- `bash llamaBash.sh --review`
- `bash llamaBash.sh --storybook`
- `bash llamaBash.sh --test`
- `bash llamaBash.sh --documentation`

This will then analyze and output file(s) in the current directory. You can clone this project and run these commands to have it analyze two example components.

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
   documentation.

## Implementation

The script starts by setting an empty `PROMPT` variable and determining the current
working directory using the `pwd` command. It then searches for all files with
extensions `.jsx`, `.js`, `.ts`, or `.tsx` within that directory using the `find`
command and stores them in an array called `files_array`.

If no matching files are found, the script terminates with a message indicating no
files were found.

If a user-provided argument is present, the script checks which mode to run in
(review, test, storybook, or documentation) based on the argument. If no argument is
provided, it defaults to review mode. The script then applies the corresponding
prompt for each file and generates the required output using Ollama, storing the
results in files with the format `_llamaBash-<mode>-<filename>.txt` in the user's current directory.

## Prerequisites

To use this script effectively, ensure you have Ollama installed first:
https://ollama.ai/

## Future Improvements

This currently works at the directory level, however by changing the find function to not use a max depth, this code be used to generate tests, reviews, documentation and storybooks for an entire code base. However the script currently outputs all the files in the user's current directory instead of alongside each file in the project. Additionally because olama is limited in its prompt size, it would be unable to generate documentation for an entire code base with a single huge prompt.

This could be updated to generate tests, reviews, documentation etc. for other computing languages by changing the file type extensions and prompts.

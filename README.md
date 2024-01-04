# LLamaBash Readme

Uses Olama library https://ollama.ai/ to prompt a LLM and then generate test files, storybook files, code review files or a documentation file for each JS, JSX, TS or TSX in a directory.

This bash script, named `LLamaBash.sh`, is designed to automatically generate various
artefacts such as unit tests, Storybook files, and documentation for React projects
using the olama tool. Olama is a user-friendly tool designed to run large language models (LLMs) locally on a computer. It supports a variety of AI models including LLaMA-2, CodeLLaMA, Mistral, and others.

## Usage

To use this script in your terminal, run one of the following commands:

- `bash LLamaBash.sh --review`
- `bash LLamaBash.sh --storybook`
- `bash LLamaBash.sh --test`
- `bash LLamaBash.sh --documentation`

## Features

The script supports the following features:

1. **Review**: In this mode, the script pretends it is a principal software
   engineer and summarizes each code file in the project. It outputs suggestions for
   improvement along with code examples.
2. **Storybook**: The script generates a React Storybook file for the given
   Javscript or TypeScript file.
3. **Test**: In this mode, the script creates Jest unit tests for each component in
   the project.
4. **Documentation**: In this mode, the script generates high-level software
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
prompt for each file and generates the required output using olama, storing the
results in files with the format `_llamaBash-<mode>-<filename>.txt` in the user's current directory.

## Prerequisites

To use this script effectively, ensure you have Ollama installed first:
https://ollama.ai/

## Future Improvements

This currently works at the directory level, however by changing the find function to not use a max depth, this code be used to generate tests, reviews, documentation and storybooks for an entire code base. However the script currently outputs all the files in the user's current directory instead of alongside each file in the project. Additionally because olama is limited in its prompt size, it would be unable to generate documentation for an entire code base with a single huge prompt.

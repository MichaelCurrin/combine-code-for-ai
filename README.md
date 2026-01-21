# Combine text
> Convert a repo of files into a LLM-friendly output

With structure at the start followed by all files together.

## Usage

```sh
./combine-txt.sh PATH
```

Add `--min` flag to preview with just 10 lines for each file.

## Sample output

```
.
├── file1.txt
├── file2.py
...
└── README.md

FILENAME: file1.txt
CONTENT: <|START_CONTENT|>
...
<|END_CONTENT|>

...

FILENAME: README.md
CONTENT: <|START_CONTENT|>
...
<|END_CONTENT|>
```

## Based on

Reddit thread https://www.reddit.com/r/LocalLLaMA/comments/1hdvtxj/your_source_to_prompt_turn_your_code_into_an_llm/?rdt=54180

Locally running option with a GUI: https://github.com/Dicklesworthstone/your-source-to-prompt.html/tree/main?tab=readme-ov-file

## License

Licenses under [MIT](/LICENSE) by [MichaelCurrin](https://github.com/MichaelCurrin).

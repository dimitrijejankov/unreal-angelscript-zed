# Unreal Angelscript Zed Extension

This extension adds support for Unreal Angelscript (.as files) to the Zed editor, including:

- Syntax highlighting for Unreal Angelscript language constructs
- Bracket matching
- Code outline for navigating classes, functions, and other structures
- Auto-indentation for proper code formatting
- Support for Unreal Engine-specific macros (UCLASS, UPROPERTY, etc.)

## Installation

### Development Installation

To install this extension locally for development:

1. Clone this repository to your local machine
2. Open Zed
3. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Linux/Windows) to open the command palette
4. Type "Extensions: Install Dev Extension" and select it
5. Navigate to the directory containing this extension and select it

The extension will now be available in Zed.

### Dependencies

This extension requires the `tree-sitter-unreal-angelscript` grammar to be available at the path specified in `extension.toml`. Make sure the grammar is installed and accessible.

## Features

### Syntax Highlighting

The extension provides comprehensive syntax highlighting for:

- Unreal Engine macros (UCLASS, UPROPERTY, UFUNCTION, etc.)
- Standard Angelscript keywords (class, struct, enum, if, for, etc.)
- Types (primitive types, custom types, template types)
- Functions, methods, and properties
- Comments, strings, and literals
- Operators and punctuation

### Code Outline

The outline view allows you to navigate your code efficiently, showing:

- Classes and structures
- Functions and methods
- Enums and enum values
- Namespaces
- Delegates and events

### Bracket Matching

The extension supports matching of various bracket pairs:

- Curly braces: `{` and `}`
- Square brackets: `[` and `]`
- Parentheses: `(` and `)`
- Quotation marks: `"` and `'`

### Auto-Indentation

The extension provides proper indentation for:

- Class and struct bodies
- Function bodies
- Control flow blocks (if, for, while, etc.)
- Namespace blocks

## Testing

The extension includes tests for:

- Syntax highlighting
- Bracket matching
- Code outline generation
- File type detection

To run the tests:

```bash
cd /path/to/extension
cargo test
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add or update tests as needed
5. Submit a pull request

## License

This project is licensed under the MIT License.

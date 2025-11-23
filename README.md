# Unreal Angelscript Zed Extension

This extension adds support for Unreal Angelscript (.as files) to the Zed editor.

## Installation

### 1. Install the Language Server

**Prerequisites:** Node.js and Git must be installed.

Run this command to download and build the language server:

```bash
rm -rf ~/.angelscript_server && git clone --depth 1 https://github.com/Hazelight/vscode-unreal-angelscript.git /tmp/vscode-unreal-angelscript && mv /tmp/vscode-unreal-angelscript/language-server ~/.angelscript_server && rm -rf /tmp/vscode-unreal-angelscript && cd ~/.angelscript_server && sed -i 's/"scripts": {}/"scripts": {"build": "tsc -p .", "watch": "tsc -p . --watch"}/' package.json && sed -i "s/let connection: Connection = createConnection(new IPCMessageReader(process), new IPCMessageWriter(process));/let connection: Connection; if (process.argv.includes('--stdio')) { connection = createConnection(process.stdin, process.stdout); } else { connection = createConnection(new IPCMessageReader(process), new IPCMessageWriter(process)); }/" src/server.ts && npm install && npm run build
```

### 2. Configure Zed

Add the following to your Zed settings (`~/.config/zed/settings.json`):

```json
{
  "lsp": {
    "unreal_angelscript": {
      "binary": {
        "path": "node",
        "arguments": [
          "/home/YOUR_USERNAME/.angelscript_server/out/server.js",
          "--stdio"
        ]
      }
    }
  }
}
```

Replace `YOUR_USERNAME` with your actual username, or use the full path to where you installed the server.

### 3. Install the Extension

#### From Zed Extensions (when published)

1. Open Zed
2. Go to Extensions
3. Search for "Unreal Angelscript"
4. Click Install

#### Development Installation

1. Clone this repository
2. Open Zed
3. Go to Extensions > Install Dev Extension
4. Select the cloned directory

## Features

- Syntax highlighting for Unreal Angelscript
- Support for Unreal Engine macros (UCLASS, UPROPERTY, UFUNCTION, etc.)
- Language server features:
  - Code completion
  - Hover information  
  - Go to definition
  - Find references
  - Diagnostics
  - Code actions
  - Inlay hints
  - Semantic highlighting

The language server connects to Unreal Engine to provide engine-specific information. Make sure your Unreal Engine project is open with the Angelscript plugin enabled for full functionality.

## Debugging

This extension supports debugging AngelScript code in Unreal Engine.

### Prerequisites

1. **Install the Debug Adapter:**

   ```bash
   git clone https://github.com/dimitrijejankov/unreal-angelscript-debug-adapter.git
   cd unreal-angelscript-debug-adapter
   ./scripts/install.sh --local
   ```
   
### How to Debug

1. **Create a debug configuration** in `.zed/debug.json` in your project:

   ```json
   [
     {
       "label": "Attach to Unreal Angelscript",
       "adapter": "angelscript",
       "request": "attach"
     }
   ]
   ```

2. **Start a debug session:**
   - Set breakpoints in your `.as` files
   - Open the Debug panel
   - Select the "Attach to Unreal Angelscript" configuration
   - Click the "Start Debugging" button


## Troubleshooting

### "Language server path not configured"

Make sure you've added the `lsp` configuration to your Zed settings as shown above.

### Language server not starting

1. Verify Node.js is installed: `node --version`
2. Check the server exists: `ls ~/.angelscript_server/out/server.js`
3. Check Zed logs: Use "zed: open log" command

## License

MIT

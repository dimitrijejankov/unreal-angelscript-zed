use std::net::Ipv4Addr;

use zed_extension_api::{
    self as zed,
    serde_json::{self, Value},
    settings::LspSettings,
    DebugAdapterBinary, LanguageServerId, Result, StartDebuggingRequestArguments,
    StartDebuggingRequestArgumentsRequest, TcpArguments,
};

struct UnrealAngelscriptExtension;

impl zed::Extension for UnrealAngelscriptExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        // Check for binary configuration in settings
        let settings = LspSettings::for_worktree(language_server_id.as_ref(), worktree).ok();

        let binary = settings.as_ref().and_then(|s| s.binary.as_ref());

        // Zed uses binary.path as command and binary.arguments as args
        // If configured, return those values
        if let Some(binary) = binary {
            if let Some(path) = &binary.path {
                let args = binary.arguments.clone().unwrap_or_default();
                return Ok(zed::Command {
                    command: path.clone(),
                    args,
                    env: vec![],
                });
            }
        }

        // Not configured - return helpful error
        Err(
            "Unreal Angelscript language server not configured.\n\n\
            Please set up the language server:\n\n\
            1. Install the language server by running:\n\
               ./scripts/install.sh\n\n\
            2. Add to your Zed settings (settings.json):\n\
               {\n\
                 \"lsp\": {\n\
                   \"unreal_angelscript\": {\n\
                     \"binary\": {\n\
                       \"path\": \"node\",\n\
                       \"arguments\": [\"/path/to/.angelscript_server/out/server.js\", \"--stdio\"]\n\
                     }\n\
                   }\n\
                 }\n\
               }"
                .to_string(),
        )
    }

    fn language_server_initialization_options(
        &mut self,
        server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<Option<zed::serde_json::Value>> {
        let settings = LspSettings::for_worktree(server_id.as_ref(), worktree)
            .ok()
            .and_then(|s| s.initialization_options);
        Ok(settings)
    }

    fn language_server_workspace_configuration(
        &mut self,
        server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<Option<zed::serde_json::Value>> {
        let settings = LspSettings::for_worktree(server_id.as_ref(), worktree)
            .ok()
            .and_then(|s| s.settings);
        Ok(settings)
    }

    fn get_dap_binary(
        &mut self,
        adapter_name: String,
        config: zed::DebugTaskDefinition,
        user_provided_debug_adapter_path: Option<String>,
        worktree: &zed::Worktree,
    ) -> Result<DebugAdapterBinary, String> {
        let configuration = serde_json::from_str::<serde_json::Value>(&config.config)
            .map_err(|e| format!("Error parsing the config: {e}"))?;
        let request = self.dap_request_kind(adapter_name, configuration.clone())?;

        let node_path = worktree.which("node").ok_or_else(|| {
            "Node.js must be installed to use the AngelScript debug adapter".to_string()
        })?;

        // Try to get debug adapter path from:
        // 1. User-provided path
        // 2. Configuration's "debugAdapterPath" field
        // 3. Default path in home directory (using shell env)
        let debug_adapter_path = user_provided_debug_adapter_path
            .or_else(|| {
                configuration
                    .get("debugAdapterPath")
                    .and_then(|v| v.as_str())
                    .map(|s| s.to_string())
            })
            .or_else(|| {
                worktree
                    .shell_env()
                    .into_iter()
                    .find(|(k, _)| k == "HOME")
                    .map(|(_, home)| {
                        format!("{home}/.angelscript_debug_adapter/out/debugAdapter.js")
                    })
            })
            .ok_or_else(|| {
                "Could not find the AngelScript debug adapter. \
                Please set 'debugAdapterPath' in your debug configuration or \
                install the debug adapter to ~/.angelscript_debug_adapter/"
                    .to_string()
            })?;

        // Use a fixed port for the debug adapter TCP server
        let dap_port: u16 = 4712;

        // Get workspace root to pass to the debug adapter
        let workspace_root = worktree.root_path();

        Ok(DebugAdapterBinary {
            command: Some(node_path),
            arguments: vec![debug_adapter_path, format!("--server={}", dap_port)],
            envs: vec![("WORKSPACE_ROOTS".to_string(), workspace_root)],
            cwd: None,
            connection: Some(TcpArguments {
                host: Ipv4Addr::new(127, 0, 0, 1).to_bits(),
                port: dap_port,
                timeout: Some(10000), // 10 second timeout for connection
            }),
            request_args: StartDebuggingRequestArguments {
                configuration: config.config,
                request,
            },
        })
    }

    fn dap_request_kind(
        &mut self,
        _adapter_name: String,
        value: Value,
    ) -> Result<StartDebuggingRequestArgumentsRequest, String> {
        value
            .get("request")
            .and_then(|v| v.as_str())
            .ok_or("`request` was not specified".into())
            .and_then(|request| match request {
                "attach" => Ok(StartDebuggingRequestArgumentsRequest::Attach),
                "launch" => Ok(StartDebuggingRequestArgumentsRequest::Launch),
                _ => Err("`request` must be either `attach` or `launch`".into()),
            })
    }
}

zed::register_extension!(UnrealAngelscriptExtension);

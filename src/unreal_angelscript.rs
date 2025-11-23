use zed_extension_api as zed;

struct UnrealAngelscriptExtension;

impl zed::Extension for UnrealAngelscriptExtension {
    fn new() -> Self {
        Self
    }
}

zed::register_extension!(UnrealAngelscriptExtension);

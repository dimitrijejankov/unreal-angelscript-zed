; Preprocessor directives
(preprocessor_directive) @keyword

; Comments
(comment) @comment

; Keywords
[
 "class"
 "struct"
 "namespace"
 "delegate"
 "if"
 "else"
 "for"
 "while"
 "switch"
 "case"
 "default"
 "break"
 "continue"
 "return"
 "import"
 "in"
 "out"
 "inout"
 "const"
 "private"
 "protected"
 "public"
 "override"
 "mixin"
 "property"
 "access"
 "local"
] @keyword

; Primitive types as keywords
(primitive_type) @type.builtin

; Boolean literals
(boolean_literal) @boolean

; Unreal-specific macros
(uclass_macro
 "UCLASS" @keyword)
(ustruct_macro
 "USTRUCT" @keyword)
(uenum_macro
 "UENUM" @keyword)
(ufunction_macro
 "UFUNCTION" @keyword)
(uproperty_macro
 "UPROPERTY" @keyword)
(umeta_macro
 "UMETA" @keyword)

; Types
(custom_type (identifier) @type)
(template_type) @type

; Functions and methods
(function_declaration
 name: (identifier) @function)
(constructor_declaration
 name: (identifier) @constructor)
(destructor_declaration
 name: (identifier) @function)
(global_function_declaration
 name: (identifier) @function)
(delegate_declaration
 name: (identifier) @type)
(event_declaration
 name: (identifier) @type)

; Function calls
(call_expression
 function: (member_expression
   property: (identifier) @function))
(call_expression
 function: (primary_expression (identifier) @function))

; Variables and parameters
(parameter
 name: (identifier) @variable)
(property_declaration
 name: (identifier) @property)

; Class, struct, enum declarations
(class_declaration
 name: (identifier) @type)
(struct_declaration
 name: (identifier) @type)
(enum_declaration
 name: (identifier) @type)
(enum_value
 name: (identifier) @constant)
(namespace_declaration
 (identifier) @namespace)

; Literals
(string_literal) @string
(name_literal) @string.special.symbol
(integer_literal) @number
(float_literal) @number
(nullptr_literal) @constant

; Operators
[
 "+"
 "-"
 "*"
 "/"
 "%"
 "="
 "+="
 "-="
 "*="
 "/="
 "%="
 "&="
 "|="
 "^="
 "<<"
 ">>"
 "&"
 "|"
 "^"
 "~"
 "&&"
 "||"
 "!"
 "=="
 "!="
 "<"
 ">"
 "<="
 ">="
 "?"
 ":"
 "::"
 "->"
 "++"
 "--"
] @operator

; Punctuation
[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
 "."
 ","
 ";"
] @punctuation

; Macro arguments
(macro_argument (identifier) @attribute)

; Special
(this_expression) @variable.builtin

; Identifiers in primary expressions (fallback)
(primary_expression (identifier) @variable)

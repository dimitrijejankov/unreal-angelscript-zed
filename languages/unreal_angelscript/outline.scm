; Classes
(class_declaration
  name: (identifier) @name) @item

; Structs
(struct_declaration
  name: (identifier) @name) @item

; Enums
(enum_declaration
  name: (identifier) @name) @item

; Namespaces
(namespace_declaration
  (identifier) @name) @item

; Global functions
(global_function_declaration
  name: (identifier) @name) @item

; Methods
(function_declaration
  name: (identifier) @name) @item

; Delegates
(delegate_declaration
  name: (identifier) @name) @item

; Events
(event_declaration
  name: (identifier) @name) @item

; Constructors
(constructor_declaration
  name: (identifier) @name) @item

; Destructors
(destructor_declaration
  name: (identifier) @name) @item

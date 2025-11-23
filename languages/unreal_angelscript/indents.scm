; Indent after opening brace
("{" @indent)
("}" @outdent)

; Block statements
(block_statement) @indent

; Function body
(function_body) @indent

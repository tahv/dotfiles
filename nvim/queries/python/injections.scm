; extends

(expression_statement
  (string
    (string_start)
    (string_content) @injection.content
    (string_end))
  (#set! injection.language "pydoc"))

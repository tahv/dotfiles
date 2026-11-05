; extends

(docstring
  (statement
    (statement_content) @injection.content)
    (#set! injection.language "python")
    (#set! priority 120))

(docstring
  (statement
    (statement_result) @injection.content)
    (#set! injection.language "python")
    (#set! priority 120))

; extends

; Quadruple backticks 
(fenced_code_block
  (fenced_code_block_delimiter) @_delim
  (#eq? @_delim "````")) @quad.outer

(fenced_code_block
  (fenced_code_block_delimiter) @_delim
  (code_fence_content) @quad.inner
  (#eq? @_delim "````"))

; extends

; ; Triple backticks (mapped to 'm' globally)
; (fenced_code_block
;   (fenced_code_block_delimiter) @_delim
;   (#eq? @_delim "```")) @triple.outer
;
; (fenced_code_block
;   (fenced_code_block_delimiter) @_delim
;   (code_fence_content) @triple.inner
;   (#eq? @_delim "```"))
;
; Quadruple backticks (mapped to 'M' globally)
(fenced_code_block
  (fenced_code_block_delimiter) @_delim
  (#eq? @_delim "````")) @quad.outer

(fenced_code_block
  (fenced_code_block_delimiter) @_delim
  (code_fence_content) @quad.inner
  (#eq? @_delim "````"))

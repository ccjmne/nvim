-- Highlight artifactId and version in Maven's pom.xml
-- and mute everything else.
local lens = false
vim.keymap.set('n', '<Leader>tz', function()
  lens = not lens
  vim.treesitter.query.set('xml', 'highlights', lens and [[
    (Comment)            @comment
    (STag (Name)         @punctuation)
    (ETag (Name)         @punctuation)
    (EmptyElemTag (Name) @punctuation)

    (element
      (STag (Name) @green.bold (#any-of? @green.bold "artifactId" "version"))
      (content)    @text.bold
      (ETag (Name) @green.bold))

    (document
      root:
      (element
        (STag (Name) @root_tag (#eq? @root_tag "project"))
        (content
          (element
            (STag (Name) @yellow.bold (#any-of? @yellow.bold "artifactId" "version"))
            (content)    @text.bold
            (ETag (Name) @yellow.bold)))))
  ]] or nil)
  local buf = vim.api.nvim_get_current_buf()
  if vim.treesitter.highlighter.active[buf] then
    vim.treesitter.stop(buf, 'xml')
    vim.treesitter.start(buf, 'xml')
  end
end, { buffer = true })

-- set to 1, nvim will open the preview window after entering the Markdown buffer
-- default: 0
vim.g.mkdp_auto_start = 0

-- specify browser to open preview page
-- for path with space
-- valid: `/path/with\ space/xxx`
-- invalid: `/path/with\\ space/xxx`
-- default: ''
vim.g.mkdp_browser = ''

vim.cmd([[
  function OpenMarkdownPreview (url)
    execute "silent ! brave --incognito " . a:url
  endfunction
  let g:mkdp_browserfunc = 'OpenMarkdownPreview'
]])

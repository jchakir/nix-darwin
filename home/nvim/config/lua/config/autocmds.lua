-- let <, >, [, ], h and l wrap to the previous/next line
vim.cmd("set whichwrap+=<,>,[,],h,l")
-- treat '-' as part of a word
vim.cmd([[set iskeyword+=-]])
-- no automatic comment wrapping or comment leader on new lines
vim.cmd([[set formatoptions-=cro]])

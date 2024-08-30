-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

-- note: nvim and nvchad do not like the entrypoint to be a symlink
--       so, we patch it to just make the entrypoint our symlinked stuff

---@type ChadrcConfig
return require('custom.config')

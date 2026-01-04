local M = {}
local cache = {}

function M.load(path)
    if cache[path] then return end
    cache[path] = true
    
    local dir = vim.fn.stdpath("config") .. "/lua/" .. path:gsub("%.", "/")
    local handle = vim.loop.fs_scandir(dir)
    if not handle then return end
    
    while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then break end
        
        if type == "directory" then
            M.load(path .. "." .. name)
        elseif name:match("%.lua$") and not name:match("%.skip$") then
            pcall(require, path .. "." .. name:gsub("%.lua$", ""))
        end
    end
end

-- Lazy load on event/filetype
function M.lazy(path, opts)
    opts = opts or {}
    
    if opts.event then
        vim.api.nvim_create_autocmd(opts.event, {
            once = true,
            callback = function()
                M.load(path)
            end
        })
    elseif opts.ft then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = opts.ft,
            once = true,
            callback = function()
                M.load(path)
            end
        })
    else
        vim.schedule(function() M.load(path) end)
    end
end

return M

---@meta clink

---@class clink
clink = {}

--- Registers func to be called after Clink's edit prompt ends.
--- The function receives a string argument containing the input text from the edit prompt.
--- The function returns up to two values.
--- If the first is not nil then it's a string that replaces the edit prompt text.
--- If the second is not nil and is false then it stops further onfilterinput handlers from running.
--- Starting in v1.3.13 func may return a table of strings, and each is executed as a command line.
---@param func fun(line: string): [string | string[] | nil, boolean | nil]
---@return nil
function clink.onfilterinput(func) end

---@class _argmatcher

---@param ... string
---@return _argmatcher
function clink.argmatcher(...) end

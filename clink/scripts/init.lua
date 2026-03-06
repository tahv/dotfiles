--- Register a doskey
---@param short string
---@param long string
local function alias(short, long)
	os.execute("doskey " .. short .. "=" .. long)
end

-- alias("cdd", "cd /D D:\\dev\\$1")
alias("cdp", "cd /D D:\\p4ws\\$1")
alias("ls", "dir /B $*")
alias("clear", "cls")
alias("rgf", "rg --files ^| rg $*")

---@param line string
---@return string | string[] | nil
---@return boolean | nil
local function command_cdd(line)
    local prefix = "^ *cdd *"
	if line:match(prefix) then
        line = line:gsub(prefix, "")
	else
		return
	end
    line = "cd /D D:\\dev\\" .. line
    return line, false
end

clink.onfilterinput(command_cdd)

--- Register a doskey
---@param short string
---@param long string
local function alias(short, long)
	os.execute("doskey " .. short .. "=" .. long)
end

alias("cdd", "cd /D D:\\dev\\$1")
alias("cdp", "cd /D D:\\p4ws\\$1")
alias("ls", "dir /B $*")
alias("clear", "cls")
alias("rgf", "rg --files ^| rg $*")
alias("which", "where $*")
alias("pp", '@for %g in ("%PATH:;=" "%")Do @Echo(%~g')
alias("mr", "mise run $*")

-- Load starship
load(io.popen("starship init cmd"):read("*a"))()

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

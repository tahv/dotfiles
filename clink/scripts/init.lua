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
alias("which", "where $*")
alias("cat", "type $*")
alias("pp", 'cmd /v:on /c "for %p in ("!path:;=" "!") do @echo(%~p"')
alias("mr", "mise run $*")
-- alias("rgf", "rg --files ^| rg $*")

load(io.popen("starship init cmd"):read("*a"))()

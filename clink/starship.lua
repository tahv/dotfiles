-- NOTE: hijacking the 'starship.lua' script as an entrypoint to load lua scripts

-- Load starship

load(io.popen('starship init cmd'):read("*a"))()

-- Register doskeys

local function alias(short, long)
    os.execute('doskey ' .. short .. '=' .. long)
end

alias('cdd', 'cd /D D:\\dev\\$1')
alias('ls', 'dir /B $*')

os.setenv("CLINK_COLORTHEME", "Tomorrow Night")

os.setalias("cdd", [[cd /D D:\dev\$*]])
os.setalias("cdp", [[cd /D D:\p4ws\$*]])
os.setalias("ls", "dir /B $*")
os.setalias("clear", "cls")
os.setalias("which", "where $*")
os.setalias("cat", "type $*")
os.setalias("pp", 'cmd /v:on /c "for %p in ("!path:;=" "!") do @echo(%~p"')
os.setalias("mr", "mise run $*")
-- os.setalias("rgf", "rg --files ^| rg $*")

load(io.popen("starship init cmd"):read("*a"))()

timer.Create("SetBuildMode",60,0,function()
RunConsoleCommand("acf_setdefaultpermissionmode","strictbuild")
RunConsoleCommand("acf_setpermissionmode","strictbuild")
end)

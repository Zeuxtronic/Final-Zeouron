getgenv().T = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zeuxtronic/Final-Zeouron/refs/heads/main/Libraries/ZeoTool.lua"))()

T.ConstructFolder()
if not getgenv().ZeouronExecuted or readfile("Zeouron/Settings/Developer.txt") == "true" then
	T.GetFragment("Startup")
end
getgenv().ZeouronExecuted = true
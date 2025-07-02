local lp = game.Players.LocalPlayer
local plr = lp
local WS = game.Workspace
local CG = game:GetService("CoreGui")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")

local Data = T.GetTheme()

local SupportedGames = T.GetConfig("Supported")
local Icons = T.GetLibrary("Icons")

local G = T.NewGui("Startup")
G.Enabled = false

ExecuteScript = function()
    local Scriptsupported = false
	for i,v in pairs(SupportedGames) do
     	if v.Type == "Engine" then
        	if v.EngineDetectionMethod() then
            	Scriptsupported = true
             
             	loadstring(game:HttpGet(v.Script))()
           
           		T.Notification("Hey", "Join our discord for: Updates, information, community and more!")
            end
        end
    	if v.ID == game.PlaceId and v.Type == "GameSupport" then
        	Scriptsupported = true
         	if v.Discontinued then
            	T.Popups.YN("Warning","This games script is disconntinued, if you get banned, it is not our fault.",function()
    				loadstring(game:HttpGet(v.Script))()
    			end)
            else
            	T.Notification("Hey", "Join our discord for: Updates, information, community and more!",5)
             	loadstring(game:HttpGet(v.Script))()
            end
        elseif v.Type == "GameSupport" then
        	if v.GOTOID == game.PlaceId and v.GOTOID ~= v.ID then
             	Scriptsupported = true
              	T.Popups.OK("Uh oh..",v.WrongSupport)
            end
    	end
	end

	if not Scriptsupported then
		T.Popups.OK("Unfortunately...","Game not supported. Request game support on the Zeouron Discord server")
  	end
end

local MainFrame = Instance.new("ScrollingFrame", G)

MainFrame.Size = UDim2.new(0,310,0,460)
MainFrame.Position = UDim2.new(0.5,0,0.5,0)
MainFrame.BackgroundColor3 = Data.BgC
MainFrame.BorderColor3 = Data.Color
MainFrame.ScrollBarImageColor3 = Data.Color
MainFrame.ScrollBarImageTransparency = 0
MainFrame.CanvasSize = UDim2.new(0,0,0,0)
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
MainFrame.ZIndex = 25

T.AddBlur(MainFrame)
T.AddRound(MainFrame)

SupportFrameExpanded = false

local SupportFrame = Instance.new("ScrollingFrame", G)

SupportFrame.Size = UDim2.new(0,310,0,460)
SupportFrame.Position = UDim2.new(0.5,0,0.5,0)
SupportFrame.BackgroundColor3 = Data.BgC
SupportFrame.BorderColor3 = Data.Color
SupportFrame.ScrollBarImageColor3 = Data.Color
SupportFrame.ScrollBarImageTransparency = 1
SupportFrame.CanvasSize = UDim2.new(0,0,0,0)
SupportFrame.AnchorPoint = Vector2.new(0.5,0.5)
SupportFrame.ZIndex = 2

T.AddBlur(SupportFrame)
T.AddRound(SupportFrame)

local SupportArrow = Instance.new("ImageButton", SupportFrame)

SupportArrow.Size = UDim2.new(0,37,0,37)
SupportArrow.Position = UDim2.new(1,-37,1,-37)
SupportArrow.BackgroundColor3 = Data.BgC
SupportArrow.ImageColor3 = Data.Color
SupportArrow.BorderSizePixel = 0
SupportArrow.Image = Icons["arrow-up-left"]
SupportArrow.AutoButtonColor = false
SupportArrow.ZIndex = 4

local SupportTitle = Instance.new("TextLabel", SupportFrame)

SupportTitle.Size = UDim2.new(1,0,0,30)
SupportTitle.Position = UDim2.new(0,0,0,0)
SupportTitle.BorderSizePixel = 0
SupportTitle.BackgroundColor3 = Data.BgC
SupportTitle.Text = "Supported Games"
SupportTitle.TextScaled = true
SupportTitle.TextColor3 = Data.Color
SupportTitle.Font = Data.Font
SupportTitle.ZIndex = 4

local SupportedGameLabel = Instance.new("TextButton", SupportFrame)

SupportedGameLabel.Size = UDim2.new(0,220,0,20)
SupportedGameLabel.Position = UDim2.new(0.5,0,0,45)
SupportedGameLabel.BackgroundTransparency = 1
SupportedGameLabel.Text = "Supported Games"
SupportedGameLabel.Font = Data.Font
SupportedGameLabel.TextScaled = true
SupportedGameLabel.TextColor3 = Data.Color
SupportedGameLabel.AnchorPoint = Vector2.new(0.5,0)
SupportedGameLabel.ZIndex = 5

SupportPos = 35
for _,v in pairs(SupportedGames) do
    if v.Type == "GameSupport" then
        SupportPos += 32
        local frame = Instance.new("Frame", SupportFrame)
        frame.Size = UDim2.new(1,-40,0,30)
        frame.Position = UDim2.new(0,20,0,SupportPos)
        frame.BackgroundColor3 = Data.DarkerC
        frame.BorderColor3 = Data.DarkestC
        frame.BorderSizePixel = 2
       	frame.ZIndex = 6
        
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1,-30,1,0)
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0,0,0,0)
        label.BackgroundColor3 = Data.DarkerC
        label.Text = v.GameName
        label.TextColor3 = Data.Color
        label.TextScaled = true
        label.TextXAlignment = "Left"
        label.Font = Data.Font
        label.ZIndex = 6
        
        if v.Discontinued then
            label.Position = UDim2.new(0,20,0,0)
            label.Size = UDim2.new(1,-70,1,0)
            
            local exclamation = Instance.new("TextButton", frame)
        	exclamation.Size = UDim2.new(0,20,1,0)
        	exclamation.BackgroundTransparency = 1
        	exclamation.Position = UDim2.new(0,0,0,0)
        	exclamation.BackgroundColor3 = Data.DarkerC
        	exclamation.Text = "!"
        	exclamation.TextColor3 = Color3.fromRGB(225,0,0)
        	exclamation.TextScaled = true
        	exclamation.Font = Data.Font
         	exclamation.ZIndex = 6
         
         	exclamation.MouseButton1Click:Connect(function()
            	T.Popups.OK("Warning", "This script is disconntinued! Most of not all features might not work.")
    		end)
        end
        
        local arrow = Instance.new("TextButton", frame)
        arrow.Size = UDim2.new(0,30,1,0)
        arrow.BackgroundTransparency = 1
        arrow.Position = UDim2.new(1,-30,0,0)
        arrow.BackgroundColor3 = Data.DarkerC
        arrow.Text = ">"
        arrow.TextColor3 = Data.Color
        arrow.TextScaled = true
        arrow.TextXAlignment = "Left"
        arrow.Font = Enum.Font.Arcade
        arrow.ZIndex = 6
        
        arrow.MouseButton1Click:Connect(function()
            T.Popups.YN("Teleport?","Do you wish to teleport to "..v.GameName.."?",function()
        		game:GetService("TeleportService"):Teleport(v.GOTOID)
        	end)
    	end)
    end
end

SupportPos += 50

local SupportedEngineLabel = Instance.new("TextButton", SupportFrame)

SupportedEngineLabel.Size = UDim2.new(0,220,0,20)
SupportedEngineLabel.Position = UDim2.new(0.5,0,0,SupportPos)
SupportedEngineLabel.BackgroundTransparency = 1
SupportedEngineLabel.Text = "Supported Engines"
SupportedEngineLabel.Font = Data.Font
SupportedEngineLabel.TextScaled = true
SupportedEngineLabel.TextColor3 = Data.Color
SupportedEngineLabel.ZIndex = 5
SupportedEngineLabel.AnchorPoint = Vector2.new(0.5,0)

SupportPos += 22

for _,v in pairs(SupportedGames) do
    if v.Type == "Engine" then
        local frame = Instance.new("Frame", SupportFrame)
        frame.Size = UDim2.new(1,-40,0,30)
        frame.Position = UDim2.new(0,20,0,SupportPos)
        frame.BackgroundColor3 = Data.DarkerC
        frame.BorderColor3 = Data.DarkestC
        frame.BorderSizePixel = 2
       	frame.ZIndex = 6
        
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0,0,0,0)
        label.BackgroundColor3 = Data.DarkerC
        label.Text = v.EngineName
        label.TextColor3 = Data.Color
        label.TextScaled = true
        label.TextXAlignment = "Left"
        label.Font = Data.Font
        label.ZIndex = 6
        SupportPos += 32
    end
end

UpdateFrameExpanded = false

local update = game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/main/CurrentUpdate.lua')
updatelog = ""

for i,v in pairs(string.split(update,"\n")) do
    if i ~= 1 and i ~= 2 then
        updatelog = updatelog.."\n"..v
    end
end

local UpdateFrame = Instance.new("Frame", G)

UpdateFrame.Size = UDim2.new(0,310,0,460)
UpdateFrame.Position = UDim2.new(0.5,0,0.5,0)
UpdateFrame.BackgroundColor3 = Data.BgC
UpdateFrame.BorderColor3 = Data.Color
UpdateFrame.ZIndex = 2
UpdateFrame.AnchorPoint = Vector2.new(0.5,0.5)

T.AddBlur(UpdateFrame)
T.AddRound(UpdateFrame)

local UpdateArrow = Instance.new("ImageButton", UpdateFrame)

UpdateArrow.Size = UDim2.new(0,37,0,37)
UpdateArrow.Position = UDim2.new(0,0,0,460-37)
UpdateArrow.BackgroundColor3 = Data.BgC
UpdateArrow.ImageColor3 = Data.Color
UpdateArrow.BorderSizePixel = 0
UpdateArrow.Image = Icons["arrow-up-right"]
UpdateArrow.AutoButtonColor = false
UpdateArrow.ZIndex = 4

local UpdateScroll = Instance.new("ScrollingFrame", UpdateFrame)

UpdateScroll.Size = UDim2.new(1,0,1,-30)
UpdateScroll.Position = UDim2.new(0,0,0,30)
UpdateScroll.BackgroundColor3 = Data.BgC
UpdateScroll.BorderSizePixel = 0
UpdateScroll.ScrollBarImageColor3 = Data.Color
UpdateScroll.ScrollBarImageTransparency = 1
UpdateScroll.CanvasSize = UDim2.new(0,0,0,game:GetService("TextService"):GetTextSize(updatelog, 24, Enum.Font.Sarpanch, Vector2.new(math.huge, math.huge)).Y +60)
UpdateScroll.ElasticBehavior = "Never"
UpdateScroll.ScrollingDirection = "Y"
UpdateScroll.ZIndex = 3

local UpdateTitle = Instance.new("TextLabel", UpdateFrame)

UpdateTitle.Size = UDim2.new(1,0,0,30)
UpdateTitle.Position = UDim2.new(0,0,0,0)
UpdateTitle.BorderSizePixel = 0
UpdateTitle.BackgroundColor3 = Data.BgC
UpdateTitle.Text = string.split(update),"\n")[1]
UpdateTitle.TextScaled = true
UpdateTitle.TextColor3 = Data.Color
UpdateTitle.Font = Data.Font
UpdateTitle.ZIndex = 4

local UpdateText = Instance.new("TextLabel", UpdateScroll)

UpdateText.Size = UDim2.new(0,999,0,9999)
UpdateText.Position = UDim2.new(0,17,0,0)
UpdateText.BackgroundTransparency = 1
UpdateText.Text = updatelog
UpdateText.TextSize = 24
UpdateText.TextColor3 = Data.Color
UpdateText.Font = Enum.Font.Sarpanch
UpdateText.TextXAlignment = "Left"
UpdateText.TextYAlignment = "Top"
UpdateText.ZIndex = 3

local ZeouronIcon = Instance.new("ImageLabel", MainFrame)

ZeouronIcon.Position = UDim2.new(0,20,0,50)
ZeouronIcon.Size = UDim2.new(0,310 -40,0,310 -40)
ZeouronIcon.BackgroundTransparency = 1
ZeouronIcon.ImageColor3 = Data.Color
ZeouronIcon.ZIndex = 26
if readfile("Zeouron/Settings/MainColor.txt") ~= "130,35,175" then
	ZeouronIcon.Image = T.LoadAsset("LogoCustom.png")
 	ZeouronIcon.Position = UDim2.new(0,0,0,30)
	ZeouronIcon.Size = UDim2.new(0,310,0,310)
else
	ZeouronIcon.Image = T.LoadAsset("LogoMain.png")
 	ZeouronIcon.ImageColor3 = Color3.new(1,1,1)
end

local ZeouronLabel = Instance.new("TextButton", MainFrame)

ZeouronLabel.Size = UDim2.new(0.4,0,0,30)
ZeouronLabel.Position = UDim2.new(0.5,0,0,0)
ZeouronLabel.BackgroundTransparency = 1
ZeouronLabel.Text = "Zeouron"
ZeouronLabel.Font = Data.Font
ZeouronLabel.TextScaled = true
ZeouronLabel.TextColor3 = Data.Color
ZeouronLabel.AnchorPoint = Vector2.new(0.5,0)
ZeouronLabel.ZIndex = 26

local SettingsIcon = Instance.new("ImageButton", MainFrame)

SettingsIcon.Size = UDim2.new(0,20,0,20)
SettingsIcon.Position = UDim2.new(0,5,0,5)
SettingsIcon.BackgroundTransparency = 1
SettingsIcon.Image = "rbxassetid://14403726449"
SettingsIcon.ImageColor3 = Data.Color
SettingsIcon.ZIndex = 26

local DiscordIcon = Instance.new("ImageButton", MainFrame)

DiscordIcon.Size = UDim2.new(0,20,0,20)
DiscordIcon.Position = UDim2.new(1,-25,0,5)
DiscordIcon.BackgroundTransparency = 1
DiscordIcon.Image = T.LoadAsset("discord.png")
DiscordIcon.ZIndex = 26

DiscordIcon.MouseButton1Click:Connect(function()
    T.Popups.YN("Discord Community","Would you like to copy the link to the Zeouron Discord Server?",function()
    	setclipboard(tostring(Data.DiscordLink))
    end)
end)

local Exec = Instance.new("TextButton")

Exec.Position = UDim2.new(0,25,0,390 -33 -25 +(33 *2))
Exec.Size = UDim2.new(0,310 -50,0,33) -- 70
Exec.Parent = MainFrame
Exec.BackgroundColor3 = Data.DarkC
Exec.BorderColor3 = Data.DarkerC
Exec.ZIndex = 26
Exec.Font = Data.Font
Exec.TextColor3 = Data.Color
Exec.TextScaled = true
Exec.Text = "Execute"

local SettingsFrame = Instance.new("ScrollingFrame", G)

SettingsFrame.Size = UDim2.new(0,496,0,0)
SettingsFrame.Position = UDim2.new(0.5,0,0.5,0)
SettingsFrame.BackgroundColor3 = Data.BgC
SettingsFrame.BorderColor3 = Data.Color
SettingsFrame.ScrollBarImageColor3 = Data.Color
SettingsFrame.ScrollBarImageTransparency = 0
SettingsFrame.CanvasSize = UDim2.new(0,0,0,0)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.ZIndex = 40
SettingsFrame.AnchorPoint = Vector2.new(0.5,0.5)

SettingsIcon.MouseButton1Click:Connect(function()
    if SettingsFrame.Size == UDim2.new(0,496,0,368) then
        T.Tween({
            SettingsFrame,
            "Size",
            0.3,
            UDim2.new(0,496,0,0)
        })
    	T.Tween({
            SettingsFrame,
            "BorderSizePixel",
            0.3,
            0
        })
    elseif SettingsFrame.Size == UDim2.new(0,496,0,0) then
    	T.Tween({
            SettingsFrame,
            "Size",
            0.3,
            UDim2.new(0,496,0,368)
        })
    	T.Tween({
            SettingsFrame,
            "BorderSizePixel",
            0.3,
            1
        })
    end
end)

local SettingsLabel = Instance.new("TextButton", SettingsFrame)

SettingsLabel.Size = UDim2.new(0.5,0,0,25)
SettingsLabel.Position = UDim2.new(0.5,0,0,0)
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Text = "Settings"
SettingsLabel.Font = Data.Font
SettingsLabel.TextScaled = true
SettingsLabel.TextColor3 = Data.Color
SettingsLabel.AnchorPoint = Vector2.new(0.5,0)
SettingsLabel.ZIndex = 41

local Remove = Instance.new("TextButton", SettingsFrame)

Remove.Size = UDim2.new(0,25,0,25)
Remove.Position = UDim2.new(1,-25,0,0)
Remove.BackgroundTransparency = 1
Remove.Text = "X"
Remove.Font = Data.Font
Remove.TextScaled = true
Remove.TextColor3 = Data.Color
Remove.ZIndex = 41

Remove.MouseButton1Click:Connect(function()
    T.Tween({
        SettingsFrame,
        "Size",
        0.5,
        UDim2.new(0,496,0,0)
    })
    T.Tween({
        SettingsFrame,
        "BorderSizePixel",
        0.5,
        0
    })
end)

SettingsFeatures = 0
local SettingsLib = {
    NewButton = function(name, func)
    	local TabFrame = Instance.new("TextButton", SettingsFrame)

		TabFrame.Size = UDim2.new(1,-40,0,37)
		TabFrame.Position = UDim2.new(0,20,0,(SettingsFeatures) +50)
		TabFrame.BackgroundColor3 = Data.DarkerC
		TabFrame.Text = name
		TabFrame.Font = Data.Font
		TabFrame.TextScaled = true
		TabFrame.TextColor3 = Data.Color
  		TabFrame.ZIndex = 41
    
    	Round(TabFrame, 0.05)
     
    	SettingsFeatures += 47
    
    	TabFrame.MouseButton1Click:Connect(function()
           	spawn(func)
        end)
	end,
	NewTextBox = function(name, default, func)
    	local TabFrame = Instance.new("TextBox", SettingsFrame)

		TabFrame.Size = UDim2.new(1,-40,0,37)
  		TabFrame.Position = UDim2.new(0,20,0,(SettingsFeatures) +50)
		TabFrame.BackgroundColor3 = Data.DarkerC
		TabFrame.Text = name
		TabFrame.Font = Data.Font
		TabFrame.TextScaled = true
   		TabFrame.TextSize = 23
		TabFrame.TextColor3 = Data.Color
  		TabFrame.ZIndex = 41
    
   		T.AddRound(TabFrame, 0.05)
    
   		SettingsFeatures += 47
    
   		local BoxContents = default
   		TabFrame.Focused:Connect(function()
     		TabFrame.Text = BoxContents
        end)
        TabFrame.FocusLost:Connect(function()
        	BoxContents = TabFrame.Text
         	local funcs = {
            	SetText = function(text)
                	BoxContents = text
                end
            }
            spawn(function()
            	func(BoxContents, funcs)
            end)
            TabFrame.Text = name
        end)
    end,
	NewLabel = function(name)
    	local TabFrame = Instance.new("TextLabel", SettingsFrame)

		TabFrame.Size = UDim2.new(1,-40,0,18.5)
		TabFrame.Position = UDim2.new(0,20,0,(SettingsFeatures) +50)
		TabFrame.BackgroundTransparency = 1
		TabFrame.Text = name
		TabFrame.Font = Data.Font
		TabFrame.TextScaled = true
		TabFrame.TextColor3 = Data.Color
  		TabFrame.ZIndex = 41
    
    	T.AddRound(TabFrame, 0.05)
    
    	SettingsFeatures += 18.5
	end,
	NewSwitch = function(name, func, switch)
    	local TabFrame = Instance.new("TextLabel", SettingsFrame)

		TabFrame.Size = UDim2.new(1,-40,0,37)
		TabFrame.Position = UDim2.new(0,20,0,(SettingsFeatures) +50)
		TabFrame.BackgroundColor3 = Data.DarkerC
		TabFrame.Text = name
		TabFrame.Font = Data.Font
		TabFrame.TextScaled = true
		TabFrame.TextColor3 = Data.Color
  		TabFrame.ZIndex = 41
    
    	local Switcher = Instance.new("TextButton", TabFrame)

		Switcher.Size = UDim2.new(0,22,0,22)
		Switcher.Position = UDim2.new(1,-29.5,0,7.5)
  		if not switch then
			Switcher.BackgroundColor3 = Data.DarkC
   		else
     		Switcher.BackgroundColor3 = Data.Color
  		end
		Switcher.Text = ""
  		Switcher.ZIndex = 41
    
    	T.AddRound(TabFrame, 0.05)
       	T.AddRound(Switcher, 0.05)
    
    	SettingsFeatures += 47
       
       	local switchon = switch
       	Switcher.MouseButton1Click:Connect(function()
            if switchon then
            	switchon = false
                Switcher.BackgroundColor3 = Data.DarkC
                spawn(function()
                	func(false)
                end)
            else
            	switchon = true
                Switcher.BackgroundColor3 = Data.Color
                spawn(function()
               		func(true)
                end)
           	end
    	end)
	end,
}

local constructcolor = function(str)
    local split = string.split(str,",")
    return Color3.fromRGB(tonumber(split[1]),tonumber(split[2]), tonumber(split[3]))
end

red = tostring(math.round(constructcolor(readfile("Zeouron/Settings/MainColor.txt")).R *255))
blue = tostring(math.round(constructcolor(readfile("Zeouron/Settings/MainColor.txt")).G *255))
green = tostring(math.round(constructcolor(readfile("Zeouron/Settings/MainColor.txt")).B *255))
Colorprevtext = red..","..blue..","..green
SettingsLib.NewTextBox("Color", Colorprevtext, function(text, textbox)
    if #string.split(text, ",") == 3 then
        local split = string.split(text, ",")
        split[1] = split[1]:gsub("%D", "")
        split[2] = split[2]:gsub("%D", "")
        split[3] = split[3]:gsub("%D", "")
        if string.split(split[1], "") == 0 then
        	split[1] = 0
        end
    	if string.split(split[2], "") == 0 then
        	split[2] = 0
        end
    	if string.split(split[3], "") == 0 then
        	split[3] = 0
        end
        Colorprevtext = tostring(tonumber(split[1]))..","..tostring(tonumber(split[2]))..","..tostring(tonumber(split[3]))
        writefile("Zeouron/Settings/MainColor.txt", Colorprevtext)
        UpdateTheme()
        ChangeTab(ExecuteTab)
    else
    	textbox.SetText(Colorprevtext)
    end
end)

red = tostring(math.round(constructcolor(readfile("Zeouron/Settings/BgColor.txt")).R *255))
blue = tostring(math.round(constructcolor(readfile("Zeouron/Settings/BgColor.txt")).G *255))
green = tostring(math.round(constructcolor(readfile("Zeouron/Settings/BgColor.txt")).B *255))
Bgprevtext = red..","..blue..","..green
SettingsLib.NewTextBox("Background Color", Bgprevtext, function(text, textbox)
    if #string.split(text, ",") == 3 then
        print(text)
        local split = string.split(text, ",")
        split[1] = split[1]:gsub("%D", "")
        split[2] = split[2]:gsub("%D", "")
        split[3] = split[3]:gsub("%D", "")
        if string.split(split[1], "") == 0 then
        	split[1] = 0
        end
    	if string.split(split[2], "") == 0 then
        	split[2] = 0
        end
    	if string.split(split[3], "") == 0 then
        	split[3] = 0
        end
        Bgprevtext = tostring(tonumber(split[1]))..","..tostring(tonumber(split[2]))..","..tostring(tonumber(split[3]))
        writefile("Zeouron/Settings/BgColor.txt", Bgprevtext)
        UpdateTheme()
        ChangeTab(ExecuteTab)
    else
    	textbox.SetText(Bgprevtext)
    end
end)

visibillitybutton = false
if readfile("Zeouron/Settings/Onoff.txt") == "true" then
    visibillitybutton = true
end 
SettingsLib.NewSwitch("Visiblility button", function(bool)
    writefile("Zeouron/Settings/Onoff.txt", tostring(bool))
end,visibillitybutton)

wait(1)
G.Enabled = true

T.Tween({
    UpdateFrame,
    "Position",
    1,
    UDim2.new(0.5,320,0.5,0)
})

T.Tween({
    SupportFrame,
    "Position",
    1,
    UDim2.new(0.5,-320,0.5,0)
})

wait(1)

Exec.MouseButton1Click:Connect(function()
    if executed ~= true then
        executed = true
        
        T.Tween({
            SettingsFrame,
            "Size",
            0.5,
            UDim2.new(0,496,0,0)
        })
    	T.Tween({
            SettingsFrame,
            "BorderSizePixel",
            0.5,
            0
        })
        
    	T.Tween({
            UpdateFrame,
            "Position",
            0.9,
            UDim2.new(0.5,0,0.5,0)
        })
    
    	T.Tween({
            SupportFrame,
            "Position",
            0.9,
            UDim2.new(0.5,0,0.5,0)
        })
    
    	wait(0.9)
        SupportFrame:Destroy()
        UpdateFrame:Destroy()
        MainFrame.BorderSizePixel = 0
        
    	T.Tween({
            MainFrame,
            "Size",
            0.5,
            UDim2.new(0,310,0,0)
        })
    
    	T.Tween({
            MainFrame,
            "Size",
            0.5,
            UDim2.new(0,310,0,0)
        })
    
    	wait(0.5)
     	MainFrame:Destroy()
      	wait(0.5)
        ExecuteScript()
	end
end)
UpdateArrow.MouseButton1Click:Connect(function()
    if not UpdateFrameExpanded then
        UpdateFrameExpanded = true
        UpdateFrame.ZIndex += 25
        UpdateArrow.ZIndex += 25
        UpdateScroll.ZIndex += 25
        UpdateTitle.ZIndex += 25
        UpdateText.ZIndex += 25
    	T.Tween({
            UpdateFrame,
            "Position",
            0.5,
            UDim2.new(0.5,0,0.5,0)
        })
    	T.Tween({
            SupportFrame,
            "Position",
            0.5,
            UDim2.new(0.5,0,0.5,0)
        })
    	wait(0.5)
    	T.Tween({
            UpdateFrame,
            "Size",
            0.5,
            UDim2.new(0,620,0,460)
        })
    	else
     	UpdateFrameExpanded = false
    	T.Tween({
            UpdateFrame,
            "Size",
            0.5,
            UDim2.new(0,310,0,460)
        })
    	wait(0.5)
    	T.Tween({
            UpdateFrame,
            "Position",
            0.5,
            UDim2.new(0.5,320,0.5,0)
        })
    	T.Tween({
            SupportFrame,
            "Position",
            0.5,
            UDim2.new(0.5,-320,0.5,0)
        })
    	wait(0.5)
    	UpdateFrame.ZIndex -= 25
        UpdateArrow.ZIndex -= 25
        UpdateScroll.ZIndex -= 25
        UpdateTitle.ZIndex -= 25
        UpdateText.ZIndex -= 25
 	end
end)
SupportArrow.MouseButton1Click:Connect(function()
    if not SupportFrameExpanded then
        SupportFrameExpanded = true
        SupportFrame.ZIndex += 25
        for _,v in pairs(SupportFrame:GetDescendants()) do
            if v:IsA("Frame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("ImageButton") or v:IsA("ImageLabel") then
            	v.ZIndex += 25
            end
        end
    	T.Tween({
            UpdateFrame,
            "Position",
            0.5,
            UDim2.new(0.5,0,0.5,0)
        })
    	T.Tween({
            SupportFrame,
            "Position",
            0.5,
            UDim2.new(0.5,0,0.5,0)
        })
    	wait(0.5)
    	T.Tween({
            SupportFrame,
            "Size",
            0.5,
            UDim2.new(0,620,0,460)
        })
    	else
     	SupportFrameExpanded = false
    	T.Tween({
            SupportFrame,
            "Size",
            0.5,
            UDim2.new(0,310,0,460)
        })
    	wait(0.5)
    	T.Tween({
            UpdateFrame,
            "Position",
            0.5,
            UDim2.new(0.5,320,0.5,0)
        })
    	T.Tween({
            SupportFrame,
            "Position",
            0.5,
            UDim2.new(0.5,-320,0.5,0)
        })
    	wait(0.5)
     	SupportFrame.ZIndex -= 25
        for _,v in pairs(SupportFrame:GetDescendants()) do
            if v:IsA("Frame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("ImageButton") or v:IsA("ImageLabel") then
            	v.ZIndex -= 25
            end
        end
 	end
end)
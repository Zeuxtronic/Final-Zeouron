local lp = game.Players.LocalPlayer

local GetGuiParent = gethui or function() return game.CoreGui end

for _,v in pairs(GetGuiParent():GetChildren()) do
    if v.Name == "Zeouron" then
        v:Destroy()
    end
end

local ZeouronGui = Instance.new("ScreenGui",GetGuiParent())
ZeouronGui.Name = "Zeouron"
ZeouronGui.ResetOnSpawn = false

local Contents = {}

Contents.GetGuiParent = GetGuiParent
Contents.NewGui = function(name)
    for _,v in pairs(ZeouronGui:GetChildren()) do
        if v.Name == name then
            v:Destroy()
        end
    end
    
    local G = Instance.new("ScreenGui",ZeouronGui)
    G.Name = name
    G.ResetOnSpawn = false
    return G
end
Contents.Tween = function(tble, times)
    local TweenInf0 = TweenInfo.new(tble[3]) 
    local PlayThis = game:GetService("TweenService"):Create(tble[1], TweenInf0, {[tble[2]] = tble[4]})
    PlayThis:Play()
end
Contents.ConstructFolder = function()
	if not isfolder("Zeouron/Assets") then
	    makefolder("Zeouron/Assets")
	end
	if not isfile("Zeouron/Settings/Onoff.txt") then
		writefile("Zeouron/Settings/Onoff.txt", "true")
	end
	if not isfile("Zeouron/Settings/MainColor.txt") then
		writefile("Zeouron/Settings/MainColor.txt", "130,35,175")
	end
	if not isfile("Zeouron/Settings/BgColor.txt") then
		writefile("Zeouron/Settings/BgColor.txt", "10,10,10")
	end
	if not isfile("Zeouron/Settings/Size.txt") then
		writefile("Zeouron/Settings/Size.txt", "1")
	end
	if not isfile("Zeouron/Settings/Font.txt") then
		writefile("Zeouron/Settings/Font.txt", "Sarpanch")
	end
	if not isfile("Zeouron/Settings/Developer.txt") then
		writefile("Zeouron/Settings/Developer.txt", "false")
	end
end
Contents.Github = "https://raw.githubusercontent.com/Zeuxtronic/Final-Zeouron/refs/heads/main/"
Contents.DownloadAsset = function(asset)
    local succ,res = pcall(function() return game:HttpGet(Contents.Github().."Assets/"..asset) end)
    if succ and res then
       	writefile("Zeouron/Assets/"..asset, res)
        wait(0.1)
        return "Zeouron/Assets/"..asset
    else
        warn("Failed to Download asset")
        return ""
    end
end
Contents.LoadAsset = function(asset)
	local fakeasset = getcustomasset or getsynasset
	if isfile("Zeouron/Assets/"..asset) then
		return fakeasset("Zeouron/Assets/"..asset)
	else
   		return fakeasset(Contents.DownloadAsset(asset))
   	end
end
Contents.AddBlur = function(frame)
    -- from vapev4 (ty)
    local blur = Instance.new('ImageLabel')
    blur.Name = 'Blur'
    blur.Size = UDim2.new(1, 89, 1, 52)
    blur.Position = UDim2.fromOffset(-48, -31)
    blur.BackgroundTransparency = 1
    blur.Image = T.LoadAsset("blur.png")
    blur.ScaleType = Enum.ScaleType.Slice
    blur.SliceCenter = Rect.new(52, 31, 261, 502)
    blur.Parent = frame
    return blur
end
Contents.AddRound = function(frame,roundyness)
    local round = Instance.new("UICorner")
    round.Parent = frame
    round.CornerRadius = roundyness and UDim.new(0,roundyness) or UDim.new(0,5)
    return Round
end

constructcolor = function(str)
    local split = string.split(str,",")
    return Color3.fromRGB(tonumber(split[1]),tonumber(split[2]), tonumber(split[3]))
end
halvecolor = function(color, num)
    return Color3.new(color.R /num, color.G /num, color.B /num)
end
Contents.GetTheme = function()
    return {
        Font = Enum.Font[readfile("Zeouron/Settings/Font.txt")],
        Color = constructcolor(readfile("Zeouron/Settings/MainColor.txt")),
        DarkC = halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),
        DarkerC = halvecolor(halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),1.5),
        DarkestC = halvecolor(halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),2.5),
        BlackC = Color3.fromRGB(30,30,30),
        BgC = constructcolor(readfile("Zeouron/Settings/BgColor.txt")),
        DiscordLink = "https://discord.com/invite/BjrHC26rUP"
    }
end

local G = Contents.NewGui("ZeoTool")

local notifs = {}
Contents.Notification = function(title, desc, time)
    print(#notifs)
    local notification = Instance.new("Frame",G)
    notification.BackgroundColor3 = Contents.GetTheme().BgC
    notification.Size = UDim2.new(0,300,0,125)
    notification.Position = UDim2.new(1,-320,1,-145 -(#notifs *135))
    notification.ZIndex = 100
    
    local titlelabel = Instance.new("TextLabel",notification)
    titlelabel.Text = title
    titlelabel.Size = UDim2.new(1,-10,0,25)
    titlelabel.Position = UDim2.new(0,5,0,5)
    titlelabel.Font = Contents.GetTheme().Font
    titlelabel.TextColor3 = Contents.GetTheme().Color
    titlelabel.TextScaled = true
    titlelabel.BackgroundTransparency = 1
    --titlelabel.TextXAlignment = "Left"
    titlelabel.ZIndex = 102
    
    local desclabel = Instance.new("TextLabel",notification)
    desclabel.Text = desc
    desclabel.Size = UDim2.new(1,-10,1,-35)
    desclabel.Position = UDim2.new(0,5,0,35)
    desclabel.Font = Contents.GetTheme().Font
    desclabel.TextColor3 = Contents.GetTheme().Color
    desclabel.TextSize = 17
    desclabel.BackgroundTransparency = 1
    desclabel.TextXAlignment = "Left"
    desclabel.TextYAlignment = "Top"
    desclabel.ZIndex = 102
    
    local timebar = Instance.new("Frame",notification)
    timebar.Size = UDim2.new(1,-20,0,10)
    timebar.Position = UDim2.new(0,10,1,-20)
    timebar.BackgroundColor3 = Contents.GetTheme().Color
    timebar.ZIndex = 102
    
    local timebarbg = Instance.new("Frame",notification)
    timebarbg.Size = UDim2.new(1,-20,0,10)
    timebarbg.Position = UDim2.new(0,10,1,-20)
    timebarbg.BackgroundColor3 = Contents.GetTheme().DarkC
    timebarbg.ZIndex = 101
    
    Contents.AddRound(timebar,2)
    Contents.AddRound(timebarbg,2)
    
    Contents.AddRound(notification)
    Contents.AddBlur(notification)
    
    Contents.Tween({
        timebar,
        "Size",
        time,
        UDim2.new(0,0,0,10)
    })
	task.spawn(function(time,notification)
    	task.wait(time +0.05)
     	Contents.Tween({
            notification,
            "Position",
            0.35,
            UDim2.new(1,10,1,notification.Position.Y.Offset)
        })
    	task.wait(0.35)
     	table.remove(notifs, table.find(notifs, notification))
     	notification:Destroy()
      	for _,v in pairs(notifs) do
           	Contents.Tween({
                v,
                "Position",
                0.35,
                UDim2.new(1,-320,1,v.Position.Y.Offset +135)
            })
        end
    end,time,notification)
	table.insert(notifs,notification)
end
Contents.GetFragment = function(fragment)
    return loadstring(game:HttpGet(Contents.Github.."Fragments/"..fragment..".lua"))()
end
Contents.GetConfig = function(config)
    return loadstring(game:HttpGet(Contents.Github.."Configs/"..config..".txt"))()
end
Contents.GetLibrary = function(lib)
	return loadstring(game:HttpGet(Contents.Github.."Libraries/"..lib..".lua"))()
end

Contents.Popups = {}

Contents.Popups.OK = function(Title, Description)
    if PopupFrame then
        Contents.Tween({
            PopupFrame,
            "Size",
            0.2,
            UDim2.new(0,360,0,0)
        })
        wait(0.2)
        PopupFrame:Destroy()
        PopupFrame = nil
    end
    
    PopupFrame = Instance.new("Frame", G)

    PopupFrame.Size = UDim2.new(0,360,0,0)
    PopupFrame.Position = UDim2.new(0.5,0,0.5,0)
    PopupFrame.BackgroundColor3 = Contents.GetTheme().BgC
    PopupFrame.ZIndex = 50
    PopupFrame.AnchorPoint = Vector2.new(0.5,0.5)
    
   	local PopupContainer = Instance.new("ScrollingFrame", PopupFrame)
    
    PopupContainer.Size = UDim2.new(1,0,1,0)
    PopupContainer.BackgroundTransparency = 1
    PopupContainer.ZIndex = 50
    PopupContainer.ScrollBarImageTransparency = 0
    PopupContainer.CanvasSize = UDim2.new(0,0,0,0)
  
    local QuestionTitle = Instance.new("TextLabel", PopupContainer)

    QuestionTitle.Size = UDim2.new(1,0,0,30)
    QuestionTitle.Position = UDim2.new(0,0,0,0)
    QuestionTitle.BackgroundTransparency = 1
    QuestionTitle.Text = Title
    QuestionTitle.Font = Contents.GetTheme().Font
    QuestionTitle.TextScaled = true
    QuestionTitle.TextWrapped = true
    QuestionTitle.TextColor3 = Contents.GetTheme().Color
    QuestionTitle.ZIndex = 50
      
    local QuestionLabel = Instance.new("TextLabel", PopupContainer)

    QuestionLabel.Size = UDim2.new(1,-15,1,0)
    QuestionLabel.Position = UDim2.new(0,15,0,30)
    QuestionLabel.BackgroundTransparency = 1
    QuestionLabel.Text = Description
    QuestionLabel.Font = Contents.GetTheme().Font
    QuestionLabel.TextSize = 20
    QuestionLabel.TextWrapped = true
    QuestionLabel.TextColor3 = Contents.GetTheme().Color
    QuestionLabel.TextXAlignment = "Left"
    QuestionLabel.TextYAlignment = "Top"
    QuestionLabel.ZIndex = 50
    
    local OKButton = Instance.new("TextButton", PopupContainer)

    OKButton.Size = UDim2.new(1,-10,0,25)
    OKButton.Position = UDim2.new(0,5,1,-30)
    OKButton.BackgroundColor3 = Contents.GetTheme().DarkerC
    OKButton.Text = "Okay"
    OKButton.Font = Contents.GetTheme().Font
    OKButton.TextScaled = true
    OKButton.TextColor3 = Contents.GetTheme().Color
    OKButton.ZIndex = 51
    
    OKButton.MouseButton1Click:Connect(function()
        Contents.Tween({
            PopupFrame,
            "Size",
            0.2,
            UDim2.new(0,360,0,0)
        })
        wait(0.2)
        PopupFrame:Destroy()
    end)

    Contents.Tween({
        PopupFrame,
        "Size",
        0.2,
        UDim2.new(0,360,0,180)
    })

	Contents.AddBlur(PopupFrame)
      
    Contents.AddRound(PopupFrame, 0.02)
    Contents.AddRound(OKButton, 0.02)
end

Contents.Popups.YN = function(Title, Description, yesfunc, nofunc)
    local nofunc = nofunc or function() end
    if PopupFrame then
        Contents.Tween({
            PopupFrame,
            "Size",
            0.2,
            UDim2.new(0,360,0,0)
        })
        wait(0.2)
        PopupFrame:Destroy()
        PopupFrame = nil
    end
    
    PopupFrame = Instance.new("Frame", G)

    PopupFrame.Size = UDim2.new(0,360,0,0)
    PopupFrame.Position = UDim2.new(0.5,0,0.5,0)
    PopupFrame.BackgroundColor3 = Contents.GetTheme().BgC
    PopupFrame.ZIndex = 50
    PopupFrame.AnchorPoint = Vector2.new(0.5,0.5)
    
    local PopupContainer = Instance.new("ScrollingFrame", PopupFrame)
    
    PopupContainer.Size = UDim2.new(1,0,1,0)
    PopupContainer.BackgroundTransparency = 1
    PopupContainer.ZIndex = 50
    PopupContainer.ScrollBarImageTransparency = 0
    PopupContainer.CanvasSize = UDim2.new(0,0,0,0)
  
    local QuestionTitle = Instance.new("TextLabel", PopupContainer)

    QuestionTitle.Size = UDim2.new(1,0,0,30)
    QuestionTitle.Position = UDim2.new(0,0,0,0)
    QuestionTitle.BackgroundTransparency = 1
    QuestionTitle.Text = Title
    QuestionTitle.Font = Contents.GetTheme().Font
    QuestionTitle.TextScaled = true
    QuestionTitle.TextWrapped = true
    QuestionTitle.TextColor3 = Contents.GetTheme().Color
    QuestionTitle.ZIndex = 50
      
    local QuestionLabel = Instance.new("TextLabel", PopupContainer)

    QuestionLabel.Size = UDim2.new(1,-15,1,0)
    QuestionLabel.Position = UDim2.new(0,15,0,30)
    QuestionLabel.BackgroundTransparency = 1
    QuestionLabel.Text = Description
    QuestionLabel.Font = Contents.GetTheme().Font
    QuestionLabel.TextSize = 20
    QuestionLabel.TextWrapped = true
    QuestionLabel.TextColor3 = Contents.GetTheme().Color
    QuestionLabel.TextXAlignment = "Left"
    QuestionLabel.TextYAlignment = "Top"
    QuestionLabel.ZIndex = 50
    
    local YESButton = Instance.new("TextButton", PopupContainer)

    YESButton.Size = UDim2.new(0.5,-3,0,25)
    YESButton.Position = UDim2.new(0,5,1,-30)
    YESButton.BackgroundColor3 = Contents.GetTheme().DarkerC
    YESButton.Text = "Yes"
    YESButton.Font = Contents.GetTheme().Font
    YESButton.TextScaled = true
    YESButton.TextColor3 = Contents.GetTheme().Color
    YESButton.ZIndex = 51
    
    local NOButton = Instance.new("TextButton", PopupContainer)

    NOButton.Size = UDim2.new(0.5,-12,0,25)
    NOButton.Position = UDim2.new(0.5,6,1,-30)
    NOButton.BackgroundColor3 = Contents.GetTheme().DarkerC
    NOButton.Text = "No"
    NOButton.Font = Contents.GetTheme().Font
    NOButton.TextScaled = true
    NOButton.TextColor3 = Contents.GetTheme().Color
    NOButton.ZIndex = 51
    
    YESButton.MouseButton1Click:Connect(function()
        task.spawn(yesfunc)
        Contents.Tween({
            PopupFrame,
            "Size",
            0.2,
            UDim2.new(0,360,0,0)
        })
        wait(0.2)
        PopupFrame:Destroy()
    end)

	NOButton.MouseButton1Click:Connect(function()
        task.spawn(nofunc)
        Contents.Tween({
            PopupFrame,
            "Size",
            0.2,
            UDim2.new(0,360,0,0)
        })
        wait(0.2)
        PopupFrame:Destroy()
    end)

    Contents.Tween({
        PopupFrame,
        "Size",
        0.2,
        UDim2.new(0,360,0,180)
    })

	Contents.AddBlur(PopupFrame)
      
    Contents.AddRound(PopupFrame, 0.02)
    Contents.AddRound(YESButton, 0.02)
    Contents.AddRound(NOButton, 0.02)
end
return Contents
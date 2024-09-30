repeat task.wait() until game:IsLoaded() and game.ContentProvider.RequestQueueSize == 0
local loadedin = os.time()
if getgenv().isloaded then
    return
end
getgenv().isloaded = true
for i,v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
    v:Disable()
end
for i,v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
    v:Disable()
end
local Orion = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AnAvaragelilmemer/Orion-mobile/main/source.lua')))()
local function notif(msg)
    Orion:MakeNotification({
	Name = "脚本已启动",
	Content = msg,
	Image = "rbxassetid://7733658271",
	Time = 6.5
}) 
end
if not game.Players.LocalPlayer.Character then
    repeat notif("等待"..game.Players.LocalPlayer.DisplayName.."'的性格...") task.wait(7) until game.Players.LocalPlayer.Character
end
local RunService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local defaultambient = lighting.Ambient
local defaultbrightness = lighting.Brightness
local defaultshadows = lighting.GlobalShadows
local defaulttime = lighting.ClockTime
local lplr = game:GetService("Players").LocalPlayer
local tpservice = game:GetService("TeleportService")
local userinputservice = game:GetService("UserInputService")
local version = "V2.9.7"
local fonts = {}
local camera = workspace.CurrentCamera
local queuetp = (syn and syn.queue_on_teleport) or queue_on_teleport 
local expectedversion = loadstring(game:HttpGet("https://raw.githubusercontent.com/AnAvaragelilmemer/Pissware/main/version.lua"))()
if expectedversion ~= version then
    notif("您当前版本的脚本已经过时！(预期版本"..expectedversion.." 得到 "..version..")")
    getgenv().isloaded = false
    return
end
if userinputservice.TouchEnabled and not userinputservice.KeyboardEnabled and not userinputservice.MouseEnabled then
    game.StarterGui:SetCore("ChatMakeSystemMessage",{Text = "[脚本]: 当前设备:移动设备，预计某些功能无法工作📱",Color = Color3.fromRGB(255,255,255),Font = Enum.Font.SourceSansSemibold,FontSize = Enum.FontSize.Size24})
elseif not userinputservice.TouchEnabled and userinputservice.KeyboardEnabled and userinputservice.MouseEnabled then
    game.StarterGui:SetCore("ChatMakeSystemMessage",{Text = "[脚本]:当前设备:电脑🖥️ ",Color = Color3.fromRGB(255,255,255),Font = Enum.Font.SourceSansSemibold,FontSize = Enum.FontSize.Size24})
end


pcall(function()
    game.ReplicatedStorage.Remote.ReqCharVars.OnClientInvoke = function()
	return {}
end
end)
local function chat(msg)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg,"All")
end
local function kick(msg)
    if msg then
        lplr:Kick(msg)
        else
            lplr:Kick()
    end
end

local function exit()
    game:Shutdown()
end

local Window = Orion:MakeWindow({
        Name = "脚本"..version, 
        IntroText = "欢迎来到脚本, "..lplr.DisplayName..".",
        IntroIcon = "rbxassetid://6031084743", 
        HidePremium = true, 
        SaveConfig = true, 
        ConfigFolder = "脚本"})
        
local home = Window:MakeTab({
        Name = "关于", 
        Icon = "rbxassetid://7733960981", 
        PremiumOnly = false
        })
        
local Main = Window:MakeTab({
        Name = "通用脚本", 
        Icon = "rbxassetid://6087485864", 
        PremiumOnly = false
        })
        
local ESP = Window:MakeTab({
        Name = "画面", 
        Icon = "rbxassetid://12308581351", 
        PremiumOnly = false
        })
        
local Player = Window:MakeTab({
        Name = "玩家", 
        Icon = "rbxassetid://12296135476", 
        PremiumOnly = false
        })
        
local Tab = Window:MakeTab({
        Name = "战斗", 
        Icon = "rbxassetid://6087485864", 
        PremiumOnly = false
        })
        
local render = Window:MakeTab({
        Name = "透视自动", 
        Icon = "rbxassetid://6031075931", 
        PremiumOnly = false
        })
        
local movement = Window:MakeTab({
        Name = "活动", 
        Icon = "rbxassetid://7743870731", 
        PremiumOnly = false})
        
local misc = Window:MakeTab({
        Name = "效用", 
        Icon = "rbxassetid://7743878358", 
        PremiumOnly = false
        })
        
local beta = Window:MakeTab({
        Name = "关于", 
        Icon = " ",
        PremiumOnly = false
        })
        
if isfile("loadedmorethanone.lua") then
home:AddLabel("欢迎回来， "..lplr.DisplayName.."！你喜欢这个脚本吗？")
else
    home:AddLabel("欢迎 "..lplr.DisplayName.."，希望你会喜欢这个脚本！")
end

local Section = home:AddSection({
	Name = "更新日志"
})

home:AddParagraph("您的roblox帐户信息"," 用户名 "..lplr.Name.."\n 显示名称: "..lplr.DisplayName.."\n 使用者辩证码: "..lplr.UserId)
home:AddButton({
	Name = "复制游戏名称",
	Callback = function()
      		setclipboard(lplr.Name)
  	end    
})
home:AddButton({
	Name = "复制显示名称",
	Callback = function()
      		setclipboard(lplr.DisplayName)
  	end    
})

home:AddParagraph("游戏信息"," 名称: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."\n ID: "..game.PlaceId.."\n ID游戏: "..game.JobId)

home:AddButton({
	Name = "复制名称",
	Callback = function()
      		setclipboard(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
  	end    
})

home:AddButton({
	Name = "复制服务器ID",
	Callback = function()
      		setclipboard(game.JobId)
  	end    
})

Main:AddButton({
	Name = "",
	Callback = function()
      		
  	end    
})

Main:AddButton({
	Name = "",
	Callback = function()
      		
  	end    
})

Main:AddButton({
	Name = "穿墙",
	Default = false,
	Callback = function(boolrfq)
      		getgenv().trfffffinketcs = boolrfq
        game:GetService("RunService").RenderStepped:Connect(function()
if getgenv().trfffffinketcs then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end
end)
  	end    
})



Tab:AddButton({
	Name = "摧毁机器人",
	Callback = function()
	    notif("新闻；摧毁机器人。")
_G.FOVring = Drawing.new("Circle")
       game:GetService"RunService".RenderStepped:Connect(function()
       _G.FOVring.Visible = true
       _G.FOVring.Thickness = 2
       _G.FOVring.Radius = _G.fovringslider
       _G.FOVring.Transparency = 1
       _G.FOVring.Color = _G.fovColorPicker
       _G.FOVring.Position = workspace.CurrentCamera.ViewportSize/2
   end)
       
      
       
       local function getClosest(cframe)
          local ray = Ray.new(cframe.Position, cframe.LookVector).Unit
          
          local target = nil
          local mag = math.huge
          
          for i,v in pairs(game.Players:GetPlayers()) do
              if v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v ~= game.Players.LocalPlayer and (v.Team ~= game.Players.LocalPlayer.Team or (not _G.tcToggle)) then
                  local magBuf = (v.Character.Head.Position - ray:ClosestPoint(v.Character.Head.Position)).Magnitude
                  
                  if magBuf < mag then
                      mag = magBuf
                      target = v
                  end
              end
          end
          
          return target
       end
       
       loop = RunService.RenderStepped:Connect(function()
          local UserInputService = game:GetService("UserInputService")
          local pressed = --[[UserInputService:IsKeyDown(Enum.KeyCode.E)]] UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
          local localPlay = game.Players.localPlayer.Character
          local cam = workspace.CurrentCamera
          local zz = workspace.CurrentCamera.ViewportSize/2
          
          if pressed then
              local Line = Drawing.new("Line")
              local curTar = getClosest(cam.CFrame)
              local ssHeadPoint = cam:WorldToScreenPoint(curTar.Character.Head.Position)
              ssHeadPoint = Vector2.new(ssHeadPoint.X, ssHeadPoint.Y)
              if (ssHeadPoint - zz).Magnitude < _G.fovringslider then
                  workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(cam.CFrame.Position, curTar.Character.Head.Position), _G.smoothingslider)
              end
          end
          
          if UserInputService:IsKeyDown(Enum.KeyCode.Semicolon) then
              loop:Disconnect()
              _G.FOVring:Remove()
          end
       end)
  	end    
})


Tab:AddToggle({Name = "团队检查", Default = false, Save = true, Flag = "aimbot_teamcheck", Callback = function(v)
    _G.tcToggle = v
            end
})

Tab:AddSlider({ Name = "缓和", Default = 0.25, Min = 0, Max = 1,  Increment = 0.1 ,ValueName = "smoothness", Save = true, Flag = "aimbot_smoothness", Callback = function(v)
    _G.smoothingslider = v
            end
})

Tab:AddSlider({ Name = "视界环尺寸", Default = 100, Min = 0, Max = 1000, ValueName = "size", Save = true, Flag = "aimbot_fovringsize", Callback = function(v)
    _G.fovringslider = v
            end 
})

Tab:AddColorpicker({ Name = "视野环颜色", Default = Color3.new(1,1,1), Save = true, Flag = "aimbot_fovringcolor", Callback = function(v)
    _G.fovColorPicker = v
            end
})

local hitbox 
getgenv().hitboxsize = 12
getgenv().hitboxcolor = Color3.new(255,255,255)
getgenv().trans = 0.5
--no team check cause its impossible
RunService.Heartbeat:Connect(function()
if hitbox then
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	local char = v.Character or v.CharacterAdded:Wait()
	local charhumanoid = char:WaitForChild("HumanoidRootPart")
	if v.Name ~= lplr.Name and charhumanoid then
	v.Character.HumanoidRootPart.Transparency = trans
	v.Character.HumanoidRootPart.Color = hitboxcolor
	v.Character.HumanoidRootPart.Size = Vector3.new(hitboxsize,hitboxsize,hitboxsize)
	v.Character.HumanoidRootPart.Material = "Plastic"
	v.Character.HumanoidRootPart.CanCollide = false
		end
end
else
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	if v.Name ~= lplr.Name then
	v.Character.HumanoidRootPart.Transparency = 1
	v.Character.HumanoidRootPart.Color = Color3.new(255,255,255)
	v.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
	v.Character.HumanoidRootPart.Material = "Plastic"
	v.Character.HumanoidRootPart.CanCollide = false
		end
end
end
end)
Tab:AddToggle({Name = "点击框切换", Default = false, Save = true, Flag = "combat_hitbox", Callback = function(v)
    hitbox = v
            end
})

Tab:AddSlider({ Name = "点击框大小", Default = 10, Min = 2, Max = 50, ValueName = "Size", Save = true, Flag = "combat_hitbox_size", Callback = function(v)
    hitboxsize = v
            end 
})

Tab:AddColorpicker({ Name = "点击框颜色", Default = Color3.new(1,1,1), Save = true, Flag = "combat_hitbox_color", Callback = function(v)
    hitboxcolor = v
            end
})

Tab:AddSlider({ Name = "点击框透明度", Default = 0.5, Min = 0, Max = 1, Increment = 0.1,ValueName = "Size", Save = true, Flag = "combat_hitbox_transparency", Callback = function(v)
    trans = v
            end 
})


local FPScounter = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
FPScounter.Name = "FPS counter"
FPScounter.Parent = game.CoreGui
FPScounter.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

TextLabel.Parent = FPScounter
TextLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.455756456, 0, 0.802699208, 0)
TextLabel.Size = UDim2.new(0, 140, 0, 21)
TextLabel.Visible = false
TextLabel.Font = Enum.Font.Unknown
TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
TextLabel.TextSize = 14.000
UICorner.Parent = TextLabel

local function CHCC_fake_script() -- TextLabel.LocalScript 
	local script = Instance.new('LocalScript', TextLabel)

	local RunService = game:GetService("RunService")
	RunService.RenderStepped:Connect(function(frame)
		script.Parent.Text = ("帧率: "..math.round(1/frame)) 
	end)
	
end
coroutine.wrap(CHCC_fake_script)()

local ambient 
getgenv().ambientcolor = Color3.fromRGB(0,255,0)
RunService.Stepped:Connect(function()
if ambient then
    lighting.Ambient = ambientcolor
    elseif ambient == false then
        lighting.Ambient = defaultambient 
end
end)
local time 
getgenv().timesilder = 14
RunService.RenderStepped:Connect(function()
if time then lighting.ClockTime = timesilder else lighting.ClockTime = defaulttime end
end)
local blur = Instance.new("BlurEffect")
blur.Parent = lighting
local motionblur = Instance.new("BlurEffect")
motionblur.Parent = lighting
motionblur.Name = "motionblur"
motionblur.Enabled = false
--在查看roblox devforum时发现了这个，所以我对自己说“为什么不给pissware添加一个运动模糊呢？
local lv = Vector3.zero
RunService.RenderStepped:Connect(function()
	local x,y,z = game.Workspace.CurrentCamera.CFrame:ToEulerAnglesXYZ()
	x,y,z = math.deg(x),math.deg(y),math.deg(z)
	motionblur.Size = math.clamp((Vector3.new(x,y,z)-lv).Magnitude/2,2,10)
	lv = Vector3.new(x,y,z)
end)
local fullbright 
RunService.RenderStepped:Connect(function()
    if fullbright then
        lighting.Brightness = 2
        lighting.GlobalShadows = false
        else
            lighting.Brightness = defaultbrightness
            lighting.GlobalShadows = defaultshadows
    end
    end)

render:AddToggle({ Name = "环境的", Default = false, Save = true, Flag = "render_ambientcheck", Callback = function(v)
    ambient = v
            end
})
render:AddColorpicker({ Name = "环境颜色", Default = Color3.new(1,1,1), Save = true, Flag = "render_ambientcheck_ambientcolor", Callback = function(v)
    ambientcolor = v
            end
})
render:AddToggle({ Name = "无渲染", Default = false, Save = true, Flag = "render_norender", Callback = function(v)
    if v then
        RunService:Set3dRenderingEnabled(false)
    else
            RunService:Set3dRenderingEnabled(true)
end
            end
})

render:AddToggle({ Name = "时间", Default = false, Save = true, Flag = "render_time", Callback = function(v)
    time = v
            end
})
render:AddSlider({ Name = "时间价值", Default = 1, Min = 0, Max = 24, ValueName = "time", Save = true, Flag = "render_time_value", Callback = function(v)
    timesilder = v
            end 
})

render:AddToggle({ Name = "虚化", Default = false, Save = true, Flag = "render_blur", Callback = function(v)
   blur.Enabled = v   
            end
})

render:AddSlider({ Name = "模糊效果", Default = 0, Min = 0, Max = 100, ValueName = "blur", Save = true, Flag = "render_blur_value", Callback = function(v)
    blur.Size = v
            end 
})

render:AddToggle({ Name = "FPS计数器", Default = false, Save = true, Flag = "render_fps", Callback = function(v)
    TextLabel.Visible = v
end
})

render:AddColorpicker({ Name = "FPS计数器颜色", Default = Color3.new(80,80,80), Save = true, Flag = "render_fps_color", Callback = function(v)
    TextLabel.TextColor3 = v
            end
})

render:AddToggle({ Name = "复制滞后", Default = false, Save = true, Flag = "render_replilag", Callback = function(v)
    if v then
    settings().Network.IncomingReplicationLag = 10000
        else
            settings().Network.IncomingReplicationLag = 0
    end
end
})

render:AddToggle({ Name = "低输出KBPS", Default = false, Save = true, Flag = "render_kbps", Callback = function(v)
    if v then
     game:GetService("NetworkClient"):SetOutgoingKBPSLimit(1)        
     else
        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
    end
end
})

render:AddToggle({ Name = "运动模糊", Default = false, Save = true, Flag = "render_motionblur", Callback = function(v)
    motionblur.Enabled = v
end
})

render:AddToggle({ Name = "富布赖特(可能不工作)", Default = false, Save = true, Flag = "render_FullBright", Callback = function(v)
    fullbright = v
end
})

local esp = render:AddSection({
	Name = "透视"
})
local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AnAvaragelilmemer/Pissware/main/Utility/ESP'),true))()
--settings
espLib.options.boxes = false
espLib.options.chams = false
espLib:Load()
for i,v in pairs(Drawing.Fonts) do
    fonts[v] = i
end
render:AddToggle({ Name = "使能够透视", Default = false, Save = true, Flag = "render_esp_enabled", Callback = function(v)
    espLib.options.enabled = v
            end
})

render:AddToggle({ Name = "🔥框", Default = false, Save = true, Flag = "render_esp_box", Callback = function(v)
    espLib.options.boxFill = v
end
})

render:AddColorpicker({ Name = "🔥框颜色", Default = Color3.new(1,1,1), Save = true, Flag =  "render_esp_box_color", Callback = function(v)
    espLib.options.boxFillColor = v
end
})

render:AddToggle({ Name = "🔥示踪", Default = false, Save = true, Flag = "render_esp_tracer", Callback = function(v)
    espLib.options.tracers = v
end
})

render:AddColorpicker({ Name = "示踪-颜色", Default = Color3.new(1,1,1), Save = true, Flag = "render_esp_tracer_color", Callback = function(v)
    espLib.options.tracerColor = v
            end
})

render:AddDropdown({Name = "🔥示踪起源", Default = "Top", Options = {"Bottom", "Top", "Mouse"}, Save = true, Flag = "render_esp_tracer_origin", Callback = function(v)
                espLib.options.tracerOrigin = v
            end 
})


render:AddToggle({ Name = "🔥健康", Default = false, Save = true, Flag = "render_esp_hpbar", Callback = function(v)
    espLib.options.healthBars = v
    end
})

render:AddColorpicker({ Name = "🔥健康颜色", Default = Color3.new(1,1,1), Save = true, Flag = "render_esp_hpbar_color", Callback = function(v)
    espLib.options.healthBarsColor = v
            end
})

render:AddToggle({ Name = "🔥健康文本", Default = false, Save = true, Flag = "render_esp_healthtext", Callback = function(v)
    espLib.options.healthText = v
end
})

render:AddColorpicker({ Name = "🔥健康文本颜色", Default = Color3.new(1,1,1), Save = true, Flag = "render_esp_healthtext_color", Callback = function(v)
    espLib.options.healthTextColor = v
            end
})

render:AddDropdown({Name = "🔥健康文本后缀", Default = "%", Options = {"%", " HP", " Health"}, Save = true, Flag = "render_esp_healthtext_suffix", Callback = function(v)
                espLib.options.healthTextSuffix = v
            end 
})

render:AddToggle({ Name = "🔥距离", Default = false, Save = true, Flag = "render_esp_distance", Callback = function(v)
    espLib.options.distance = v
end
})

render:AddDropdown({Name = "🔥距离后缀", Default = " Studs", Options = {" Studs", " Distance"}, Save = true, Flag = "render_esp_distance_suffix", Callback = function(v)
                espLib.options.distanceSuffix = v
            end 
})

render:AddToggle({ Name = "🔥视图外箭头", Default = false, Save = true, Flag = "render_esp_oof", Callback = function(v)
    espLib.options.outOfViewArrows = v
    espLib.options.outOfViewArrowsOutline = v
end
})

render:AddColorpicker({ Name = "🔥视图外箭头颜色", Default = Color3.new(1,1,1), Save = true, Flag = "render_esp_oof_color", Callback = function(v)
     espLib.options.outOfViewArrowsColor = v
            end
})

render:AddColorpicker({ Name = "🔥视图外箭头尺寸廓颜色", Default = Color3.new(1,1,1), Save = true, Flag = "render_esp_oof_outline_color", Callback = function(v)
     espLib.options.outOfViewArrowsOutlineColor = v
            end
})

render:AddSlider({ Name = "视图外箭头尺寸", Default = 25, Min = 1, Max = 50, ValueName = "size", Save = true, Flag = "render_esp_oof_size", Callback = function(v)
    espLib.options.outOfViewArrowsSize = v
            end 
})

render:AddSlider({ Name = "视图外箭头半径", Default = 100, Min = 1, Max = 360, ValueName = "Radius", Save = true, Flag = "render_esp_oof_Radius", Callback = function(v)
    espLib.options.outOfViewArrowsRadius = v
            end 
})

render:AddToggle({ Name = "姓名标签", Default = false, Save = true, Flag = "render_esp_tags", Callback = function(v)
    espLib.options.names = v
end
})

render:AddColorpicker({ Name = "姓名标签颜色", Default = Color3.new(1,1,1), Save = true, Flag = "render_esp_tags_color", Callback = function(v)
    espLib.options.nameColor = v
            end
})


local espsettings = render:AddSection({
	Name = "ESP 全局设置"
})

espsettings:AddToggle({ Name = "团队检查", Default = false, Save = true, Flag = "render_esp_teamcheck", Callback = function(v)
    espLib.options.teamCheck = v
end
})

espsettings:AddToggle({ Name = "可见支票", Default = false, Save = true, Flag = "render_esp_visiblecheck", Callback = function(v)
    espLib.options.visibleOnly = v
end
})

espsettings:AddToggle({ Name = "使用团队颜色", Default = false, Save = true, Flag = "render_esp_teamcolor", Callback = function(v)
    espLib.options.teamColor = v
end
})

espsettings:AddSlider({ Name = "字体大小", Default = 17, Min = 5, Max = 25, ValueName = "font size", Save = true, Flag = "render_esp_fontsize", Callback = function(v)
    espLib.options.fontSize = v
            end 
})

espsettings:AddToggle({ Name = "极限距离", Default = false, Save = true, Flag = "render_esp_ld", Callback = function(v)
    espLib.options.limitDistance = v
end
})

espsettings:AddSlider({ Name = "距离", Default = 1000, Min = 10, Max = 2000, ValueName = "studs", Save = true, Flag = "render_esp_ld_distance", Callback = function(v)
    espLib.options.maxDistance = v
            end 
})

espsettings:AddDropdown({Name = "字体", Default = fonts[1], Options = fonts, Save = true, Flag = "render_esp_font", Callback = function(v)
                espLib.options.font = Drawing.Fonts[v]
            end 
})

local noclip 
RunService.Stepped:Connect(function()
    if noclip then
        for i,v in pairs(lplr.Character:GetDescendants()) do
            if v and v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

local jetpack
local jetpackmethod = "Hold"
game:GetService("UserInputService").InputBegan:Connect(function(inp,process)
if jetpack and jetpackmethod == "Press" and inp.KeyCode.Name == "Space" and not process then
	lplr.Character.Humanoid:ChangeState("Jumping")
end
end)
game:GetService("UserInputService").JumpRequest:connect(function()
if jetpack and jetpackmethod == "Hold" then
	lplr.Character.Humanoid:ChangeState("Jumping")
end
end)

local spinbot 
local spinbotspeed = math.rad(50)
RunService.Stepped:Connect(function()
if spinbot then
    lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, spinbotspeed, 0)
end
end)

local bhoptoggle
RunService.Stepped:Connect(function()
    if lplr.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and bhoptoggle and lplr.Character.Humanoid.MoveDirection.Magnitude > 0 and lplr.Character.Humanoid.Health > 0.01 then
        lplr.Character.Humanoid:ChangeState("Jumping")
       end
end)
local strafetoggle
local strafeslowness = 3.2
RunService.Stepped:Connect(function()
    if lplr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and strafetoggle and lplr.Character.Humanoid.MoveDirection.Magnitude > 0 and lplr.Character.Humanoid.Health > 0.01 then
   lplr.Character:TranslateBy(lplr.Character.Humanoid.MoveDirection/strafeslowness)
  end
end)

--credits for sirius for their fly, i had a bad time coding a fly script
--no my ass DOES NOT steal sirius fly if your coming from lunarhub
getgenv().flyspeed = 50
getgenv().flykeys = "Space/LeftControl"
local fly
RunService.Stepped:Connect(function()
 local RootPart = lplr.Character.Humanoid.RootPart
 local vector3 = Vector3.zero
if fly and flykeys == "Space/LeftControl" then
            if userinputservice:IsKeyDown(Enum.KeyCode.W) then
                vector3 += camera.CFrame.LookVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.S) then
                vector3 += -camera.CFrame.LookVector
            end
			if userinputservice:IsKeyDown(Enum.KeyCode.A) then
                vector3 += -camera.CFrame.RightVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.D) then
                vector3 += camera.CFrame.RightVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.Space) then
                vector3 += RootPart.CFrame.UpVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.LeftControl) then
                vector3 += -RootPart.CFrame.UpVector
            end
            RootPart.Velocity = vector3 * flyspeed
end
if fly and flykeys == "E/Q" then
    if userinputservice:IsKeyDown(Enum.KeyCode.W) then
                vector3 += camera.CFrame.LookVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.S) then
                vector3 += -camera.CFrame.LookVector
            end
			if userinputservice:IsKeyDown(Enum.KeyCode.A) then
                vector3 += -camera.CFrame.RightVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.D) then
                vector3 += camera.CFrame.RightVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.E) then
                vector3 += RootPart.CFrame.UpVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.Q) then
                vector3 += -RootPart.CFrame.UpVector
            end
            RootPart.Velocity = vector3 * flyspeed
end
if fly and flykeys == "Space/LeftShift" then
    if userinputservice:IsKeyDown(Enum.KeyCode.W) then
                vector3 += camera.CFrame.LookVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.S) then
                vector3 += -camera.CFrame.LookVector
            end
			if userinputservice:IsKeyDown(Enum.KeyCode.A) then
                vector3 += -camera.CFrame.RightVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.D) then
                vector3 += camera.CFrame.RightVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.Space) then
                vector3 += RootPart.CFrame.UpVector
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.LeftShift) then
                vector3 += -RootPart.CFrame.UpVector
            end
            RootPart.Velocity = vector3 * flyspeed
end
end)

local speedmethod = "TranslateBy"
local Walkspeed
local walkspeedtog
RunService.Stepped:Connect(function()
    pcall(function()
        if lplr.Character.Humanoid.MoveDirection.Magnitude > 0 and walkspeedtog and speedmethod == "TranslateBy" then
            lplr.Character:TranslateBy(lplr.Character.Humanoid.MoveDirection * Walkspeed/50)
        end
    end)
end)
RunService.Stepped:Connect(function()
    if walkspeedtog and speedmethod == "CFrame" then
        lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + lplr.Character.Humanoid.MoveDirection * Walkspeed/20
    end
end)

local function tptoplr(Player)
lplr.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame
end


movement:AddToggle({ Name = "穿墙", Default = false, Save = true, Flag = "movement_noclip", Callback = function(v)
    noclip = v
end
})

movement:AddToggle({ Name = "旋转机器人", Default = false, Save = true, Flag = "movement_spinbot", Callback = function(v)
    spinbot = v
end
})

movement:AddSlider({ Name = "旋转机器人速度", Default = 100, Min = 0, Max = 500, Increment = 1,ValueName = "speed", Save = true, Flag = "movement_spinbot_speed", Callback = function(v)
    spinbotspeed = v
            end
})

movement:AddToggle({ Name = "喷气背包", Default = false, Save = true, Flag = "movement_jetpack", Callback = function(v)
    jetpack = v
end
})

movement:AddDropdown({Name = "喷气背包法", Default = "Hold", Options = {"Hold","Press"}, Save = true, Flag = "movement_jetpack_method", Callback = function(v)
    jetpackmethod = v
            end 
})

movement:AddToggle({ Name = "速度开关", Default = false, Save = true, Flag = "movement_speed_toggle", Callback = function(v)
    walkspeedtog = v
end
})

movement:AddDropdown({Name = "速度法", Default = "TranslateBy", Options = {"TranslateBy","CFrame"}, Save = true, Flag = "movement_speed_method", Callback = function(v)
    speedmethod = v
            end 
})

movement:AddSlider({ Name = "速度", Default = 100, Min = 0, Max = 150, Increment = 1,ValueName = "speed", Save = true, Flag = "movement_speed", Callback = function(v)
    Walkspeed = v
            end
})

movement:AddToggle({ Name = "总是跳跃", Default = false, Save = true, Flag = "movement_bhop", Callback = function(v)
    bhoptoggle = v
end
})

movement:AddToggle({ Name = "钢鞭跳跃", Default = false, Save = true, Flag = "movement_strafe", Callback = function(v)
    strafetoggle = v
end
})

movement:AddSlider({ Name = "钢鞭跳跃慢度", Default = 1, Min = 0.1, Max = 7, Increment = 0.1,ValueName = "slowness", Save = true, Flag = "movement_strafe_slowness", Callback = function(v)
    strafeslowness = v
            end
})

movement:AddToggle({ Name = "飞行", Default = false, Save = true, Flag = "movement_fly", Callback = function(v)
    fly = v
end
})

movement:AddSlider({ Name = "飞行速度", Default = 50, Min = 1, Max = 300, Increment = 1,ValueName = "speed", Save = true, Flag = "movement_fly_speed", Callback = function(v)
    flyspeed = v
            end
})

movement:AddDropdown({Name = "飞行键", Default = "Space/LeftControl", Options = {"E/Q","Space/LeftControl","Space/LeftShift"}, Save = true, Flag = "movement_speed_keys", Callback = function(v)
    flykeys = v
            end 
})

local players = {}
local refreshlist = movement:AddDropdown({
	Name = "传送到玩家",
	Options = {},
	Callback = function(v)
		local selecteduser = players[v]
		if selecteduser then
			tptoplr(selecteduser)
		end
	end    
})
spawn(function()
while task.wait(2) do
      	players = {}
		  local playeroptions = {}
         for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			 table.insert(playeroptions,v.DisplayName)
			 players[v.DisplayName] = v
		 end
		 refreshlist:Refresh(playeroptions,true)
end
end)
local antiafk
lplr.Idled:Connect(function()
    if antiafk then
                game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end
end)
local autorejoin
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.DescendantAdded:Connect(function()
      local errprompt = game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt")
      if errprompt and autorejoin then
          if errprompt.TitleFrame.ErrorTitle.Text:lower():match("disconnected") then
               if #game:GetService("Players"):GetPlayers() == 1 then
	        task.wait(1.5)
      		tpservice:Teleport(game.PlaceId)
      		else
            tpservice:TeleportToPlaceInstance(game.PlaceId,game.JobId)
               end
          end
      end
end)
            
local spam 
getgenv().message = "pɪssware在上面"
function spamm()
while spam do
	wait(2)
	chat(message) 
end
end

misc:AddToggle({ Name = "反挂机（AFK）", Default = true, Save = true, Flag = "misc_antiafk", Callback = function(v)
    antiafk = v
end
})

misc:AddToggle({ Name = "解锁FPS", Default = false, Save = true, Flag = "misc_fps", Callback = function(v)
    if v then
        setfpscap(1000)
        else
            setfpscap(60)
    end
end
})

misc:AddButton({
	Name = "回答",
	Callback = function()
	    if #game:GetService("Players"):GetPlayers() == 1 then
	        kick("脚本-重新连接...")
	        task.wait(1.5)
      		tpservice:Teleport(game.PlaceId)
      		else
            tpservice:TeleportToPlaceInstance(game.PlaceId,game.JobId)
	    end
  	end    
})

misc:AddToggle({ Name = "罐头猪肉", Default = false, Save = true, Flag = "misc_spam", Callback = function(v)
    spam = v
	spamm()
end
})

misc:AddTextbox({
	Name = "垃圾短信",
	Default = "pɪssware on top",
	TextDisappear = false,
	Callback = function(v)
		message = v
	end	  
})

misc:AddToggle({ Name = "自动重新连接", Default = false, Save = true, Flag = "misc_autorejoin", Callback = function(v)
    autorejoin = v
end
})

beta:AddParagraph(
    "你找到实验品了！",
    "哈哈"
)

misc:AddButton({
	Name = "生成连接代码",
	Callback = function()
	   setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance('..game.PlaceId..',"'..game.JobId..'")')
	   notif("已成功为您的会话生成加入代码。")
  	end    
})


Orion:Init()
writefile("loadedmorethanone.lua", "--这是用来检测你是否不止一次使用脚本。")
queuetp[[
loadstring(game:HttpGet("https://raw.githubusercontent.com/AnAvaragelilmemer/Pissware/main/Main/main.lua"))()
]]
game.StarterGui:SetCore("ChatMakeSystemMessage",{Text = "[脚本]: 马桶装好了 "..os.time()-loadedin.." 秒，享受！",Color = Color3.fromRGB(255,255,255),Font = Enum.Font.SourceSansSemibold,FontSize = Enum.FontSize.Size24})

Main:AddButton({
	Name = "启动脚本",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/2233qazwsx0/fufeifanxin/refs/heads/main/YX2.LUA"))()
  	end    
})

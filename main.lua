local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Splix"))()

local window = library:new({textsize = 13.5,font = Enum.Font.RobotoMono,name = "Kloxide.cc",color = Color3.fromRGB(115, 175, 59)})

local a = window:page({name = "Aimbot"})

local tab = window:page({name = "Visuals"})

getgenv().Visuals_Enabled = false
getgenv().Box_Enabled = false
getgenv().Health_Bar = false
getgenv().Head_Dot = false
getgenv().Name = false
getgenv().Box_Colour = Color3.fromRGB(0,0,0)

getgenv().Chams = false
getgenv().Fill_Colour = Color3.new()
getgenv().Fill_Transparency = 0.8
getgenv().Outline_Colour = Color3.new()
getgenv().Outline_Transparency = 0

local Visuals = tab:section({name = "Visuals",side = "left",size = 300})


Visuals:toggle({name = "Enabled",def = false,callback = function(value)
   getgenv().Visuals_Enabled = value
end})

Visuals:toggle({name = "2D Box",def = false,callback = function(value)
   getgenv().Box_Enabled = value
end})

local picker = Visuals:colorpicker({name = "Box Colour",cpname = nil,def = Color3.fromRGB(0,0,0),callback = function(value)
   getgenv().Box_Colour = value
end})

Visuals:toggle({name = "Health Bar",def = false,callback = function(value)
   getgenv().Health_Bar = value
end})

Visuals:toggle({name = "Name",def = false,callback = function(value)
   getgenv().Name = value
end})

Visuals:toggle({name = "Head Dot (Broken)",def = false,callback = function(value)
   getgenv().Head_Dot = value
end})

Visuals:toggle({name = "Chams",def = false,callback = function(value)
   getgenv().Chams = value
end})

local pasicker = Visuals:colorpicker({name = "Chams Colour",cpname = nil,def = Color3.fromRGB(0,0,0),callback = function(value)
   getgenv().Fill_Colour = value
end})

Visuals:slider({name = "Fill Transparency",def = 60, max = 100,min = 1,rounding = true,ticking = false,measuring = "",callback = function(value)
   getgenv().Fill_Transparency = value / 100
end})

local paasicker = Visuals:colorpicker({name = "Outline Colour",cpname = nil,def = Color3.fromRGB(0,0,0),callback = function(value)
   getgenv().Fill_Colour = value
end})

Visuals:slider({name = "Outline Transparency",def = 60, max = 100,min = 1,rounding = true,ticking = false,measuring = "",callback = function(value)
   getgenv().Outline_Transparency = value / 100
end})

local PlayerService = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = PlayerService.LocalPlayer
local Camera = workspace.CurrentCamera
local ViewPort = Camera.WorldToViewportPoint

local HeadOff = Vector3.new(0, 0.5, 0) -- Distance from HumPart to Head
local LegOff = Vector3.new(0,5,0) -- Distance from Humpart to Leg

local Highlight = Instance.new("Highlight")
local SecureFolder = Instance.new("Folder", game.CoreGui)


function CreateESP(Player)
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color = Color3.new(0,0,0)
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.new()
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local HealthBarOutline = Drawing.new("Square")
    HealthBarOutline.Thickness = 3
    HealthBarOutline.Filled = false
    HealthBarOutline.Color = Color3.new(0,0,0)
    HealthBarOutline.Transparency = 1
    HealthBarOutline.Visible = false

    local HealthBar = Drawing.new("Square")
    HealthBar.Thickness = 1
    HealthBar.Filled = false
    HealthBar.Transparency = 1
    HealthBar.Visible = false
    
    local Chams = Highlight:Clone()
    Chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Chams.Adornee = nil
    Chams.Parent = SecureFolder
    Chams.FillColor = getgenv().Fill_Colour
    Chams.FillTransparency = getgenv().Fill_Transparency
    Chams.OutlineColor = getgenv().Outline_Colour
    Chams.OutlineTransparency = getgenv().Outline_Transparency

    local text = Drawing.new("Text")
    text.Visible = false
    text.Center = true
    text.Outline = true 
    text.Font = 2
    text.Color = Color3.fromRGB(255,255,255)
    text.Size = 13


    

    
        RunService.RenderStepped:Connect(function()
            if Player.Character ~= nil and Player.Character:FindFirstChild("Humanoid") ~= nil and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player ~= LocalPlayer and Player.Character.Humanoid.Health > 0 and getgenv().Visuals_Enabled then
                local Character = Player.Character

                local Vector, onScreen = Camera:worldToViewportPoint(Character.HumanoidRootPart.Position)
                local Head_Pos, os = Camera:worldToViewportPoint(Character.Head.Position)

                local RootPart = Character.HumanoidRootPart
                local Head = Character.Head
                local RootPosition, RootVis = ViewPort(Camera, RootPart.Position)
                local HeadPosition = ViewPort(Camera, Head.Position + HeadOff)
                local LegPosition = ViewPort(Camera, RootPart.Position - LegOff)
                if getgenv().Box_Enabled then
                   Box.Visible = true
                   BoxOutline.Visible = true
                else
                   Box.Visible = false
                   BoxOutline.Visible = false
                end

                if getgenv().Name then
                   text.Visible = true
                else
                   text.Visible = false
                end

                if getgenv().Chams then
                   Chams.Adornee = Character
                else
                   Chams.Adornee = nil
                end

                if getgenv().Health_Bar then
                   HealthBar.Visible = true
                   HealthBarOutline.Visible = true
                else
                   HealthBar.Visible = false
                   HealthBarOutline.Visible = false
                end

                if onScreen then
                    BoxOutline.Size = Vector2.new(2560 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                    BoxOutline.Color = Color3.new(0,0,0)

                    Box.Size = Vector2.new(2560 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                    Box.Color = getgenv().Box_Colour

                    HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                    HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)

                    HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (Character.Humanoid.MaxHealth / math.clamp(Character.Humanoid.Health, 0, Character.Humanoid.MaxHealth)))
                    HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
                    HealthBar.Color = Color3.fromRGB(255 - 255 / (Character.Humanoid.MaxHealth / Character.Humanoid.Health), 255 / (Character.Humanoid.MaxHealth / Character.Humanoid.Health), 0)

                    text.Position = Vector2.new(Head_Pos.X, Head_Pos.Y + 53.2)
                    text.Text = Character.Name

                    Chams.FillColor = getgenv().Fill_Colour
                    Chams.FillTransparency = getgenv().Fill_Transparency
                    Chams.OutlineColor = getgenv().Outline_Colour
                    Chams.OutlineTransparency = getgenv().Outline_Transparency
                    --[[if Player.TeamColor == LocalPlayer.TeamColor then
                        BoxOutline.Visible = false
                        Box.Visible = false
                    else
                        BoxOutline.Visible = true
                        Box.Visible = true
                    end]]-- team check part

                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                    HealthBarOutline.Visible = false
                    HealthBar.Visible = false
                    text.Visible = false
                    Chams.Adornee = nil
                end
            else
                Box.Visible = false
                BoxOutline.Visible = false
                HealthBarOutline.Visible = false
                HealthBar.Visible = false
                Chams.Adornee = nil
                text.Visible = false
            end
        end)
    
end

-- Set ESP

for _,Player in pairs(PlayerService:GetPlayers()) do CreateESP(Player) end
PlayerService.PlayerAdded:Connect(CreateESP)

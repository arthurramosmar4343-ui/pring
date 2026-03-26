--// REMOVER ÁGUA
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Terrain") then
        v:Clear()
    end
end

--// CONFIG
local speed = 80
local flying = false

--// SERVICES
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

--// GUI
local screenGui = game.CoreGui:FindFirstChild("FlyGui") or Instance.new("ScreenGui")
screenGui.Name = "FlyGui"
screenGui.Parent = game.CoreGui

local frame = screenGui:FindFirstChild("MainFrame") or Instance.new("Frame")
frame.Name = "MainFrame"
frame.Parent = screenGui
frame.Size = UDim2.new(0,150,0,140)
frame.Position = UDim2.new(0.75,0,0.6,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

-- BOTÃO FLY
local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(1,0,0,40)
flyBtn.Text = "FLY OFF"
flyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
flyBtn.TextColor3 = Color3.new(1,1,1)

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = flying and "FLY ON" or "FLY OFF"
end)

-- SPEED +
local plus = Instance.new("TextButton", frame)
plus.Position = UDim2.new(0,0,0,45)
plus.Size = UDim2.new(0.5,0,0,40)
plus.Text = "+"
plus.MouseButton1Click:Connect(function()
    speed = speed + 10
end)

-- SPEED -
local minus = Instance.new("TextButton", frame)
minus.Position = UDim2.new(0.5,0,0,45)
minus.Size = UDim2.new(0.5,0,0,40)
minus.Text = "-"
minus.MouseButton1Click:Connect(function()
    speed = speed - 10
end)

-- TEXTO SPEED
local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Position = UDim2.new(0,0,0,90)
speedLabel.Size = UDim2.new(1,0,0,30)
speedLabel.Text = "Speed: "..speed
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.new(1,1,1)

RunService.RenderStepped:Connect(function()
    speedLabel.Text = "Speed: "..speed
end)

-- ARRASTAR (MOBILE)
local dragging, dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- PC tecla F
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        flying = not flying
        flyBtn.Text = flying and "FLY ON" or "FLY OFF"
    end
end)

-- FLY
local function setup(char)
    local humanoid = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    bv.Parent = root

    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
    bg.Parent = root

    RunService.RenderStepped:Connect(function()
        if not flying then
            bv.Velocity = Vector3.new()
            return
        end

        local moveDir = humanoid.MoveDirection
        local camCF = camera.CFrame
        local velocity = Vector3.new()

        if moveDir.Magnitude > 0 then
            velocity += (camCF.RightVector * moveDir.X + camCF.LookVector * moveDir.Z)
        end

        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            velocity += Vector3.new(0,1,0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
            velocity -= Vector3.new(0,1,0)
        end

        if velocity.Magnitude > 0 then
            bv.Velocity = velocity.Unit * speed
        else
            bv.Velocity = Vector3.new()
        end

        bg.CFrame = camCF
    end)
end

if player.Character then
    setup(player.Character)
end

player.CharacterAdded:Connect(setup)

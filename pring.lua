--// CONFIG
local speed = 80 -- velocidade do fly

--// PLAYER
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

--// REMOVER ÁGUA
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Terrain") then
        v:Clear()
    end
end

--// FLY
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(9e9,9e9,9e9)
bv.Velocity = Vector3.new(0,0,0)
bv.Parent = root

local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
bg.CFrame = root.CFrame
bg.Parent = root

-- CONTROLE TECLADO
local keys = {
    W = false,
    A = false,
    S = false,
    D = false,
    Space = false,
    Shift = false
}

UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then keys.W = true end
    if input.KeyCode == Enum.KeyCode.A then keys.A = true end
    if input.KeyCode == Enum.KeyCode.S then keys.S = true end
    if input.KeyCode == Enum.KeyCode.D then keys.D = true end
    if input.KeyCode == Enum.KeyCode.Space then keys.Space = true end
    if input.KeyCode == Enum.KeyCode.LeftShift then keys.Shift = true end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then keys.W = false end
    if input.KeyCode == Enum.KeyCode.A then keys.A = false end
    if input.KeyCode == Enum.KeyCode.S then keys.S = false end
    if input.KeyCode == Enum.KeyCode.D then keys.D = false end
    if input.KeyCode == Enum.KeyCode.Space then keys.Space = false end
    if input.KeyCode == Enum.KeyCode.LeftShift then keys.Shift = false end
end)

-- LOOP
RunService.RenderStepped:Connect(function()
    local moveDir = humanoid.MoveDirection
    local camCF = camera.CFrame

    local velocity = Vector3.new()

    -- MOBILE (joystick)
    if moveDir.Magnitude > 0 then
        velocity = velocity + (camCF.RightVector * moveDir.X + camCF.LookVector * moveDir.Z)
    end

    -- TECLADO
    if keys.W then velocity = velocity + camCF.LookVector end
    if keys.S then velocity = velocity - camCF.LookVector end
    if keys.A then velocity = velocity - camCF.RightVector end
    if keys.D then velocity = velocity + camCF.RightVector end

    -- SUBIR / DESCER
    if keys.Space then
        velocity = velocity + Vector3.new(0,1,0)
    end
    if keys.Shift then
        velocity = velocity - Vector3.new(0,1,0)
    end

    if velocity.Magnitude > 0 then
        bv.Velocity = velocity.Unit * speed
    else
        bv.Velocity = Vector3.new(0,0,0)
    end

    bg.CFrame = camCF
end)

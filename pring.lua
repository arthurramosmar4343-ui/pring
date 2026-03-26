pcall(function()

local player = game.Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PringX"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 160)
frame.Position = UDim2.new(0.5, -160, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

-- TITULO RGB
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -20, 0, 50)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "⚡ PRING X ELITE"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while true do
        for i = 0,1,0.01 do
            title.TextColor3 = Color3.fromHSV(i,1,1)
            task.wait(0.03)
        end
    end
end)

-- BOTÃO
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -20, 0, 70)
button.Position = UDim2.new(0, 10, 0.55, -10)
button.BackgroundColor3 = Color3.fromRGB(40,40,40)
button.Text = "[ OFF ] Plataforma Água"
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 16)

-- VAR
local ativo = false
local plataformas = {}

-- CRIAR PLATAFORMA
local function criarPlataformas()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local name = string.lower(v.Name)

            if v.Material == Enum.Material.Water
            or string.find(name, "water")
            or string.find(name, "agua") then

                local p = Instance.new("Part")
                p.Size = v.Size
                
                -- 🔥 ALTERADO AQUI (MAIS ALTO)
                p.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                
                p.Anchored = true
                p.Transparency = 1
                p.CanCollide = true
                p.Name = "PringPlatform"
                p.Parent = workspace

                table.insert(plataformas, p)
            end
        end
    end
end

-- LIMPAR
local function removerPlataformas()
    for _, p in pairs(plataformas) do
        if p then p:Destroy() end
    end
    plataformas = {}
end

-- ANTI PERDER
local function antiPerder()
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end

-- LOOP
local function iniciar()
    criarPlataformas()

    task.spawn(function()
        while ativo do
            task.wait(1)
            antiPerder()
        end
    end)
end

-- BOTÃO
button.MouseButton1Click:Connect(function()
    ativo = not ativo

    if ativo then
        button.Text = "[ ON ] Plataforma Água"
        button.BackgroundColor3 = Color3.fromRGB(0,200,120)
        iniciar()
    else
        button.Text = "[ OFF ] Plataforma Água"
        button.BackgroundColor3 = Color3.fromRGB(40,40,40)
        removerPlataformas()
    end
end)

end)

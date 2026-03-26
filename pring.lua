-- PRING PVP - GUI BONITA + ARRASTÁVEL + ANIMAÇÕES

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 280, 0, 110)
Frame.Position = UDim2.new(0.5, -140, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

-- Título
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "✖ Pring PvP"
Title.TextColor3 = Color3.fromRGB(180,120,255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Botão
local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0.85, 0, 0, 45)
Button.Position = UDim2.new(0.075, 0, 0.5, 0)
Button.Text = "[ ON ] Remover Água"
Button.TextColor3 = Color3.new(1,1,1)
Button.Font = Enum.Font.GothamBold
Button.TextScaled = true
Button.BackgroundColor3 = Color3.fromRGB(0,170,120)

Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 10)

-- GRADIENTE
local UIGradient = Instance.new("UIGradient", Button)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,200,150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,120,255))
}

-- ANIMAÇÃO DE ENTRADA
Frame.Position = UDim2.new(0.5, -140, -0.3, 0)
TweenService:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
    Position = UDim2.new(0.5, -140, 0.25, 0)
}):Play()

-- FUNÇÃO REMOVER ÁGUA
local ativo = true
local function removerAgua()
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain:Clear()
    end
end

-- ANIMAÇÃO BOTÃO
local function animarBotao(scale)
    local tween = TweenService:Create(Button, TweenInfo.new(0.1), {
        Size = UDim2.new(0.85 * scale, 0, 0, 45 * scale)
    })
    tween:Play()
end

Button.MouseButton1Down:Connect(function()
    animarBotao(0.95)
end)

Button.MouseButton1Up:Connect(function()
    animarBotao(1)
end)

-- CLICK
Button.MouseButton1Click:Connect(function()
    ativo = not ativo
    
    if ativo then
        Button.Text = "[ ON ] Remover Água"
        removerAgua()

        TweenService:Create(Button, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(0,170,120)
        }):Play()

    else
        Button.Text = "[ OFF ] Remover Água"

        TweenService:Create(Button, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(170,0,0)
        }):Play()
    end
end)

-- ARRASTAR (DRAG)
local dragging = false
local dragInput, mousePos, framePos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        Frame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

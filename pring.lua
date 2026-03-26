local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- CONFIG
local agua = workspace:WaitForChild("Agua")
local velocidade = 0.7

local ligado = false

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "WaterPanel"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.1, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(120, 70, 30) -- cor madeira
frame.BorderSizePixel = 0

-- borda arredondada
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- título
local titulo = Instance.new("TextLabel", frame)
titulo.Size = UDim2.new(1, 0, 0.3, 0)
titulo.Text = "Controle da Água"
titulo.BackgroundTransparency = 1
titulo.TextColor3 = Color3.new(1,1,1)
titulo.Font = Enum.Font.GothamBold
titulo.TextScaled = true

-- botão ON
local on = Instance.new("TextButton", frame)
on.Size = UDim2.new(0.45, 0, 0.4, 0)
on.Position = UDim2.new(0.05, 0, 0.5, 0)
on.Text = "ON"
on.BackgroundColor3 = Color3.fromRGB(0,170,0)
on.TextColor3 = Color3.new(1,1,1)

local onCorner = Instance.new("UICorner", on)
onCorner.CornerRadius = UDim.new(0, 8)

-- botão OFF
local off = Instance.new("TextButton", frame)
off.Size = UDim2.new(0.45, 0, 0.4, 0)
off.Position = UDim2.new(0.5, 0, 0.5, 0)
off.Text = "OFF"
off.BackgroundColor3 = Color3.fromRGB(170,0,0)
off.TextColor3 = Color3.new(1,1,1)

local offCorner = Instance.new("UICorner", off)
offCorner.CornerRadius = UDim.new(0, 8)

-- ARRASTAR
local dragging = false
local dragInput, mousePos, framePos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		mousePos = input.Position
		framePos = frame.Position

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

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		frame.Position = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
	end
end)

-- FUNÇÃO ÁGUA SUMINDO
task.spawn(function()
	while true do
		task.wait(0.1)
		
		if ligado and agua.Size.Y > 0 then
			agua.Size = agua.Size - Vector3.new(0, velocidade, 0)
			agua.Position = agua.Position - Vector3.new(0, velocidade/2, 0)
		end
	end
end)

-- BOTÕES
on.MouseButton1Click:Connect(function()
	ligado = true
end)

off.MouseButton1Click:Connect(function()
	ligado = false
end)

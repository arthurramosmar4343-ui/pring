local p = game.Players.LocalPlayer
local t = game:GetService("TweenService")

local g = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))

-- FRAME
local f = Instance.new("Frame", g)
f.Size = UDim2.new(0, 320, 0, 140)
f.Position = UDim2.new(0.5, -160, 0.2, 0)
f.BackgroundColor3 = Color3.fromRGB(20,20,20)
f.BorderSizePixel = 0
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 16)

-- TÍTULO
local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "✖ Pring Script"
title.TextColor3 = Color3.fromRGB(120,180,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÃO FECHAR
local close = Instance.new("TextButton", f)
close.Size = UDim2.new(0, 40, 0, 40)
close.Position = UDim2.new(1, -45, 0, 5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextScaled = true
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 10)

close.MouseButton1Click:Connect(function()
	f:Destroy()
end)

-- BOTÃO REMOVER ÁGUA
local water = Instance.new("TextButton", f)
water.Size = UDim2.new(0.9, 0, 0, 50)
water.Position = UDim2.new(0.05, 0, 0.45, 0)
water.BackgroundColor3 = Color3.fromRGB(40,40,40)
water.Text = "Remover Água"
water.TextColor3 = Color3.new(1,1,1)
water.Font = Enum.Font.GothamBold
water.TextScaled = true
Instance.new("UICorner", water).CornerRadius = UDim.new(0, 12)

-- FUNÇÃO REMOVER ÁGUA (VISUAL)
water.MouseButton1Click:Connect(function()
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Part") or v:IsA("MeshPart") then
			if v.Material == Enum.Material.Water then
				v.Transparency = 1
				v.CanCollide = false
			end
		end
	end

	local terrain = workspace:FindFirstChildOfClass("Terrain")
	if terrain then
		terrain.WaterTransparency = 1
	end
end)

-- ANIMAÇÃO
f.Position = UDim2.new(0.5, -160, -0.3, 0)
t:Create(f, TweenInfo.new(0.4), {
	Position = UDim2.new(0.5, -160, 0.2, 0)
}):Play()

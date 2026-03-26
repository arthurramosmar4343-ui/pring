local ativo = false

water.Text = "[ OFF ] Remover Água"
water.BackgroundColor3 = Color3.fromRGB(170,0,0)

local TweenService = game:GetService("TweenService")

local function animarCor(cor)
	TweenService:Create(water, TweenInfo.new(0.25), {
		BackgroundColor3 = cor
	}):Play()
end

water.MouseButton1Click:Connect(function()
	ativo = not ativo

	if ativo then
		water.Text = "[ ON ] Remover Água"
		animarCor(Color3.fromRGB(0,170,0))

		-- remover água
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

	else
		water.Text = "[ OFF ] Remover Água"
		animarCor(Color3.fromRGB(170,0,0))

		-- voltar água
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("Part") or v:IsA("MeshPart") then
				if v.Material == Enum.Material.Water then
					v.Transparency = 0
					v.CanCollide = true
				end
			end
		end

		local terrain = workspace:FindFirstChildOfClass("Terrain")
		if terrain then
			terrain.WaterTransparency = 0
		end
	end
end)

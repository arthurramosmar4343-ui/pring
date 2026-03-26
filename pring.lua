-- PRING PVP (DRAG CORRIGIDO)

local p=game.Players.LocalPlayer
local u=game:GetService("UserInputService")
local t=game:GetService("TweenService")

local g=Instance.new("ScreenGui",p:WaitForChild("PlayerGui"))

local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,280,0,110)
f.Position=UDim2.new(0.5,-140,0.25,0)
f.BackgroundColor3=Color3.fromRGB(25,25,25)
f.BorderSizePixel=0
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)

local ti=Instance.new("TextLabel",f)
ti.Size=UDim2.new(1,0,0,35)
ti.BackgroundTransparency=1
ti.Text="✖ Pring PvP"
ti.TextColor3=Color3.fromRGB(180,120,255)
ti.Font=Enum.Font.GothamBold
ti.TextScaled=true

local b=Instance.new("TextButton",f)
b.Size=UDim2.new(0.85,0,0,45)
b.Position=UDim2.new(0.075,0,0.5,0)
b.Text="[ ON ] Remover Água"
b.TextColor3=Color3.new(1,1,1)
b.Font=Enum.Font.GothamBold
b.TextScaled=true
b.BackgroundColor3=Color3.fromRGB(0,170,120)
Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)

local gr=Instance.new("UIGradient",b)
gr.Color=ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(0,200,150)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(0,120,255))
}

-- animação entrada
f.Position=UDim2.new(0.5,-140,-0.3,0)
t:Create(f,TweenInfo.new(0.6,Enum.EasingStyle.Quad),{
	Position=UDim2.new(0.5,-140,0.25,0)
}):Play()

-- função água
local a=true
local function r()
	local te=workspace:FindFirstChildOfClass("Terrain")
	if te then te:Clear() end
end

-- botão animação
local function an(s)
	t:Create(b,TweenInfo.new(0.1),{
		Size=UDim2.new(0.85*s,0,0,45*s)
	}):Play()
end

b.MouseButton1Down:Connect(function()an(0.95)end)
b.MouseButton1Up:Connect(function()an(1)end)

b.MouseButton1Click:Connect(function()
	a=not a
	if a then
		b.Text="[ ON ] Remover Água"
		r()
		t:Create(b,TweenInfo.new(0.3),{
			BackgroundColor3=Color3.fromRGB(0,170,120)
		}):Play()
	else
		b.Text="[ OFF ] Remover Água"
		t:Create(b,TweenInfo.new(0.3),{
			BackgroundColor3=Color3.fromRGB(170,0,0)
		}):Play()
	end
end)

-- DRAG CORRIGIDO 🔥
local dragging=false
local dragStart
local startPos

f.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
		dragging=true
		dragStart=input.Position
		startPos=f.Position

		input.Changed:Connect(function()
			if input.UserInputState==Enum.UserInputState.End then
				dragging=false
			end
		end)
	end
end)

u.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
		local delta=input.Position-dragStart

		f.Position=UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset+delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset+delta.Y
		)
	end
end)

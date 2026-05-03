-- Nguyenduydz OLD STYLE FLY FULL
-- Bay joystick + không mất khi chết + FPS + menu giống cũ

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ===== CHARACTER =====
local char
local humanoid
local root

local function setupCharacter(c)
	char = c
	humanoid = c:WaitForChild("Humanoid")
	root = c:WaitForChild("HumanoidRootPart")
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(function(c)
	setupCharacter(c)
end)

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "NguyenduydzFly"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- ===== FPS =====
local fps = Instance.new("TextLabel")
fps.Parent = gui
fps.Size = UDim2.new(0,100,0,30)
fps.Position = UDim2.new(0.8,0,0.02,0)

fps.BackgroundColor3 = Color3.fromRGB(20,20,20)
fps.TextColor3 = Color3.new(1,1,1)

fps.Text = "FPS: 0"

Instance.new("UICorner", fps)

local frames = 0
local last = tick()

-- ===== OPEN BUTTON =====
local open = Instance.new("TextButton")
open.Parent = gui

open.Size = UDim2.new(0,100,0,35)
open.Position = UDim2.new(0.02,0,0.3,0)

open.Text = "Nguyenduydz"

open.BackgroundColor3 = Color3.fromRGB(0,170,255)
open.TextColor3 = Color3.new(1,1,1)

open.Active = true
open.Draggable = true

Instance.new("UICorner", open)

-- ===== MENU =====
local frame = Instance.new("Frame")
frame.Parent = gui

frame.Size = UDim2.new(0,180,0,170)
frame.Position = UDim2.new(0.15,0,0.3,0)

frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

frame.Visible = false
frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame)

-- ===== TITLE =====
local title = Instance.new("TextLabel")
title.Parent = frame

title.Size = UDim2.new(1,0,0,25)

title.Text = "Nguyenduydz Fly"

title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

title.TextScaled = true

-- ===== FLY BUTTON =====
local flyBtn = Instance.new("TextButton")
flyBtn.Parent = frame

flyBtn.Size = UDim2.new(1,-10,0,35)
flyBtn.Position = UDim2.new(0,5,0,35)

flyBtn.Text = "Fly: OFF"

-- ===== SPEED + =====
local plus = Instance.new("TextButton")
plus.Parent = frame

plus.Size = UDim2.new(0.45,0,0,35)
plus.Position = UDim2.new(0.05,0,0,80)

plus.Text = "+"

-- ===== SPEED - =====
local minus = Instance.new("TextButton")
minus.Parent = frame

minus.Size = UDim2.new(0.45,0,0,35)
minus.Position = UDim2.new(0.5,0,0,80)

minus.Text = "-"

-- ===== SPEED LABEL =====
local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = frame

speedLabel.Size = UDim2.new(1,0,0,25)
speedLabel.Position = UDim2.new(0,0,0,125)

speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.new(1,1,1)

speedLabel.Text = "Speed: 1"

-- ===== OPEN MENU =====
open.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- ===== FLY SYSTEM =====
local flyOn = false
local speed = 1

local bv
local bg

flyBtn.MouseButton1Click:Connect(function()

	flyOn = not flyOn

	flyBtn.Text = flyOn and "Fly: ON" or "Fly: OFF"

	if flyOn and root then

		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = Vector3.zero
		bv.Parent = root

		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
		bg.P = 10000
		bg.CFrame = workspace.CurrentCamera.CFrame
		bg.Parent = root

		humanoid.PlatformStand = true

	else

		if bv then
			bv:Destroy()
		end

		if bg then
			bg:Destroy()
		end

		if humanoid then
			humanoid.PlatformStand = false
		end
	end
end)

-- ===== SPEED =====
plus.MouseButton1Click:Connect(function()

	speed = speed + 1

	speedLabel.Text = "Speed: "..speed

end)

minus.MouseButton1Click:Connect(function()

	speed = math.max(1,speed - 1)

	speedLabel.Text = "Speed: "..speed

end)

-- ===== LOOP =====
RunService.RenderStepped:Connect(function()

	-- FPS
	frames += 1

	if tick() - last >= 1 then

		fps.Text = "FPS: "..frames

		frames = 0
		last = tick()

	end

	-- FLY
	if flyOn and char and humanoid and root and bv and bg then

		local cam = workspace.CurrentCamera

		bg.CFrame = cam.CFrame

		local moveDir = humanoid.MoveDirection

		bv.Velocity =
			(moveDir * (speed * 50))
			+ Vector3.new(0,2,0)

	end

end)
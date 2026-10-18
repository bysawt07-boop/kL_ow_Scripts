-- ═══════════════════════════════════════════════════════════
-- [[ OMEGA BLOX ULTIMATE | RIGHTS: @kL_ow ]]
-- الميزات: لفل تلقائي (Auto Farm) + ضرب تلقائي + طيران
-- ═══════════════════════════════════════════════════════════

local OWNER = "@kL_ow"
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- إشعار الحقوق
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "👑 OMEGA BLOX ULTIMATE | " .. OWNER,
    Text = "تم التحميل | الحقوق لـ " .. OWNER,
    Duration = 5
})

-- واجهة السكربت
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "OmegaBloxUltimate"

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 250)
MainFrame.Position = UDim2.new(0, 50, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 255, 150)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "👑 OMEGA ULTIMATE | " .. OWNER
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local function getHRP() return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") end
local function getHum() return LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") end

-- 1. الحماية (ما تموت)
task.spawn(function()
    while true do
        task.wait(1)
        local h = getHum()
        if h then h.MaxHealth = math.huge; h.Health = math.huge end
    end
end)

-- 2. اللفل التلقائي والضرب التلقائي (Auto Farm + Kill Aura)
local AutoFarm = false
local function StartAutoFarm()
    AutoFarm = not AutoFarm
    if AutoFarm then
        task.spawn(function()
            while AutoFarm do
                task.wait(0.1)
                local hrp = getHRP()
                if hrp then
                    local closestEnemy = nil
                    local shortestDist = math.huge
                    
                    -- البحث عن أقرب عدو
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Humanoid") and v.Parent ~= LP.Character and v.Health > 0 then
                            local t = v.Parent:FindFirstChild("HumanoidRootPart")
                            if t then
                                local dist = (t.Position - hrp.Position).Magnitude
                                if dist < shortestDist and dist < 150 then -- مدى 150 متر
                                    shortestDist = dist
                                    closestEnemy = t
                                end
                            end
                        end
                    end

                    -- إذا لقينا عدو، نروح له ونضربه
                    if closestEnemy then
                        hrp.CFrame = CFrame.new(closestEnemy.Position + Vector3.new(0, 5, 0))
                        local tool = LP.Character:FindFirstChildWhichIsA("Tool")
                        if tool then tool:Activate() end
                    end
                end
            end
        end)
    end
end

-- 3. الطيران (Fly)
local Fly = false
local function ToggleFly()
    Fly = not Fly
    local hrp = getHRP()
    if not hrp then return end
    if Fly then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "FlyBV"; bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        local cam = workspace.CurrentCamera
        local UIS = game:GetService("UserInputService")
        task.spawn(function()
            while hrp:FindFirstChild("FlyBV") and Fly do
                task.wait()
                local mv = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.new(0,1,0) end
                bv.Velocity = mv * 150
            end
        end)
    else
        if hrp:FindFirstChild("FlyBV") then hrp.FlyBV:Destroy() end
    end
end

-- الأزرار
local function makeBtn(text, y, cb, color)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(1, -20, 0, 45)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = color or Color3.fromRGB(30, 40, 35)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.Parent = MainFrame
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function() pcall(cb) end)
end

makeBtn("⚔️ تشغيل/إيقاف اللفل التلقائي", 50, StartAutoFarm, Color3.fromRGB(150, 50, 50))
makeBtn("🦅 تشغيل/إيقاف الطيران", 100, ToggleFly, Color3.fromRGB(50, 100, 150))
makeBtn("⚡ تفعيل السرعة 150", 150, function()
    task.spawn(function()
        while true do
            task.wait(0.5)
            local h = getHum()
            if h then h.WalkSpeed = 150 end
        end
    end)
end, Color3.fromRGB(100, 100, 50))

-- ═══════════════════════════════════════════════════════════
-- [[ OMEGA PRO FARM v2 | RIGHTS: @kL_ow ]]
-- ذكي: يبحث عن أعداء يناسبون مستواك الحالي
-- ═══════════════════════════════════════════════════════════

local OWNER = "@kL_ow"
local TELEGRAM = "t.me/YourTelegramLink" -- ← غير هذا لرابط تلكرامك
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- إشعار الحقوق
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "👑 OMEGA PRO FARM v2 | " .. OWNER,
    Text = "تم التحميل | الحقوق لـ " .. OWNER,
    Duration = 5
})

-- 1. حقوقك في نص الشاشة (Watermark)
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(0, 400, 0, 30)
Watermark.Position = UDim2.new(0.5, -200, 0, 10)
Watermark.BackgroundTransparency = 1
Watermark.Text = "👑 " .. OWNER .. " | TG: " .. TELEGRAM
Watermark.TextColor3 = Color3.fromRGB(255, 215, 0)
Watermark.TextStrokeTransparency = 0.3
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 16
Watermark.Parent = game.CoreGui

-- واجهة السكربت
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "OmegaProFarmV2"

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Position = UDim2.new(0, 20, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 215, 0)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "⚡ SMART FARM v2 | " .. OWNER
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local function getHRP() return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") end
local function getHum() return LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") end

-- قراءة مستواك الحالي
local function GetMyLevel()
    local stats = LP:FindFirstChild("leaderstats")
    if stats then
        local level = stats:FindFirstChild("Level")
        if level then return level.Value end
    end
    return 1 -- إذا ما لقينا المستوى، نفترض 1
end

-- 2. الحماية (ما تموت)
task.spawn(function()
    while true do
        task.wait(1)
        local h = getHum()
        if h then h.MaxHealth = math.huge; h.Health = math.huge end
    end
end)

-- 3. اللفل التلقائي الذكي (يضرب الأعداء حسب مستواك)
local AutoFarm = false
local function StartSmartFarm()
    AutoFarm = not AutoFarm
    if AutoFarm then
        task.spawn(function()
            while AutoFarm do
                task.wait(0.2)
                local hrp = getHRP()
                local myLevel = GetMyLevel()
                
                if hrp then
                    local bestEnemy = nil
                    local bestScore = -math.huge
                    
                    -- البحث عن أفضل عدو يناسب مستواك
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Humanoid") and v.Parent ~= LP.Character and v.Health > 0 then
                            local t = v.Parent:FindFirstChild("HumanoidRootPart")
                            if t then
                                -- محاولة قراءة مستوى العدو
                                local enemyLevel = 1
                                local levelObj = v.Parent:FindFirstChild("Level") or (v.Parent:FindFirstChild("leaderstats") and v.Parent.leaderstats:FindFirstChild("Level"))
                                if levelObj then
                                    enemyLevel = levelObj.Value
                                end
                                
                                -- الذكاء: نبحث عن عدو مستواه قريب من مستوانا (يعطي خبرة كاملة)
                                -- إذا كان مستواه أعلى من مستوانا بكثير، نتجاهله
                                -- إذا كان قريب أو أعلى بشوي، نروح له
                                if enemyLevel >= (myLevel - 50) and enemyLevel <= (myLevel + 100) then
                                    local dist = (t.Position - hrp.Position).Magnitude
                                    -- نعطي أولوية للأعداء الأقرب
                                    local score = 10000 - dist 
                                    
                                    if score > bestScore then
                                        bestScore = score
                                        bestEnemy = t
                                    end
                                end
                            end
                        end
                    end

                    -- إذا لقينا عدو يناسب مستوانا، نطير له ونضربه
                    if bestEnemy then
                        hrp.CFrame = CFrame.new(bestEnemy.Position + Vector3.new(0, 5, 0))
                        local tool = LP.Character:FindFirstChildWhichIsA("Tool")
                        if tool then tool:Activate() end
                    else
                        -- إذا ما فيه أعداء يناسبون مستوانا، نطير مسافة عشوائية عشان نغير المنطقة
                        hrp.CFrame = hrp.CFrame + Vector3.new(math.random(-500, 500), 50, math.random(-500, 500))
                    end
                end
            end
        end)
    end
end

-- الأزرار
local function makeBtn(text, y, cb, color)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = color or Color3.fromRGB(40, 30, 20)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.Parent = MainFrame
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function() pcall(cb) end)
end

makeBtn("⚔️ تشغيل/إيقاف اللفل التلقائي", 50, StartSmartFarm, Color3.fromRGB(150, 50, 50))

-- 1. حقوقك في نص الشاشة (تشتغل دائماً)
local OWNER = "@kL_ow"
local TELEGRAM = "@kL_ow"

local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(0, 500, 0, 30)
Watermark.Position = UDim2.new(0.5, -250, 0, 5) 
Watermark.BackgroundTransparency = 1
Watermark.Text = "👑 " .. OWNER .. " | TG: " .. TELEGRAM
Watermark.TextColor3 = Color3.fromRGB(255, 215, 0) 
Watermark.TextStrokeTransparency = 0.5
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 16
Watermark.Parent = game.CoreGui

-- 2. تحميل سكربت Zyrex القوي (لفل تلقائي وضرب)
loadstring(game:HttpGet("https://raw.githubusercontent.com/ZyrexHub/Zyrex-Hub/main/BloxFruits.lua"))()

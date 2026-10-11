local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local OutfitRemotes = ReplicatedStorage:WaitForChild("OutfitRemotes")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Config = require(Modules:WaitForChild("Config"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FashionScreenGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

local function makeRoundedFrame(parent, name, size, position, bg, corner)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = bg
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, corner or 18)
    uiCorner.Parent = frame

    return frame
end

local function makeText(parent, name, text, size, position, color, font)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Text = text
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = color
    label.Font = font or Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = parent

    return label
end

local function createMainMenu()
    local menu = makeRoundedFrame(ScreenGui, "MainMenu", UDim2.new(0.24, 0, 0.12, 0), UDim2.new(0.02, 0, 0.06, 0), Color3.fromRGB(42, 45, 58), 18)
    menu.Visible = true

    local tabs = {
        { Name = "Início", Key = "Home" },
        { Name = "Outfits", Key = "Outfits" },
        { Name = "Provador", Key = "TryOn" },
        { Name = "Korblox & Headless", Key = "Korblox" },
        { Name = "Favoritos", Key = "Favorites" },
        { Name = "Destaques", Key = "Highlights" },
    }

    local buttonWidth = 0.15
    local x = 0.02
    for _, tab in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Name = tab.Key
        btn.Size = UDim2.new(buttonWidth, 0, 0.7, 0)
        btn.Position = UDim2.new(x, 0, 0.15, 0)
        btn.Text = tab.Name
        btn.BackgroundColor3 = Color3.fromRGB(140, 124, 255)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.Parent = menu

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 14)
        corner.Parent = btn

        x += buttonWidth + 0.01
    end

    return menu
end

local function createShowroomPanel()
    local panel = makeRoundedFrame(ScreenGui, "ShowroomPanel", UDim2.new(0.38, 0, 0.7, 0), UDim2.new(0.08, 0, 0.18, 0), Color3.fromRGB(29, 32, 42), 22)
    panel.Visible = true

    local header = makeText(panel, "Header", "Outfits da coleção", UDim2.new(0.7, 0, 0.08, 0), UDim2.new(0.04, 0, 0.03, 0), Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold)
    header.TextSize = 26

    local list = Instance.new("ScrollingFrame")
    list.Name = "OutfitList"
    list.Size = UDim2.new(0.92, 0, 0.78, 0)
    list.Position = UDim2.new(0.04, 0, 0.12, 0)
    list.BackgroundTransparency = 1
    list.BorderSizePixel = 0
    list.CanvasSize = UDim2.new(0, 0, 0, 0)
    list.AutomaticCanvasSize = Enum.AutomaticSize.Y
    list.ScrollBarThickness = 6
    list.Parent = panel

    return panel, list
end

local function populateOutfits(list)
    local outfits = {
        { Name = "Y2K Pastel", Category = "Y2K" },
        { Name = "Dark Gothic", Category = "Dark" },
        { Name = "Coquette Bloom", Category = "Coquette" },
        { Name = "Streetwear Luxe", Category = "Streetwear" },
        { Name = "Emo Alt", Category = "Emo" },
    }

    local y = 0
    for _, outfit in ipairs(outfits) do
        local item = makeRoundedFrame(list, outfit.Name .. "Card", UDim2.new(1, -18, 0, 110), UDim2.new(0, 10, 0, y), Color3.fromRGB(47, 51, 63), 18)
        item.BorderSizePixel = 0

        local title = makeText(item, outfit.Name .. "Title", outfit.Name, UDim2.new(0.6, 0, 0.25, 0), UDim2.new(0.04, 0, 0.12, 0), Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold)
        title.TextSize = 18

        local category = makeText(item, outfit.Name .. "Category", outfit.Category, UDim2.new(0.4, 0, 0.18, 0), UDim2.new(0.04, 0, 0.38, 0), Color3.fromRGB(174, 159, 255), Enum.Font.Gotham)
        category.TextSize = 13

        local previewBtn = Instance.new("TextButton")
        previewBtn.Name = outfit.Name .. "Preview"
        previewBtn.Text = "Preview"
        previewBtn.Size = UDim2.new(0.2, 0, 0.24, 0)
        previewBtn.Position = UDim2.new(0.72, 0, 0.18, 0)
        previewBtn.BackgroundColor3 = Color3.fromRGB(160, 127, 255)
        previewBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        previewBtn.Font = Enum.Font.GothamBold
        previewBtn.TextSize = 14
        previewBtn.Parent = item

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 14)
        corner.Parent = previewBtn

        local buyBtn = Instance.new("TextButton")
        buyBtn.Name = outfit.Name .. "Buy"
        buyBtn.Text = "Comprar"
        buyBtn.Size = UDim2.new(0.2, 0, 0.24, 0)
        buyBtn.Position = UDim2.new(0.72, 0, 0.52, 0)
        buyBtn.BackgroundColor3 = Color3.fromRGB(61, 66, 84)
        buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        buyBtn.Font = Enum.Font.GothamBold
        buyBtn.TextSize = 14
        buyBtn.Parent = item

        local corner2 = Instance.new("UICorner")
        corner2.CornerRadius = UDim.new(0, 14)
        corner2.Parent = buyBtn

        y += 120
    end
end

local function createTryOnModal()
    local modal = makeRoundedFrame(ScreenGui, "TryOnModal", UDim2.new(0.42, 0, 0.66, 0), UDim2.new(0.29, 0, 0.18, 0), Color3.fromRGB(20, 22, 30), 20)
    modal.Visible = false

    local title = makeText(modal, "ModalTitle", "Provador de roupas", UDim2.new(0.6, 0, 0.09, 0), UDim2.new(0.05, 0, 0.03, 0), Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold)
    title.TextSize = 24

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(0.9, 0, 0.75, 0)
    content.Position = UDim2.new(0.05, 0, 0.15, 0)
    content.BackgroundTransparency = 1
    content.Parent = modal

    local preview = Instance.new("ViewportFrame")
    preview.Name = "Preview"
    preview.Size = UDim2.new(0.52, 0, 1, 0)
    preview.Position = UDim2.new(0, 0, 0, 0)
    preview.BackgroundColor3 = Color3.fromRGB(46, 51, 61)
    preview.BorderSizePixel = 0
    preview.Parent = content

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 18)
    uiCorner.Parent = preview

    local itemsPanel = Instance.new("ScrollingFrame")
    itemsPanel.Name = "ItemsPanel"
    itemsPanel.Size = UDim2.new(0.42, 0, 1, 0)
    itemsPanel.Position = UDim2.new(0.55, 0, 0, 0)
    itemsPanel.BackgroundTransparency = 1
    itemsPanel.BorderSizePixel = 0
    itemsPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    itemsPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    itemsPanel.ScrollBarThickness = 5
    itemsPanel.Parent = content

    local tryButton = Instance.new("TextButton")
    tryButton.Name = "TryButton"
    tryButton.Size = UDim2.new(0.27, 0, 0.11, 0)
    tryButton.Position = UDim2.new(0.05, 0, 0.88, 0)
    tryButton.Text = "Experimentar"
    tryButton.BackgroundColor3 = Config.AccentPurple
    tryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tryButton.Font = Enum.Font.GothamBold
    tryButton.TextSize = 15
    tryButton.Parent = modal

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = tryButton

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Text = "Fechar"
    closeButton.Size = UDim2.new(0.18, 0, 0.11, 0)
    closeButton.Position = UDim2.new(0.77, 0, 0.88, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(84, 87, 98)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 15
    closeButton.Parent = modal

    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 12)
    corner2.Parent = closeButton

    local buyButton = Instance.new("TextButton")
    buyButton.Name = "BuyButton"
    buyButton.Text = "Comprar"
    buyButton.Size = UDim2.new(0.27, 0, 0.11, 0)
    buyButton.Position = UDim2.new(0.35, 0, 0.88, 0)
    buyButton.BackgroundColor3 = Color3.fromRGB(123, 112, 255)
    buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    buyButton.Font = Enum.Font.GothamBold
    buyButton.TextSize = 15
    buyButton.Parent = modal

    local uiCorner3 = Instance.new("UICorner")
    uiCorner3.CornerRadius = UDim.new(0, 12)
    uiCorner3.Parent = buyButton

    return modal
end

local function createKorbloxPanel()
    local panel = makeRoundedFrame(ScreenGui, "KorbloxPanel", UDim2.new(0.32, 0, 0.18, 0), UDim2.new(0.62, 0, 0.12, 0), Color3.fromRGB(255, 255, 255), 18)
    panel.Visible = true

    local title = makeText(panel, "Title", "Korblox & Headless Try-On", UDim2.new(0.9, 0, 0.28, 0), UDim2.new(0.06, 0, 0.12, 0), Color3.fromRGB(35, 35, 35), Enum.Font.GothamBold)
    title.TextSize = 19

    local compareBtn = Instance.new("TextButton")
    compareBtn.Name = "CompareButton"
    compareBtn.Text = "Comparar"
    compareBtn.Size = UDim2.new(0.26, 0, 0.28, 0)
    compareBtn.Position = UDim2.new(0.36, 0, 0.58, 0)
    compareBtn.BackgroundColor3 = Color3.fromRGB(140, 124, 255)
    compareBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    compareBtn.Font = Enum.Font.GothamBold
    compareBtn.TextSize = 14
    compareBtn.Parent = panel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = compareBtn

    return panel
end

createMainMenu()
local _, outfitList = createShowroomPanel()
populateOutfits(outfitList)
createTryOnModal()
createKorbloxPanel()

local function onCharacterAdded(character)
    local root = character:WaitForChild("HumanoidRootPart")
    local torso = character:WaitForChild("UpperTorso")
    local leftArm = character:WaitForChild("Left Arm")
    local rightArm = character:WaitForChild("Right Arm")

    if root and torso then
        root.CFrame = CFrame.new(0, 4, 70)
    end
end

player.CharacterAdded:Connect(onCharacterAdded)

return ScreenGui

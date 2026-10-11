local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local OutfitRemotes = ReplicatedStorage:WaitForChild("OutfitRemotes")
local Config = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Config"))

local function getHumanoidRoot()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("HumanoidRootPart")
end

local function resetAppearance()
    local currentCharacter = player.Character or player.CharacterAdded:Wait()
    local humanoid = currentCharacter:WaitForChild("Humanoid")
    humanoid:BuildRigFromAttachments()
end

local function previewItem(item)
    if not item then
        return
    end

    local currentCharacter = player.Character or player.CharacterAdded:Wait()
    local face = currentCharacter:FindFirstChild("Face")
    if face then
        face.Transparency = 0.2
    end
end

local function setTryOnMode(enabled)
    local root = getHumanoidRoot()
    if enabled then
        root.CFrame = root.CFrame + Vector3.new(0, 0, -2)
    end
end

local function removePreview()
    resetAppearance()
end

OutfitRemotes:WaitForChild(Config.Remotes.ToggleTryOn).OnClientEvent:Connect(function(data)
    if data and data.Status == "Active" then
        setTryOnMode(true)
        previewItem(data.Outfit)
    end
end)

OutfitRemotes:WaitForChild(Config.Remotes.RemoveTryOn).OnClientEvent:Connect(function()
    removePreview()
end)

OutfitRemotes:WaitForChild(Config.Remotes.KorbloxTryOn).OnClientEvent:Connect(function(data)
    if data and data.Status == "Preview" then
        local root = getHumanoidRoot()
        root.CFrame = root.CFrame + Vector3.new(0, 0, -3)
    end
end)

OutfitRemotes:WaitForChild(Config.Remotes.HeadlessTryOn).OnClientEvent:Connect(function(data)
    if data and data.Status == "Preview" then
        local root = getHumanoidRoot()
        root.CFrame = root.CFrame + Vector3.new(0, 0, -3)
    end
end)

return {
    ResetAppearance = resetAppearance,
    PreviewItem = previewItem,
    RemovePreview = removePreview,
}

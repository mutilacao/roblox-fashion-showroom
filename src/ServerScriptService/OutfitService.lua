local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Config = require(Modules:WaitForChild("Config"))
local OutfitCatalog = require(Modules:WaitForChild("OutfitCatalog"))

local OutfitService = {}

local RemoteFolder = ReplicatedStorage:FindFirstChild("OutfitRemotes")
if not RemoteFolder then
    RemoteFolder = Instance.new("Folder")
    RemoteFolder.Name = "OutfitRemotes"
    RemoteFolder.Parent = ReplicatedStorage
end

local remotes = {}
for name, eventName in pairs(Config.Remotes) do
    local remote = RemoteFolder:FindFirstChild(eventName)
    if not remote then
        remote = Instance.new("RemoteEvent")
        remote.Name = eventName
        remote.Parent = RemoteFolder
    end
    remotes[name] = remote
end

local function getPlayerFavorites(player)
    local data = player:SetAttribute("FashionFavorites", player:GetAttribute("FashionFavorites") or {})
    return player:GetAttribute("FashionFavorites") or {}
end

local function savePlayerFavorites(player, favorites)
    player:SetAttribute("FashionFavorites", favorites)
end

local function cloneOutfitPreview(player, outfitId)
    local outfit = OutfitCatalog:GetById(outfitId)
    if not outfit then
        return nil
    end

    local preview = {
        Id = outfit.Id,
        Name = outfit.Name,
        Category = outfit.Category,
        Style = outfit.Style,
        Items = outfit.Items,
    }

    return preview
end

remotes.RequestCatalog.OnServerEvent:Connect(function(player)
    remotes.RequestCatalog:FireClient(player, OutfitCatalog:GetAll())
end)

remotes.RequestOutfitPreview.OnServerEvent:Connect(function(player, outfitId)
    local preview = cloneOutfitPreview(player, outfitId)
    remotes.RequestOutfitPreview:FireClient(player, preview)
end)

remotes.RequestFavorite.OnServerEvent:Connect(function(player, outfitId)
    local favorites = getPlayerFavorites(player)
    if table.find(favorites, outfitId) then
        table.remove(favorites, table.find(favorites, outfitId))
    else
        table.insert(favorites, outfitId)
    end

    savePlayerFavorites(player, favorites)
    remotes.RequestFavorite:FireClient(player, favorites)
end)

remotes.GetFavorites.OnServerEvent:Connect(function(player)
    remotes.GetFavorites:FireClient(player, getPlayerFavorites(player))
end)

remotes.ToggleTryOn.OnServerEvent:Connect(function(player, outfitId)
    local preview = cloneOutfitPreview(player, outfitId)
    if preview then
        remotes.ToggleTryOn:FireClient(player, { Status = "Active", Outfit = preview })
    end
end)

remotes.RemoveTryOn.OnServerEvent:Connect(function(player)
    remotes.RemoveTryOn:FireClient(player, { Status = "Removed" })
end)

remotes.KorbloxTryOn.OnServerEvent:Connect(function(player)
    remotes.KorbloxTryOn:FireClient(player, {
        Type = "Korblox",
        Status = "Preview",
        Item = Config.Korblox,
    })
end)

remotes.HeadlessTryOn.OnServerEvent:Connect(function(player)
    remotes.HeadlessTryOn:FireClient(player, {
        Type = "Headless",
        Status = "Preview",
        Item = Config.Headless,
    })
end)

remotes.ComparePreview.OnServerEvent:Connect(function(player)
    remotes.ComparePreview:FireClient(player, {
        Original = true,
        Korblox = true,
        KorbloxHeadless = true,
    })
end)

return OutfitService

local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Config = require(Modules:WaitForChild("Config"))
local OutfitCatalog = require(Modules:WaitForChild("OutfitCatalog"))

local ShopService = {}

local RemoteFolder = ReplicatedStorage:FindFirstChild("OutfitRemotes") or ReplicatedStorage:WaitForChild("OutfitRemotes")

local function getRemote(name)
    return RemoteFolder:WaitForChild(name)
end

local function validateProductId(productId)
    return type(productId) == "number" and productId > 0
end

local function validateAssetId(assetId)
    return type(assetId) == "number" and assetId > 0
end

local function purchaseItem(player, productId, assetId)
    if not validateProductId(productId) then
        return false, "Produto inválido."
    end

    if not validateAssetId(assetId) then
        return false, "Item inválido."
    end

    local success = pcall(function()
        MarketplaceService:PromptProductPurchase(player, productId)
    end)

    if success then
        return true, "Compra iniciada."
    end

    return false, "Falha ao iniciar a compra."
end

getRemote(Config.Remotes.RequestPurchaseItem).OnServerEvent:Connect(function(player, item)
    local itemData = item or {}
    local productId = itemData.ProductId
    local assetId = itemData.AssetId

    local ok, message = purchaseItem(player, productId, assetId)
    getRemote(Config.Remotes.RequestPurchaseItem):FireClient(player, { Success = ok, Message = message })
end)

getRemote(Config.Remotes.RequestPurchaseOutfit).OnServerEvent:Connect(function(player, outfitId)
    local outfit = OutfitCatalog:GetById(outfitId)
    if not outfit then
        getRemote(Config.Remotes.RequestPurchaseOutfit):FireClient(player, { Success = false, Message = "Outfit inexistente." })
        return
    end

    local productIds = {}
    for _, item in ipairs(outfit.Items) do
        if item.ProductId then
            table.insert(productIds, item.ProductId)
        end
    end

    if #productIds == 0 then
        getRemote(Config.Remotes.RequestPurchaseOutfit):FireClient(player, { Success = false, Message = "Nenhum item disponível para compra." })
        return
    end

    local ok, message = purchaseItem(player, productIds[1], outfit.Items[1].AssetId)
    getRemote(Config.Remotes.RequestPurchaseOutfit):FireClient(player, { Success = ok, Message = message, OutfitId = outfitId })
end)

return ShopService

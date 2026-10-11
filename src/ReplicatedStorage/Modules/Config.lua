local Config = {}

Config.Remotes = {
    RequestCatalog = "RequestCatalog",
    RequestOutfitPreview = "RequestOutfitPreview",
    RequestPurchaseItem = "RequestPurchaseItem",
    RequestPurchaseOutfit = "RequestPurchaseOutfit",
    RequestFavorite = "RequestFavorite",
    GetFavorites = "GetFavorites",
    ToggleTryOn = "ToggleTryOn",
    RemoveTryOn = "RemoveTryOn",
    KorbloxTryOn = "KorbloxTryOn",
    HeadlessTryOn = "HeadlessTryOn",
    ComparePreview = "ComparePreview",
}

Config.FloorColor = Color3.fromRGB(238, 238, 240)
Config.PedestalColor = Color3.fromRGB(245, 245, 247)
Config.GardenColor = Color3.fromRGB(145, 201, 148)
Config.AccentPurple = Color3.fromRGB(160, 127, 255)
Config.AccentDark = Color3.fromRGB(40, 44, 58)

Config.Showroom = {
    Name = "Fashion Showroom",
    PedestalCount = 12,
    PathWidth = 80,
    PlantRows = 6,
}

Config.Korblox = {
    DisplayName = "Korblox",
    AssetId = 104874857,
    ProductId = 697232972,
    PreviewAccessoryName = "Korblox Head",
}

Config.Headless = {
    DisplayName = "Headless",
    AssetId = 104874858,
    ProductId = 697232973,
    PreviewAccessoryName = "Headless",
}

Config.AllowedCategories = {
    "Y2K",
    "Emo",
    "Dark",
    "Coquette",
    "Streetwear",
    "Feminino",
    "Masculino",
}

return Config

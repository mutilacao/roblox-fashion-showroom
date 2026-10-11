local OutfitCatalog = {}

local function item(name, assetId, productId, price, category, kind)
    return {
        Name = name,
        AssetId = assetId,
        ProductId = productId,
        Price = price,
        Category = category,
        Kind = kind,
    }
end

OutfitCatalog.Data = {
    {
        Id = "y2k_pastel_01",
        Name = "Y2K Pastel",
        Category = "Y2K",
        Style = "Feminino",
        Price = 0,
        Items = {
            item("Pastel Hoodie", 123456, 1001, 80, "Y2K", "Shirt"),
            item("Pleated Skirt", 123457, 1002, 60, "Y2K", "Pants"),
            item("FX Backpack", 123458, 1003, 40, "Y2K", "Accessory"),
        },
    },
    {
        Id = "dark_gothic_01",
        Name = "Dark Gothic",
        Category = "Dark",
        Style = "Masculino",
        Price = 0,
        Items = {
            item("Black Bomber", 123459, 1004, 110, "Dark", "Shirt"),
            item("Leather Cargo", 123460, 1005, 95, "Dark", "Pants"),
            item("Chain Necklace", 123461, 1006, 35, "Dark", "Accessory"),
        },
    },
    {
        Id = "coquette_01",
        Name = "Coquette Bloom",
        Category = "Coquette",
        Style = "Feminino",
        Price = 0,
        Items = {
            item("Ribbon Dress", 123462, 1007, 130, "Coquette", "Shirt"),
            item("Pearl Hair Clip", 123463, 1008, 30, "Coquette", "Accessory"),
            item("Gloss Heels", 123464, 1009, 75, "Coquette", "Pants"),
        },
    },
    {
        Id = "streetwear_01",
        Name = "Streetwear Luxe",
        Category = "Streetwear",
        Style = "Masculino",
        Price = 0,
        Items = {
            item("Oversized Tee", 123465, 1010, 90, "Streetwear", "Shirt"),
            item("Relaxed Cargo", 123466, 1011, 120, "Streetwear", "Pants"),
            item("Street Cap", 123467, 1012, 45, "Streetwear", "Accessory"),
        },
    },
    {
        Id = "emo_alt_01",
        Name = "Emo Alt",
        Category = "Emo",
        Style = "Feminino",
        Price = 0,
        Items = {
            item("Riot Shirt", 123468, 1013, 100, "Emo", "Shirt"),
            item("Studded Skirt", 123469, 1014, 85, "Emo", "Pants"),
            item("Black Boots", 123470, 1015, 70, "Emo", "Accessory"),
        },
    },
}

function OutfitCatalog:GetAll()
    return self.Data
end

function OutfitCatalog:GetById(id)
    for _, outfit in ipairs(self.Data) do
        if outfit.Id == id then
            return outfit
        end
    end
    return nil
end

function OutfitCatalog:GetCategories()
    local categories = {}
    for _, outfit in ipairs(self.Data) do
        if not table.find(categories, outfit.Category) then
            table.insert(categories, outfit.Category)
        end
    end
    return categories
end

return OutfitCatalog

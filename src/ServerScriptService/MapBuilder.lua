local MapBuilder = {}

local function createPart(parent, name, size, cframe, color)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = size
    part.CFrame = cframe
    part.Anchored = true
    part.Material = Enum.Material.SmoothPlastic
    part.Color = color
    part.TopSurface = Enum.SurfaceType.Smooth
    part.BottomSurface = Enum.SurfaceType.Smooth
    part.Parent = parent
    return part
end

local function decorateFlowers(parent, basePosition)
    for i = 1, 8 do
        local flower = Instance.new("Part")
        flower.Name = "Flower"
        flower.Shape = Enum.PartType.Cylinder
        flower.Size = Vector3.new(0.4, 0.8, 0.4)
        flower.CFrame = CFrame.new(basePosition + Vector3.new(math.random(-10, 10) * 0.7, 1.5, math.random(-10, 10) * 0.7))
        flower.Anchored = true
        flower.Material = Enum.Material.SmoothPlastic
        flower.Color = Color3.fromRGB(255, 200, 220)
        flower.Parent = parent

        local stem = Instance.new("Part")
        stem.Name = "Stem"
        stem.Size = Vector3.new(0.2, 2.2, 0.2)
        stem.CFrame = CFrame.new(flower.Position + Vector3.new(0, -1.1, 0))
        stem.Anchored = true
        stem.Material = Enum.Material.Grass
        stem.Color = Color3.fromRGB(120, 190, 110)
        stem.Parent = parent
    end
end

function MapBuilder.BuildShowroom()
    local workspace = game:GetService("Workspace")

    local showroom = workspace:FindFirstChild("FashionShowroom")
    if showroom then
        showroom:Destroy()
    end

    showroom = Instance.new("Model")
    showroom.Name = "FashionShowroom"
    showroom.Parent = workspace

    local base = createPart(showroom, "Floor", Vector3.new(320, 1, 160), CFrame.new(0, 0, 0), Color3.fromRGB(240, 240, 245))
    base.Position = Vector3.new(0, 0, 0)

    local centerPath = createPart(showroom, "CenterPath", Vector3.new(180, 0.5, 22), CFrame.new(0, 0.3, 0), Color3.fromRGB(244, 244, 246))
    centerPath.Position = Vector3.new(0, 0.3, 0)

    for index = 1, 12 do
        local x = -150 + (index * 24)
        local pedestal = createPart(showroom, "Pedestal_" .. index, Vector3.new(12, 4, 12), CFrame.new(x, 2, 0), Color3.fromRGB(245, 245, 247))
        pedestal.Position = Vector3.new(x, 2, 0)

        local top = createPart(showroom, "PedestalTop_" .. index, Vector3.new(8, 0.8, 8), CFrame.new(x, 4.5, 0), Color3.fromRGB(250, 250, 252))
        top.Position = Vector3.new(x, 4.5, 0)

        local mannequin = Instance.new("Model")
        mannequin.Name = "AvatarDisplay_" .. index
        mannequin.Parent = showroom

        local torso = createPart(mannequin, "Torso", Vector3.new(2, 2.8, 1), CFrame.new(x, 6.2, 0), Color3.fromRGB(255, 255, 255))
        torso.Position = Vector3.new(x, 6.2, 0)

        local head = createPart(mannequin, "Head", Vector3.new(1.8, 1.8, 1.8), CFrame.new(x, 8.2, 0), Color3.fromRGB(255, 239, 215))
        head.Position = Vector3.new(x, 8.2, 0)

        local leftArm = createPart(mannequin, "LeftArm", Vector3.new(0.5, 3, 0.5), CFrame.new(x - 1.6, 6.4, 0), Color3.fromRGB(255, 239, 215))
        leftArm.Position = Vector3.new(x - 1.6, 6.4, 0)

        local rightArm = createPart(mannequin, "RightArm", Vector3.new(0.5, 3, 0.5), CFrame.new(x + 1.6, 6.4, 0), Color3.fromRGB(255, 239, 215))
        rightArm.Position = Vector3.new(x + 1.6, 6.4, 0)

        local leftLeg = createPart(mannequin, "LeftLeg", Vector3.new(0.8, 2.8, 0.8), CFrame.new(x - 0.5, 3.8, 0), Color3.fromRGB(30, 30, 30))
        leftLeg.Position = Vector3.new(x - 0.5, 3.8, 0)

        local rightLeg = createPart(mannequin, "RightLeg", Vector3.new(0.8, 2.8, 0.8), CFrame.new(x + 0.5, 3.8, 0), Color3.fromRGB(30, 30, 30))
        rightLeg.Position = Vector3.new(x + 0.5, 3.8, 0)
    end

    local leftGarden = createPart(showroom, "GardenLeft", Vector3.new(300, 6, 60), CFrame.new(-150, 3, 50), Color3.fromRGB(133, 202, 130))
    leftGarden.Position = Vector3.new(-150, 3, 50)

    local rightGarden = createPart(showroom, "GardenRight", Vector3.new(300, 6, 60), CFrame.new(150, 3, 50), Color3.fromRGB(133, 202, 130))
    rightGarden.Position = Vector3.new(150, 3, 50)

    local backWallLeft = createPart(showroom, "WallLeft", Vector3.new(320, 30, 1), CFrame.new(0, 15, -50), Color3.fromRGB(238, 238, 240))
    backWallLeft.Position = Vector3.new(0, 15, -50)

    local backWallRight = createPart(showroom, "WallRight", Vector3.new(320, 30, 1), CFrame.new(0, 15, 50), Color3.fromRGB(238, 238, 240))
    backWallRight.Position = Vector3.new(0, 15, 50)

    for i = 1, 24 do
        local z = -35 + (i * 3)
        local gardenPatch = createPart(showroom, "GardenPatch_" .. i, Vector3.new(16, 2, 12), CFrame.new(-100 + (i % 5) * 40, 1.2, z), Color3.fromRGB(123, 190, 120))
        gardenPatch.Position = Vector3.new(-100 + (i % 5) * 40, 1.2, z)
        decorateFlowers(showroom, gardenPatch.Position + Vector3.new(0, 1.6, 0))
    end

    return showroom
end

return MapBuilder

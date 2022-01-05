--!strict

--// Name: GradientDisplay.lua
--// Author: angeld23
--[[ Description:

]]

local GradientDisplay = {}
GradientDisplay.__index = GradientDisplay

local DIR = require(game.ReplicatedFirst.DIR)

local Fusion = require(DIR.packages.Fusion)
    local New = Fusion.New
local GradientSlice = require(DIR.shared.class.GradientSlice)

local math = require(DIR.shared.lib.Math2)

export type GradientDisplay = {
    Frame: Frame;
    Size: Vector2;
    Slices: {GradientSlice};
}

type SliceData = {
    Start: Vector2;
    Length: number;
}

function GradientDisplay.new (size: Vector2): GradientDisplay
    size = Vector2.new(math.floor(size.X), math.floor(size.Y))
    assert(size.X >= 1 and size.Y >= 1, "Size must be at least 1")

    local self: GradientDisplay = setmetatable({}, GradientDisplay)

    self.Frame = New "Frame" {
        Size = UDim2.fromOffset(size.X, size.Y),
    }
    self.Size = size
    self.Slices = {}

    local sliceData: {SliceData} = {}

    for y = 1, size.Y do
        for x = 1, size.X, 20 do
            sliceData[#sliceData + 1] = {
                Start = Vector2.new(x, y),
                Length = math.min(20, size.X - x + 1),
            }
        end
    end

    for i, data in pairs(sliceData) do
        local slice = GradientSlice.new(data.Length)
        slice.Frame.Position = UDim2.fromOffset(data.Start.X, data.Start.Y)
        slice.Frame.Parent = self.Frame

        self.Slices[i] = slice
    end

    return self
end



function GradientDisplay:SetColor (color: Color3, position: Vector2)
    position = Vector2.new(math.floor(position.X), math.floor(position.Y))
    assert(
        position.X >= 1 and position.Y >= 1 and
        position.X <= self.Size.X and position.Y <= self.Size.Y, 
        "Position must be within display"
    )

    local sliceIndex = math.floor(position.X / 20) + (position.Y - 1) * math.floor(self.Size.X / 20)
    self.Slices[sliceIndex]:SetColor(color, position.X - (sliceIndex - 1) * 20)
end

return GradientDisplay
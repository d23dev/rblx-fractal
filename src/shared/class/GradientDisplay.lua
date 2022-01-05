local SIZE_MULTIPLIER = 2

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
local Promise = require(DIR.packages.promise)

local math = require(DIR.shared.lib.Math2)

export type GradientDisplay = {
    Frame: Frame;
    Size: Vector2;
    PixelMatrix: {{PixelData}};
}

type PixelData = {
    Slice: GradientSlice;
    RelativeIndex: number;
}

function GradientDisplay.new (size: Vector2): GradientDisplay
    size = Vector2.new(math.floor(size.X), math.floor(size.Y))
    assert(size.X >= 1 and size.Y >= 1, "Size must be at least 1")

    local self: GradientDisplay = setmetatable({}, GradientDisplay)

    self.Frame = New "Frame" {
        Size = math.multUDim2(UDim2.fromOffset(size.X, size.Y), SIZE_MULTIPLIER),
    }
    self.Size = size
    self.PixelMatrix = {}

    local sliceData: {SliceData} = {}

    for y = 1, size.Y do
        self.PixelMatrix[y] = {}
        for x = 1, size.X, 20 do
            local length = math.min(20, size.X - x + 1)
            local slice = GradientSlice.new(length)
            slice.Frame.Position = math.multUDim2(UDim2.fromOffset(x - 1, y - 1), SIZE_MULTIPLIER)
            slice.Frame.Size = math.multUDim2(slice.Frame.Size, SIZE_MULTIPLIER)
            slice.Frame.Parent = self.Frame

            sliceData[#sliceData + 1] = slice
            for i = x, x + length - 1 do
                self.PixelMatrix[y][i] = {
                    Slice = slice;
                    RelativeIndex = i - x + 1;
                }
            end
        end
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

    local pixel = self.PixelMatrix[position.Y][position.X]
    pixel.Slice:SetColor(color, pixel.RelativeIndex)
end

return GradientDisplay
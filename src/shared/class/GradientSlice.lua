--!strict

--// Name: GradientSlice.lua
--// Author: angeld23
--[[ Description:

]]

local GradientSlice = {}
GradientSlice.__index = GradientSlice

local DIR = require(game.ReplicatedFirst.DIR)

local Fusion = require(DIR.packages.Fusion)
    local New = Fusion.New

local math = require(DIR.shared.lib.Math2)

export type GradientSlice = {
    Frame: Frame;
    UIGradient: UIGradient;
    Length: number;
    ColorArray: {Color3};
}

function GradientSlice.new (length: number): GradientSlice
    length = math.floor(length)
    assert(length >= 1 and length <= 20, "Length must be between 1 and 20")

    local self: GradientSlice = setmetatable({}, GradientSlice)

    self.Length = length
    self.Frame = New "Frame" {
        Size = UDim2.fromOffset(length, 1),
    }
    self.UIGradient = New "UIGradient" {
        Parent = self.Frame,
    }

    self.ColorArray = {}
    for i = 1, length do
        self.ColorArray[i] = Color3.new(1, 1, 1)
    end
    self:_update()

    return self
end



-- updates the gradient with the current color array
function GradientSlice:_update ()
    local colors: {Color3} = {}
    for i, color in pairs(self.ColorArray) do
        local t = ((i - 1) / (#self.ColorArray - 1))
        colors[i] = ColorSequenceKeypoint.new(t, color)
    end
    self.UIGradient.Color = ColorSequence.new(colors)
end


function GradientSlice:SetColor (color: Color3, index: number) -- sets the color value at a given position in the gradient
    index = math.floor(index)
    assert(index >= 1 and index <= self.Length, "Index must be between 1 and slice length (" .. self.Length .. ")")
    self.ColorArray[index] = color
    self:_update()
end

-- sets the color array of the gradient to the one given
function GradientSlice:SetColors (colors: {Color3})
    assert(#colors == self.Length, "Length of color array must match length of gradient")
    self.ColorArray = colors
    self:_update()
end

return GradientSlice
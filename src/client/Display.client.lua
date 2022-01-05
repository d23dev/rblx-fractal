local SIZE_X = 275;
local SIZE_Y = 275;

local DIR = require(game.ReplicatedFirst.DIR)

local Players = game:GetService("Players")

local Fusion = require(DIR.packages.Fusion)
    local New = Fusion.New
local GradientDisplay = require(DIR.shared.class.GradientDisplay)
local Mandelbrot = require(DIR.shared.lib.Mandelbrot)
local ComplexNumber = require(DIR.shared.class.ComplexNumber)

local player = Players.LocalPlayer

local screenGui = New "ScreenGui" {
    Parent = player.PlayerGui,
}
local display = GradientDisplay.new(Vector2.new(SIZE_X, SIZE_Y))
display.Frame.Parent = screenGui
display.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
display.Frame.Position = UDim2.fromScale(0.5, 0.5)

local function centerFromRange (startNum: number, endNum: number): number
    return (startNum + endNum) / 2
end

local center = Vector2.new(0.2, 0)
local zoomFactor = 1
local maxIterations = 200

for y = 1, SIZE_Y do
    for x = 1, SIZE_X do
        local xScalar = ((x - 1) / (SIZE_X - 1) - 0.5) / zoomFactor + 0.5
        local yScalar = ((y - 1) / (SIZE_Y - 1) - 0.5) / zoomFactor + 0.5
        local c = ComplexNumber.new(
            (xScalar + center.X - 0.5), 
            (yScalar + center.Y - 0.5)
        )

        local iterations, isInSet = Mandelbrot.GetValue(c, maxIterations)
        
        local color: Color3
        if isInSet then
            color = Color3.new(0, 0, 0)
        else
            color = Color3.fromHSV(iterations / maxIterations, 1, 1)
            -- invert color
            color = Color3.new(1 - color.R, 1 - color.G, 1 - color.B)
        end

        display:SetColor(color, Vector2.new(x, y))
    end
    task.wait()
end
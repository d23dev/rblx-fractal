local Mandelbrot = {}

local DIR = require(game.ReplicatedFirst.DIR)
local ComplexNumber = require(DIR.shared.class.ComplexNumber)

function Mandelbrot.GetValue (c: ComplexNumber, maxIterations: number): (number, boolean)
    local z = ComplexNumber.new(0, 0)
    for i = 1, maxIterations do
        z = z:Square():Add(c)
        if z.Real * z.Real + z.Imaginary * z.Imaginary > 4 then
            return i, false
        end
    end
    return maxIterations, true
end

return Mandelbrot
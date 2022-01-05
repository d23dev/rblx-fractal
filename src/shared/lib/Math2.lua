--// Math2
--[[
	Extends the math library. Scripts can simply overwrite "math" as a variable referencing this class and all original math functions will be maintained.
]]

local Math2 = {}

-- inherit all old math functions
for key, func in pairs(math) do
	Math2[key] = func
end



--// Lerp between two numbers
function Math2.lerpNum (num1: number, num2: number, t: number): number
	local diff = num2 - num1
	return num1 + diff * t
end

--// Inverted lerp, returns a scalar between 0 and 1 that represents the position of middleNum in the range [num1, num2]
function Math2.inverseLerp (num1: number, num2: number, middleNum: number, clamped: boolean?): number
	local diff = num2 - num1
	local progress = middleNum - num1
	local result = progress / diff
	
	if clamped then
		result = math.clamp(result, 0, 1)
	end
	
	return result
end

--// Prevent divisions by zero
function Math2.divSafe (num: number)
	if num == 0 then
		num = 0.001
	end
	return num
end

--// Multiply each value in a UDim2 by <num>
function Math2.multUDim2 (udim2: UDim2, num: number): UDim2
	return UDim2.new(udim2.X.Scale * num, udim2.X.Offset * num, udim2.Y.Scale * num, udim2.Y.Offset * num)
end

return Math2
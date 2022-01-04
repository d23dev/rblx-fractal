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

return Math2
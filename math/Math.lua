local StringTools = require("dropletlib.util.StringTools")
local Math = {
	-- variables
	EPSILON = 0.0000001,
	MIN_FLOAT_VALUE = 5e-324,
	MAX_FLOAT_VALUE = 1.79e+308,

	MIN_INT_VALUE = -2147483647,
	MAX_INT_VALUE = 2147483647,

	-- functions
	lerp = function(a, b, ratio)
		return a + ratio * (b - a)
	end,
	bound = function(value, minimum, maximum)
		if value < minimum then return minimum end
		if value > maximum then return maximum end
		return value
	end,
	wrap = function(value, minimum, maximum)
		local range = maximum - minimum + 1

		if value < minimum then
			value = value + range * math.floor((minimum - value) / range + 1)
		end
		return minimum + (value - minimum) % range;
	end,
	roundDecimal = function(value, decimals)
		local mult = 10 ^ decimals -- thanks srt for math info (real)
		return math.floor(value * mult) / mult
	end,
	floor = math.floor,
	round = function(value)
		return math.floor(value + 0.5) -- fuck you
	end,
	remap = function(value, start1, stop1, start2, stop2)
		return start2 + (value - start1) * ((stop2 - start2) / (stop1 - start1))
	end,
	getDecimals = function(number)
		local helperArray = StringTools.split(tostring(number), ".")
		local decimals = 0
		if #helperArray > 1 then
			decimals = #helperArray[2]
		end
		return decimals
	end
}
return Math
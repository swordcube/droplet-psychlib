local Vector2 = require("dropletlib.math.Vector2")
local Object = {
	new = function(_x, _y, _type)
		return {
			x = _x,
			y = _y,
			offset = Vector2.new(0, 0),
			visible = true,
			camera = "game",
			type = _type
		}
	end
}
return Object
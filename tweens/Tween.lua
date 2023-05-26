local Ease = require("dropletlib.tweens.Ease")
local TweenManager = require("dropletlib.tweens.TweenManager")

local Tween = {
	tween = function(object, values, duration, options)
		if extra == nil then
			extra = {ease = nil}
		end
		if extra.ease == nil then
			extra.ease = Ease.linear
		end
		TweenManager.tween(object, values, duration, options)
	end
}

return Tween
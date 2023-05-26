local Game = require("dropletlib.Game")

local TweenManager = {
	_tweens = {}
}

TweenManager.tween = function(object, values, duration, options)
	debugPrint("tweens are unimplementated :(")
end

return TweenManager
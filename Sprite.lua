local SPRITE_PREFIX = "droplet_sprite"

local Game = require("dropletlib.Game")
local Object = require("dropletlib.Object")
local Vector2 = require("dropletlib.math.Vector2")

local Sprite = {
	new = function(_x, _y)
		local _tag = SPRITE_PREFIX..tostring((#Game.addedSprites)+1)
		makeLuaSprite(_tag, "", _x, _y)

		-- variables
		local _sprite = Object.new(_x, _y, "sprite")
		_sprite.scale = Vector2.new(1, 1)
		_sprite.angle = 0
		_sprite.alpha = 1
		_sprite.tag = _tag

		-- functions
		_sprite.loadGraphic = function(graphic, width, height)
			loadGraphic(_tag, graphic, width, height)
			return _sprite
		end
		_sprite.destroy = function()
			table.remove(Game.addedSprites, _sprite)
			removeLuaSprite(_tag, true)
		end
		_sprite.setPosition = function(x, y)
			_sprite.x = x
			_sprite.y = y
		end
		_sprite.screenCenter = function(axes)
			screenCenter(_tag, axes)
			_sprite.x = getProperty(_tag..".x")
			_sprite.y = getProperty(_tag..".y")
		end
		_sprite.updateHitbox = function()
			updateHitbox(_tag)
			_sprite.offset.set(getProperty(_tag..".offset.x"), getProperty(_tag..".offset.y"))
		end

		-- add the sprite
		table.insert(Game.addedSprites, _sprite)
		return _sprite
	end
}
Game.connect("onUpdate", function(elapsed)
	for i = 1, #Game.addedSprites do
		local name = SPRITE_PREFIX..tostring(i)
		local sprite = Game.addedSprites[i]

		-- TODO: find a better way to do this
		setProperty(name..".x", sprite.x)
		setProperty(name..".y", sprite.y)
		setProperty(name..".scale.x", sprite.scale.x)
		setProperty(name..".scale.y", sprite.scale.y)
		setProperty(name..".offset.x", sprite.offset.x)
		setProperty(name..".offset.y", sprite.offset.y)
		setProperty(name..".angle", sprite.angle)
		setProperty(name..".alpha", sprite.alpha)
		setProperty(name..".visible", sprite.visible)
	end
end)

return Sprite
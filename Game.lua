local Game = {
	addedFuncs = {},
	addedSprites = {}
}

Game.callAddedFunc = function(name, ...)
	for i = 1,#Game.addedFuncs[name] do
		Game.addedFuncs[name][i](...)
	end
end

Game.connect = function(name, f)
	_G[name] = function(...)
		Game.callAddedFunc(name, ...)
	end
	if Game.addedFuncs[name] == nil then
		Game.addedFuncs[name] = {}
	end
	table.insert(Game.addedFuncs[name], f)
end

Game.disconnect = function(name, f)
	if f ~= Game.addedFuncs[name] then
		debugPrint("[DROPLET] - Provided function to disconnect hasn't been connected yet!")
	end
	_G[name] = nil
	table.remove(Game.addedFuncs[name], f)
end

Game.add = function(object)
	local typeCallbacks = {
		sprite = function()
			setObjectCamera(object.tag, object.camera)
			addLuaSprite(object.tag, true)
		end
	}
	local f = typeCallbacks[object.type]
	if f ~= nil then f() end
end

Game.insert = function(position, object)
	Game.add(object)
	setObjectOrder(object, position)
end

Game.getObjectOrder = function(object)
	if object.type == "sprite" then
		return getObjectOrder(object.tag)
	end
	return getObjectOrder(object)
end

Game.get = function(property)
	getProperty(property, value)
end

Game.set = function(property, value)
	setProperty(property, value)
end

return Game
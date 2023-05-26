local Point = {
	new = function(_x, _y)
		local _point = {x = _x, y = _y}
		_point.set = function(_x, _y)
			_point.x = _x
			_point.y = _y
		end
		_point.add = function(_x, _y)
			_point.x = _point.x + _x
			_point.y = _point.y + _y
		end
		_point.subtract = function(_x, _y)
			_point.x = _point.x - _x
			_point.y = _point.y - _y
		end
		_point.multiply = function(_x, _y)
			_point.x = _point.x * _x
			_point.y = _point.y * _y
		end
		_point.divide = function(_x, _y)
			_point.x = _point.x / _x
			_point.y = _point.y / _y
		end
		return _point
	end
}
return Point
local Ease = {
	-- linear
	linear = function(t, b, c, d) 
		return c * t / d + b 
	end,

	-- quad
	inQuad = function(t, b, c, d) 
		return c * math.pow(t / d, 2) + b 
	end,
	outQuad = function(t, b, c, d)
	  t = t / d
	  return -c * t * (t - 2) + b
	end,
	inOutQuad = function(t, b, c, d)
	  t = t / d * 2
	  if t < 1 then return c / 2 * math.pow(t, 2) + b end
	  return -c / 2 * ((t - 1) * (t - 3) - 1) + b
	end,
	outInQuad = function(t, b, c, d)
	  if t < d / 2 then return outQuad(t * 2, b, c / 2, d) end
	  return inQuad((t * 2) - d, b + c / 2, c / 2, d)
	end,

	-- cubic
	inCubic = function(t, b, c, d) return c * math.pow(t / d, 3) + b end,
	outCubic = function(t, b, c, d) return c * (math.pow(t / d - 1, 3) + 1) + b end,
	inOutCubic = function(t, b, c, d)
	  t = t / d * 2
	  if t < 1 then return c / 2 * t * t * t + b end
	  t = t - 2
	  return c / 2 * (t * t * t + 2) + b
	end,
	outInCubic = function(t, b, c, d)
	  if t < d / 2 then return outCubic(t * 2, b, c / 2, d) end
	  return inCubic((t * 2) - d, b + c / 2, c / 2, d)
	end,

	-- quart
	inQuart = function(t, b, c, d) return c * math.pow(t / d, 4) + b end,
	outQuart = function(t, b, c, d) return -c * (math.pow(t / d - 1, 4) - 1) + b end,
	inOutQuart = function(t, b, c, d)
	  t = t / d * 2
	  if t < 1 then return c / 2 * math.pow(t, 4) + b end
	  return -c / 2 * (math.pow(t - 2, 4) - 2) + b
	end,
	outInQuart = function(t, b, c, d)
	  if t < d / 2 then return outQuart(t * 2, b, c / 2, d) end
	  return inQuart((t * 2) - d, b + c / 2, c / 2, d)
	end,

	-- quint
	inQuint = function(t, b, c, d) return c * math.pow(t / d, 5) + b end,
	outQuint = function(t, b, c, d) return c * (math.pow(t / d - 1, 5) + 1) + b end,
	inOutQuint = function(t, b, c, d)
	  t = t / d * 2
	  if t < 1 then return c / 2 * math.pow(t, 5) + b end
	  return c / 2 * (math.pow(t - 2, 5) + 2) + b
	end,
	outInQuint = function(t, b, c, d)
	  if t < d / 2 then return outQuint(t * 2, b, c / 2, d) end
	  return inQuint((t * 2) - d, b + c / 2, c / 2, d)
	end,

	-- sine
	inSine = function(t, b, c, d) return -c * cos(t / d * (pi / 2)) + c + b end,
	outSine = function(t, b, c, d) return c * sin(t / d * (pi / 2)) + b end,
	inOutSine = function(t, b, c, d) return -c / 2 * (cos(pi * t / d) - 1) + b end,
	outInSine = function(t, b, c, d)
	  if t < d / 2 then return outSine(t * 2, b, c / 2, d) end
	  return inSine((t * 2) -d, b + c / 2, c / 2, d)
	end,

	-- expo
	inExpo = function(t, b, c, d)
	  if t == 0 then return b end
	  return c * math.pow(2, 10 * (t / d - 1)) + b - c * 0.001
	end,
	outExpo = function(t, b, c, d)
	  if t == d then return b + c end
	  return c * 1.001 * (-math.pow(2, -10 * t / d) + 1) + b
	end,
	inOutExpo = function(t, b, c, d)
	  if t == 0 then return b end
	  if t == d then return b + c end
	  t = t / d * 2
	  if t < 1 then return c / 2 * math.pow(2, 10 * (t - 1)) + b - c * 0.0005 end
	  return c / 2 * 1.0005 * (-math.pow(2, -10 * (t - 1)) + 2) + b
	end,
	outInExpo = function(t, b, c, d)
	  if t < d / 2 then return outExpo(t * 2, b, c / 2, d) end
	  return inExpo((t * 2) - d, b + c / 2, c / 2, d)
	end,

	-- circ
	inCirc = function(t, b, c, d) return(-c * (sqrt(1 - math.pow(t / d, 2)) - 1) + b) end,
	outCirc = function(t, b, c, d)  return(c * sqrt(1 - math.pow(t / d - 1, 2)) + b) end,
	inOutCirc = function(t, b, c, d)
	  t = t / d * 2
	  if t < 1 then return -c / 2 * (sqrt(1 - t * t) - 1) + b end
	  t = t - 2
	  return c / 2 * (sqrt(1 - t * t) + 1) + b
	end,
	outInCirc = function(t, b, c, d)
	  if t < d / 2 then return outCirc(t * 2, b, c / 2, d) end
	  return inCirc((t * 2) - d, b + c / 2, c / 2, d)
	end,

	-- elastic
	calculatePAS = function(p,a,c,d)
	  p, a = p or d * 0.3, a or 0
	  if a < abs(c) then return p, c, p / 4 end -- p, a, s
	  return p, a, p / (2 * pi) * asin(c/a) -- p,a,s
	end,
	inElastic = function(t, b, c, d, a, p)
	  local s
	  if t == 0 then return b end
	  t = t / d
	  if t == 1  then return b + c end
	  p,a,s = calculatePAS(p,a,c,d)
	  t = t - 1
	  return -(a * math.pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
	end,
	outElastic = function(t, b, c, d, a, p)
	  local s
	  if t == 0 then return b end
	  t = t / d
	  if t == 1 then return b + c end
	  p,a,s = calculatePAS(p,a,c,d)
	  return a * math.pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
	end,
	inOutElastic = function(t, b, c, d, a, p)
	  local s
	  if t == 0 then return b end
	  t = t / d * 2
	  if t == 2 then return b + c end
	  p,a,s = calculatePAS(p,a,c,d)
	  t = t - 1
	  if t < 0 then return -0.5 * (a * math.pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b end
	  return a * math.pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
	end,
	outInElastic = function(t, b, c, d, a, p)
	  if t < d / 2 then return outElastic(t * 2, b, c / 2, d, a, p) end
	  return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
	end,

	-- back
	inBack = function(t, b, c, d, s)
	  s = s or 1.70158
	  t = t / d
	  return c * t * t * ((s + 1) * t - s) + b
	end,
	outBack = function(t, b, c, d, s)
	  s = s or 1.70158
	  t = t / d - 1
	  return c * (t * t * ((s + 1) * t + s) + 1) + b
	end,
	inOutBack = function(t, b, c, d, s)
	  s = (s or 1.70158) * 1.525
	  t = t / d * 2
	  if t < 1 then return c / 2 * (t * t * ((s + 1) * t - s)) + b end
	  t = t - 2
	  return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
	end,
	outInBack = function(t, b, c, d, s)
	  if t < d / 2 then return outBack(t * 2, b, c / 2, d, s) end
	  return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
	end,

	-- bounce
	outBounce = function(t, b, c, d)
	  t = t / d
	  if t < 1 / 2.75 then return c * (7.5625 * t * t) + b end
	  if t < 2 / 2.75 then
	    t = t - (1.5 / 2.75)
	    return c * (7.5625 * t * t + 0.75) + b
	  elseif t < 2.5 / 2.75 then
	    t = t - (2.25 / 2.75)
	    return c * (7.5625 * t * t + 0.9375) + b
	  end
	  t = t - (2.625 / 2.75)
	  return c * (7.5625 * t * t + 0.984375) + b
	end,
	inBounce = function(t, b, c, d) return c - outBounce(d - t, 0, c, d) + b end,
	inOutBounce = function(t, b, c, d)
	  if t < d / 2 then return inBounce(t * 2, 0, c, d) * 0.5 + b end
	  return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
	end,
	outInBounce = function(t, b, c, d)
	  if t < d / 2 then return outBounce(t * 2, b, c / 2, d) end
	  return inBounce((t * 2) - d, b + c / 2, c / 2, d)
	end
}
return Ease
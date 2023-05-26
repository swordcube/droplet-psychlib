local StringTools = {
	split = function(inputstr, sep)
		if sep == nil or sep == "" then
		  sep = "%s"
		end
		local t = {}
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		  table.insert(t, str)
		end
		return t
	end,
	occurancesOf = function(str, char)
		local count = 0
		for i = 1, #str do
		    if str:sub(i, i) == char then
		        count = count + 1
		    end
		end
		return count
	end,
	tableToString = function(table)
		local length = 0
		for k,v in pairs(table) do
			length = length + 1
		end
		local i = 1
		local penis = "{"
		for k,v in pairs(table) do
			local quote = StringTools.occurancesOf(k, ".") > 0 and "\"" or ""
			penis = penis .. quote .. k .. quote .. ": " .. v

			if i ~= length then
				penis = penis .. ", "
			end

			i = i + 1
		end
		penis = penis .. "}"
		return penis
	end
}
return StringTools
EMM = EMM or {}

EMM.client_includes = {}

gamemode_name = "emm"
gamemode_lua_directory = gamemode_name.."/gamemode/"

function engine.ActiveGamemode()
	return gamemode_name
end

function IsSharedFile(file)
	return string.match(file, "sh.lua$")
end

function IsClientFile(file)
	return string.match(file, "cl.lua$")
end

function EMM.Include(inc, inc_func)
	inc_func = inc_func or include

	if istable(inc) then
		for _, _inc in pairs(inc) do
			EMM.Include(_inc)
		end
	elseif isstring(inc) then
		local inc_path = gamemode_lua_directory..inc
		local inc_file = file.Find(inc_path, "LUA")[1]
		local sh_inc_file = file.Find(inc_path..".sh.lua", "LUA")[1]
		local cl_inc_file = file.Find(inc_path..".cl.lua", "LUA")[1]

		if inc_file and (IsSharedFile(inc_file) or IsClientFile(inc_file)) then
			inc_func(inc_path)
		end

		if sh_inc_file then
			inc_func(inc_path..".sh.lua")
		end

		if cl_inc_file then
			inc_func(inc_path..".cl.lua")
		end

		EMM.client_includes[inc] = true
	end
end

include(gamemode_name..".lua")

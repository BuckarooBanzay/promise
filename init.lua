local MP = minetest.get_modpath("promise")

dofile(MP.."/promise.lua")
dofile(MP.."/util.lua")
dofile(MP.."/http.lua")
dofile(MP.."/formspec.lua")

if minetest.get_modpath("mtt") and mtt.enabled then
	local http = assert(minetest.request_http_api())

	dofile(MP .. "/promise.spec.lua")
	dofile(MP .. "/util.spec.lua")
	loadfile(MP .. "/http.spec.lua")(http)
end
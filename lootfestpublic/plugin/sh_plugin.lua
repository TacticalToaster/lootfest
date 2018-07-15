--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]



PLUGIN:SetGlobalAlias("LOOTFEST")

LOOTFEST.lootTables = {};

Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

Clockwork.plugin:AddExtra("/lootcrates/");
Clockwork.plugin:AddExtra("/loottables/");
//Clockwork.kernel:IncludeDirectory("lootcrates/", true);

function LOOTFEST:SetSearching(player, time)
	Clockwork.player:SetAction(player, "searchingCrate", time);
end;
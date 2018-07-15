--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

Clockwork.setting:AddCheckBox("Admin ESP", "Show Loot Containers.", "cwLootESP", "Whether or not to view loot containers in the AdminESP.", function()
	return Clockwork.player:IsAdmin(Clockwork.Client);
end);
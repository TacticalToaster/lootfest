--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

function PLUGIN:Initialize()
	CW_CONVAR_LOOTESP = Clockwork.kernel:CreateClientConVar("cwLootESP", 0, false, true);
end;

-- Called when an entity's menu options are needed.
function LOOTFEST:GetEntityMenuOptions(entity, options)
	local class = entity:GetClass();
	
	if (class == "cw_lootcrate") then
		options["Search"] = "cwSearchCrate";
	end;
end;

function LOOTFEST:GetProgressBarInfo()
	local action, percentage = Clockwork.player:GetAction(Clockwork.Client, true);
	
	if (Clockwork.Client:Alive() and action == "searchingCrate") then
		return {text = "Searching container...", percentage = percentage, flash = percentage < 10};
	end;
end;

function LOOTFEST:GetAdminESPInfo(info)
	if (CW_CONVAR_LOOTESP:GetInt() == 1) then
		for k, v in pairs (ents.GetAll()) do 
			if (v:GetClass() == "cw_lootcrate") then
				if (v:IsValid()) then
					local position = v:GetPos() + Vector(0, 0, 20);
					local lootName = v:GetDTString(0);
					local color = Color(255, 150, 0, 255);

					table.insert(info, {
						position = position,
						text = {
							{
								text = "[Loot Container]", 
								color = color
							},
							{
								text = lootName, 
								color = color
							}
						}
					});
				end;
			end;
		end;
	end;
end;
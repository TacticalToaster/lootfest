--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

function LOOTFEST:ClockworkInitPostEntity()
	//self:LoadLootStuff(); 
	self.lootItems = {};
	
	for k, v in pairs(Clockwork.item:GetAll()) do
		if (!v("isNotLootItem") and !v("isBaseItem")) then
			self.lootItems[#self.lootItems + 1] = {
				v("uniqueID"),
				v("lootWeight") or 1
			};
		end;
		if (v("lootTables")) then
			for k2, v2 in pairs(v("lootTables")) do
				self:AddLootToTable(v("uniqueID"), k2, v2);
			end;
		end;
	end;

	self.lootTables.defaultloot = table.Copy(self.lootItems);
end;

-- Called when an entity's menu option should be handled.
function LOOTFEST:EntityHandleMenuOption(player, entity, option, arguments)
	local class = entity:GetClass();
	
	if (class == "cw_lootcrate" and arguments == "cwSearchCrate") then
		self:SearchCrate(player, entity);
	end;
end;
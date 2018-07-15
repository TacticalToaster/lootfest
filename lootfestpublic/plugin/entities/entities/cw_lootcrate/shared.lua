--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

DEFINE_BASECLASS("base_gmodentity");

ENT.Type = "anim";
ENT.Author = "TacticalToaster";
ENT.PrintName = "Loot Crate";
ENT.Spawnable = false;
ENT.AdminSpawnable = false;
ENT.UsableInVehicle = true;

-- Called when the data tables are setup.
function ENT:SetupDataTables()
	self:DTVar("String", 0, "CrateName");
	self:DTVar("String", 1, "Description")
end;

-- A function to get the entity's item table.
function ENT:GetCrateTable()
	//return Clockwork.entity:FetchCrateTable(self);
	if (CLIENT) then
		return Clockwork.lootcrate:FindByID(self:GetDTString(0));
	end;

	return self.cwCrateTable;
end;
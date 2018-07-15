Clockwork.lootcrate = Clockwork.kernel:NewLibrary("LootCrate");

Clockwork.lootcrate.stored = Clockwork.lootcrate.stored or {};

/* Define the base loot crate class */

local CLASS_TABLE = {__index = CLASS_TABLE};

CLASS_TABLE.name = "Crate Base";
CLASS_TABLE.skin = 0;
CLASS_TABLE.size = 8;
CLASS_TABLE.model = "models/error.mdl";
CLASS_TABLE.crateID = 0;
CLASS_TABLE.description = "An item with no description.";
CLASS_TABLE.lootTable = "defaultloot";
CLASS_TABLE.lootRespawnTime = 300;
CLASS_TABLE.lootSearchTime = 5;

function CLASS_TABLE:Register()
	return Clockwork.lootcrate:Register(self);
end;

-- A function to get a new item.
function Clockwork.lootcrate:New()
	local object = Clockwork.kernel:NewMetaTable(CLASS_TABLE);
		object.data = {};
	return object;
end;

-- A function to register a new item.
function Clockwork.lootcrate:Register(crateTable)
	crateTable.uniqueID = string.lower(string.gsub(crateTable.uniqueID or string.gsub(crateTable.name, "%s", "_"), "['%.]", ""));
	crateTable.index = Clockwork.kernel:GetShortCRC(crateTable.uniqueID);
	self.stored[crateTable.uniqueID] = crateTable;
	
	if (crateTable.model) then
		util.PrecacheModel(crateTable.model);
		
		if (SERVER) then
			Clockwork.kernel:AddFile(crateTable.model);
		end;
	end;
	
	if (crateTable.attachmentModel) then
		util.PrecacheModel(crateTable.attachmentModel);
		
		if (SERVER) then
			Clockwork.kernel:AddFile(crateTable.attachmentModel);
		end;
	end;
	
	if (crateTable.replacement) then
		util.PrecacheModel(crateTable.replacement);
		
		if (SERVER) then
			Clockwork.kernel:AddFile(crateTable.replacement);
		end;
	end;
end;

function Clockwork.lootcrate:FindByID(identifier)
	if (identifier) then
		local lowerName = string.lower(identifier);
		local crateTable = nil;
		
		for k, v in pairs(self.stored) do
			local crateName = v.name;
			
			if (string.find(string.lower(crateName), lowerName)
			and (!crateTable or string.utf8len(crateName) < string.utf8len(crateTable.name))) then
				crateTable = v;
			end;
		end;
		
		return crateTable;
	end;
end;

function Clockwork.lootcrate:GetSize()
	return self.size;
end;
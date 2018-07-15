--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

//A function to get a single random key in a select table.
function LOOTFEST:GetWeightedRandomKey(table)
	local sum = 0;

	for _, chance in pairs(table) do
		sum = sum + chance;
	end;

	local select = math.random() * sum;

	for key, chance in pairs(table) do
		select = select - chance;
		if select < 0 then return key end;
	end;
end;

//A function to create a loot table with a name and preset table.
function LOOTFEST:CreateLootTable(name, table)
	local tableName = string.lower(name);
	if table then
		self.lootTables[tableName] = table;
	end;
end;


//A function to add a single item to a loot table.
function LOOTFEST:AddLootToTable(uniqueID, table, lootWeight)
	if !(self.lootTables[table]) then self:CreateLootTable(table, {}) end;
	self.lootTables[table][uniqueID] = lootWeight or 1;
	return self.lootTables[table][uniqueID];
end;

function LOOTFEST:SearchCrate(player, entity)
	local searchTime = entity.cwCrateTable.lootSearchTime;

	self:SetSearching(player, searchTime);

	Clockwork.player:EntityConditionTimer(player, entity, entity, searchTime, 192, function() return true end, function(success)
		print(success, player:IsValid(), entity:IsValid())
		if (success) then
			Clockwork.storage:Open(player, {
				name = entity.cwCrateTable.name,
				weight = entity.cwWeight,
				entity = entity,
				distance = 192,
				cash = 0,
				isOneSided = true,
				inventory = entity.cwInventory,
				OnGiveCash = function(player, storageTable, cash)
					return false;
				end,
				OnTakeCash = function(player, storageTable, cash)
					return false;
				end
			});
		end

		self:SetSearching(player, false);

	end);
end;
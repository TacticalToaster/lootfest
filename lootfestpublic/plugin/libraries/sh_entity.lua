cwEntity = Clockwork.entity;

function cwEntity:FetchCrateTable(entity)
	//print(entity, entity.cwCrateTable)
	return entity.cwCrateTable;
end;

function cwEntity:CreateLootCrate(crateTable, position, angles)
		local entity = ents.Create("cw_lootcrate");
		
		if (!angles) then
			angles = Angle(0, 0, 0);
		end;
		
		entity:SetCrateTable(crateTable);
		entity:SetAngles(angles);
		entity:SetPos(position);
		entity:Spawn();
		
		if (crateTable.OnEntitySpawned) then
			crateTable:OnEntitySpawned(entity);
		end;
		
		local crateBodyGroup = crateTable.bodyGroup;
		
		if (crateBodyGroup) then
			entity:SetBodygroup(crateBodyGroup, 1);
		end;
		
		return entity;
	end;
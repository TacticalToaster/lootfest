--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetHealth(25);
	self:SetSolid(SOLID_VPHYSICS);
	
	local physicsObject = self:GetPhysicsObject();
	
	if (IsValid(physicsObject)) then
		physicsObject:Wake();
		physicsObject:EnableMotion(true);
	end;
end;

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

-- A function to set the item of the entity.
function ENT:SetCrateTable(crateTable)
	if (crateTable) then
		self:SetSkin(crateTable.skin);
		self:SetModel(crateTable.model);
		//self:SetDTInt(0, itemTable("index"));
		
		if (crateTable.OnCreated) then
			crateTable:OnCreated(self);
		end;
		
		self.cwRespawnTime = CurTime() + crateTable.lootRespawnTime;
		self.cwSize = crateTable.size;
		self.cwInventory = {};
		self:SetDTString(0, crateTable.name);
		self:SetDTString(1, crateTable.description);
		self.cwCrateTable = crateTable;

		self:SpawnLoot()
	end;
end;

function ENT:SpawnLoot()
	local itemList = Clockwork.inventory:GetAsItemsList(self.cwInventory);

	for k, v in pairs(itemList) do
		Clockwork.inventory:RemoveInstance(self.cwInventory, v);
	end;

	for i=1, self.cwSize do
		local uniqueID = LOOTFEST:GetWeightedRandomKey(LOOTFEST.lootTables[self.cwCrateTable.lootTable]);
		Clockwork.inventory:AddInstance(
			self.cwInventory, Clockwork.item:CreateInstance(uniqueID)
			);
	end;

	self.cwWeight = Clockwork.inventory:CalculateWeight(self.cwInventory);
end;

-- Called when the entity is removed.
function ENT:OnRemove()
	local crateTable = self.cwCrateTable;
	
	if (crateTable and crateTable.OnEntityRemoved) then
		crateTable:OnEntityRemoved(self);
	end;
end;

-- A function to explode the entity.
function ENT:Explode()
	local effectData = EffectData();
		effectData:SetStart(self:GetPos());
		effectData:SetOrigin(self:GetPos());
		effectData:SetScale(8);
	util.Effect("GlassImpact", effectData, true, true);

	self:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav");
end;

/*-- Called when the entity takes damage.
function ENT:OnTakeDamage(damageInfo)
	local itemTable = self.cwItemTable;
	
	if (itemTable.OnEntityTakeDamage
	and itemTable:OnEntityTakeDamage(self, damageInfo) == false) then
		return;
	end;
	
	Clockwork.plugin:Call("ItemEntityTakeDamage", self, itemTable, damageInfo);
	
	if (damageInfo:GetDamage() > 0) then
		self:SetHealth(math.max(self:Health() - damageInfo:GetDamage(), 0));
		
		if (self:Health() <= 0) then
			if (itemTable.OnEntityDestroyed) then
				itemTable:OnEntityDestroyed(self);
			end;
			
			Clockwork.plugin:Call("ItemEntityDestroyed", self, itemTable);
			
			self:Explode();
			self:Remove();
		end;
	end;
end;*/

-- Called each frame.
function ENT:Think()
	local crateTable = self.cwCrateTable;
	local curTime = CurTime();
	
	if (crateTable) then
		if (self.cwRespawnTime <= curTime) then
			self:SpawnLoot()
			self.cwRespawnTime = curTime + crateTable.lootRespawnTime;
		end;

		if (crateTable.OnEntityThink) then
			local nextThink = crateTable:OnEntityThink(self);
			
			if (type(nextThink) == "number") then
				return self:NextThink(CurTime() + nextThink);
			end;
		end;
	end;

	self:NextThink(CurTime() + 1);
end;
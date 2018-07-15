--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

include("shared.lua")

-- Called when the target ID HUD should be painted.
function ENT:HUDPaintTargetID(x, y, alpha)
	local colorTargetID = Clockwork.option:GetColor("target_id");
	local colorWhite = Clockwork.option:GetColor("white");
	local crateName = self:GetDTString(0);
	local crateDesc = self:GetDTString(1);
	print(crateName, crateDesc)
	
	if (crateName && crateDesc) then
		y = Clockwork.kernel:DrawInfo(crateName, x, y, colorTargetID, alpha);
		y = Clockwork.kernel:DrawInfo(crateDesc, x, y, colorWhite, alpha);
	end;
end;

/*
-- Called when the entity should draw.
function ENT:Draw()
	if (!Clockwork.entity:HasFetchedItemData(self)) then
		return;
	end;
	
	local drawModel = true;
	local itemTable = Clockwork.entity:FetchItemTable(self);
	local shouldDrawItemEntity = Clockwork.plugin:Call("ItemEntityDraw", itemTable, self);
	
	if (shouldDrawItemEntity == false
	or (itemTable.OnDrawModel and itemTable:OnDrawModel(self) == false)) then
		drawModel = false;
	end;
	
	if (drawModel) then
		self:DrawModel();
	end;
end;
*/
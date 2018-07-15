--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("AddLootCrate");
COMMAND.tip = "Add a loot crate at your target position.";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local crateTable = Clockwork.lootcrate:FindByID(arguments[1]);

	if (!crateTable) then
		Clockwork.player:Notify(player, "That's not a valid crate!")
		return false;
	end;

	local trace = player:GetEyeTraceNoCursor();
	
	local entity = Clockwork.entity:CreateLootCrate(crateTable, trace.HitPos + Vector(0, 0, 30), Angle(0, player:EyeAngles().yaw + 180, 0));

	if (IsValid(entity)) then
		Clockwork.player:Notify(player, "You have added a "..crateTable.name..".");
	end;
end;

COMMAND:Register();
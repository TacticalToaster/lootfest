local LOOTCRATE = Clockwork.lootcrate:New();
	LOOTCRATE.name = "Example"; // Name of loot container, used in the AddLootCrate command
	LOOTCRATE.uniqueID = "exapmle"; // nniqueID, currently useless
	LOOTCRATE.skin = 0; // Skin of the model if the model has multiple skins
	LOOTCRATE.size = 4; // Amount of items that will spawn in the container at once
	LOOTCRATE.model = "models/props_junk/cardboard_box003a.mdl"; // Container's model
	LOOTCRATE.description = "A cardboard box filled with scrap."; // Description of the container
	LOOTCRATE.lootTable = "example"; // Loot table used to generate loot
	LOOTCRATE.lootRespawnTime = 600; // Amount of time in seconds for loot to spawn
	LOOTCRATE.lootSearchTime = 5; // Amount of time it takes to search the container
LOOTCRATE:Register();
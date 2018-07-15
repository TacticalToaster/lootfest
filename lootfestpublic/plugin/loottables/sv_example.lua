// The table follows the format of the key being the item's uniqueID and the value being the chance.
// You can make the chance be out of 100 by making sure all the chances add up to 100, but that isn't required
// You only need to change the uniqueID and chance, along with the string in the CreateLootTable method

local LOOT = {
	["item_example"] = 25,
	["item_example2"] = 25,
	["item_example3"] = 25,
	["item_example4"] = 25
};
LOOTFEST:CreateLootTable("example", LOOT); // Registers the table under the name you want

require "mods/AddictionMod/api/addAddiction";
local sl = require "mods/Utils/SaveLoad";  -- shortcut to SaveLoad module (can be acceses also as SaveLoad from the _G table (global table)
-- this sl table is required if you want to save data directly to the memory again, without waiting for all the substances to be ran. (possible overwrite!)

local nicotineProperties = {}














-- update function, will be ran if nicotine is above 0
local updateNicotine = function(player,substanceData,item)


end
nicotineProperties.update = updateNicotine;















AddictionMod.addAddiction(nicotineProperties);
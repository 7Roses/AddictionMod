
require "mods/AddictionMod/api/addAddiction";
local sl = require "mods/Utils/SaveLoad";  -- shortcut to SaveLoad module (can be acceses also as SaveLoad from the _G table (global table)
-- this sl table is required if you want to save data directly to the memory again, without waiting for all the substances to be ran. (possible overwrite!)

-- predeclare the variables:
local updateNicotine;
local addSubstance;
local addEffect;
local recalcAddictionLevel;
local initSubstance;

local nicotineProperties = {}

nicotineProperties["addictionIncrease"] = 0.05; -- every tick your nicotine is above the addiction level for your character (this level is individual and can be altered in the beginning by traits
nicotineProperties["addictionBase"] = 600; -- base value for addiction level, individual level will be calculated from here.
nicotineProperties[" "] = 0;
nicotineProperties[" "] = 0;
nicotineProperties[" "] = 0;
nicotineProperties[" "] = 0;
nicotineProperties[" "] = 0;



addEffect = function(player,substanceData,positive)



end


recalcAddictionLevel = function(player,substanceData)

end



-- update function, will be ran if nicotine is above 0 (and thus the data for this substance exists!
updateNicotine = function(player,substanceData)
  local bodyNicotine = substanceData["nicotine"];
  bodyNicotine.amount = bodyNicotine.amount - 1;
  if bodyNicotine.amount > bodyNicotine.addictionAmount then
    recalcAddictionAmount(player,substanceData);
  end

  
end
nicotineProperties.update = updateNicotine;

local addSubstance = function(player,substanceData,item,amount)
  -- nothing to do, cause the default is to just add it to the substanceData, but if you want to do some additional thing then do this and return true.
  -- if you want to overwrite, skip the default way of adding substance set the return value then to false;
  if not substanceData["nicotine"] then
    initSubstance(player,substanceData);
  end
  return true;
end
nicotineProperties.addSubstance = addSubstance;



-- function first ran when the mod's core tries to acces a substance not yet in your substance-data (and so in need of getting it's own data created
initSubstance = function(player,substanceData)
  substanceData["nicotine"] = {};
  local nicotine = substanceData["nicotine"];
  nicotine["amount"] = 0;
  nicotine["addictionAmount"] = nicotineProperties["addictionBase"];

end
nicotineProperties.initSubstance = initSubstance;




AddictionMod.addAddiction(nicotineProperties);
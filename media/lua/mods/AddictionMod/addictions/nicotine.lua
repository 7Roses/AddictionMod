
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



-- function first ran when the mod's core tries to access a substance not yet in your substance-data (and so in need of getting it's own data created
initSubstance = function(player,substanceData)
  substanceData["nicotine"] = {};
  local nicotine = substanceData["nicotine"];
  
  local isChainSmoker,isSocialSmoker,isNonSmoker
  -- here should some extra code be added that recalculates the addictionAmount and other possible data by seeing into the characters traits and professions.
  
  if isChainSmoker then
    nicotine["addictionAmount"] = nicotineProperties["addictionBase"] * 3;
	nicotine["neededAmount"] = nicotineProperties["addictionBase"];
	nicotine["amount"] = nicotineProperties["addictionBase"] * 1.5;
  elseif isSocialSmoker then
    nicotine["addictionAmount"] = nicotineProperties["addictionBase"] * 0.95; -- slightly more addictive for you.
    nicotine["neededAmount"] = 0;
    nicotine["amount"] = 0;
  elseif isNonSmoker then
    nicotine["addictionAmount"] = nicotineProperties["addictionBase"] * 1.2;
	nicotine["neededAmount"] = 0;
    nicotine["amount"] = 0;
  else
    nicotine["addictionAmount"] = nicotineProperties["addictionBase"]; --set a base value.
	nicotine["neededAmount"] = 0;
	nicotine["amount"] = 0;
  end
  
end
nicotineProperties.initSubstance = initSubstance;

local initNicotineSubstance = function()
  
  nicotineProperties["chainSmoker"] = TraitFactory.addTrait("chainSmoker",AddictionMod.getString("gui.traits.chainSmoker.name") ,-4 ,AddictionMod.getString("gui.traits.chainSmoker.description") , false);


  nicotineProperties["chainSmoker"] = TraitFactory.addTrait("chainSmoker", "chain-smoker", -4, "he began as a social smoker, but now he smoke nearly non-stop", false);
  nicotineProperties["socialSmoker"] = TraitFactory.addTrait("socialSmoker", "social smoker", -3, "while not smoking a lot he/she's still smoking at every social meeting", false);
  nicotineProperties["nonSmoker"] = TraitFactory.addTrait("nonSmoker", "non smoker", 1, "comes from a familly of non smokers and has learned to ward smoke off as if it is the devil itself.", false);
  
  TraitFactory.setMutualExclusive("chainSmoker", "socialSmoker");
  TraitFactory.setMutualExclusive("socialSmoker","nonSmoker");
  TraitFactory.setMutualExclusive("nonSmoker", "chainSmoker");
  
end

AddictionMod.addLoadingStuff(initNicotineSubstance);
-- and now using the AddictionMod api to add the substance nicotine
AddictionMod.addAddiction(nicotineProperties);
-- and add the nicotine to some items:
AddictionMod.addSubstanceToItem("AddictionMod.nicotinePatch","nicotine",200);
AddictionMod.addSubstanceToITem("Base.cigarettes","nicotine",500); -- (not sure if cigarrettes is the right name!, look at this later ).

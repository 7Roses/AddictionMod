--
-- AddictionMod
-- by 7Roses
--
--
--

require "mods/AddictionMod/header";



local updateBody = function(player)
  local bloodwork = SaveLoad("playerData","bloodwork"); -- SaveLoad is an system that can retrieve data from the modData form player or world and serialize/un-serializes your tables automatically
  for i,substance in pairs(substances) do
    if bloodwork[i].amount > 0 then
	  substance.update(player);
	end
  end
end
AddictionMod.updateBody = updateBody;



local load = function()
  AddictionMod.log = Logger:new(AddictionMod.MOD_ID); -- logger is now active!
  AddictionMod.log:logging(Logger.INFO,AddictionMod.getString("console.loading.welcome"));
  AddictionMod.log:logging(Logger.INFO,AddictionMod.getString("console.loading.logger_loaded"));
  
  local configuration = require "mods/AddictionMod/config/globalConfig";
  AddictionMod.properties = {}; -- will be filled by the /mods/AddictionMod/config
  AddictionMod.log:Logging(Logger.INFO,AddictionMod.getString("console.loading.config_loading"));
  configuration.loadconfig();
  AddictionMod.log:Logging(Logger.INFO,AddictionMod.getString("console.loading.config_loaded"));
  
  AddictionMod.substances = {}; -- init the table for all the substances properties
  
  AddictionMod.itemSubstanceTable = {} -- to couple substances to an item.
  
  
  
  
  
  
  Events.onUpdatePlayer.Add(updateBody);
end
AddictionMod.load = load;




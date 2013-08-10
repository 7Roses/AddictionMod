-- AddictionMod head file.

require "mods/AddictionMod/header";

local load = function()
  AddictionMod.log = Logger:new(AddictionMod.MOD_ID); -- logger is now active!
  AddictionMod.log:logging(Logger.INFO,AddictionMod.getString("console.loading.welcome"));
  AddictionMod.log:logging(Logger.INFO,AddictionMod.getString("console.loading.logger_loaded"));
  
  local configuration = require "mods/AddictionMod/config/globalConfig";
  AddictionMod.properties = {}; -- will be filled by the /mods/AddictionMod/config
  AddictionMod.log:Logging(Logger.INFO,AddictionMod.getString("console.loading.config_loading"));
  configuration.loadconfig();
  AddictionMod.log:Logging(Logger.INFO,AddictionMod.getString("console.loading.config_loaded"));
  
  
  
end
AddictionMod.load = load;

-- AddictionMod head file.

require "mods/AddictionMod/header";





local load = function()
  AddictionMod.log:logging(Logger.INFO,"this is a test");
  AddictionMod.log:info("this is a test specially for the info()");
end
AddictionMod.load = load;
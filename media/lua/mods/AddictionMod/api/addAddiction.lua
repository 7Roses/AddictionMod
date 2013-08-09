--
--  AddictionMod by 7Roses
--
--  AddictionMod api for adding an addiction.
--
--

require "mods/AddictionMod/header";
require "mods/AddictionMod/AddictionMod"; -- yes it actually needs to be ran already

local function addAddiction(properties)
  if properties == nil then
    Logger:logging(Logger.SEVERE,"please place a non nil table with your addiction information into the argument of AddictionMod.addAddiction(..)");
	return;
  elseif type(properties) ~="table" then
    Logger:logging(Logger.SEVERE,string.format("please place a table in the argument, you placed a object of type %s into the argument",type(properties)));
	return;
  end
  
end
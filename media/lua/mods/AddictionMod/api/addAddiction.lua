--
--  AddictionMod by 7Roses
--
--  AddictionMod api for adding an addiction.
--
--

require "mods/AddictionMod/header";
require "mods/AddictionMod/AddictionMod"; -- yes it actually needs to be ran already. (gives the AddictionMod table and access to the logger of AddictionMod

local function addAddiction(properties)
  -- start the hole test procedure to see if the substance has the needed variables/functions/type
  if properties == nil then
    AddictionMod.log:logging(Logger.SEVERE,"please place a non nil table with your addiction information into the argument of AddictionMod.addAddiction(..)");
	return;
  elseif type(properties) ~="table" then
    AddictionMod.log:logging(Logger.SEVERE,string.format("please place a table in the argument, you placed a object of type %s into the argument",type(properties)));
	return;
  elseif not properties["name"] then
    AddictionMod.log:logging(Logger.SEVER,"there wasn't found any name entry in the property table for this substance");
  elseif not properties["update"] or type(properties["update"]) ~= "function" then
    AddictionMod.log:logging(Logger.SEVER,string.format("there wasn't found any entry called update or the type of the variable wasn't a function (substance: %s)",properties.name));
  elseif not properties["addSubstance"] or type(properties["addSubstance"]) ~= "function" then
    AddictionMod.log:logging(Logger.SEVER,string.format("there wasn't found any entry called addSubstance or the type of the variable wasn't a function (substance: %s)",properties.name));
  elseif not properties["initSubstance"] or type(properties["initSubstance"]) ~= "function" then
    AddictionMod.log:logging(Logger.SEVER,string.format("there wasn't found any entry called initSubstance or the type of the variable wasn't a function (substance: %s)",properties.name));
  end
  AddictionMod.substances[properties.name] = properties;
end
AddictionMod.addAddiction = addAddiction;

local function addSubstanceToItem(itemName,substanceName,amount)
  if not itemName or not substanceName or not amount then
    AddictionMod.log:logging(Logger.SEVER,"one or more parameters where nil, you should give an itemname(type: string), a substanceName (type: string) and an amount (type: number)");
    return;
  end
  
  
  
  if not AddictionMod.itemSubstanceTable[itemName] then
    AddictionMod.itemSubstanceTable[itemName] = {};
  end
  table.insert(AddictionMod.itemSubstanceTable.itemName,substanceName,amount);
end
AddictionMod.addSubstanceToItem()


-- an example to how you can add a langfile to the AddictionMod

require "mods/AddictionMod/header"; -- always needed, otherwise the AddictionMod table could be non-existent 
require "mods/AddictionMod/languageSupport/AddictionModLanguageSupport";  -- to be sure the AddictionMod has created the needed elements for language support.

local function loadLang()
  local tbl = {};
  
  -- ui texts
  tbl["ui.inventorymenu.takeOnePill"] = "take a pill";
  tbl["ui.inventorymenu.takeAShot"] = "take a shot"; -- for the injection items
  
  AddictionMod.LanguageSupport.addLangFile("EN_GB",tbl); -- the actual insertion of your langfile into the mod.
end

loadLang(); -- call the function once everything is done.














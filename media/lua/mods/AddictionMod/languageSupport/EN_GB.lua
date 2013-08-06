
require "mods/AddictionMod/languageSupport/AddictionModLanguageSupport";
require "mods/AddictionMod/header";

local function loadLang()
  local tbl = {};
  
  -- ui texts
  tbl["ui.inventorymenu.takeOnePill"] = "take a pill";
  tbl["ui.inventorymenu.takeAShot"] = "take a shot"; -- for the injection items
  
  AddictionMod.LanguageSupport.addLangFile("EN_GB",tbl);
end
















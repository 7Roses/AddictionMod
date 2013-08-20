-- an example to how you can add a langfile to the AddictionMod

require "mods/AddictionMod/header"; -- always needed, otherwise the AddictionMod table could be non-existent 
require "mods/AddictionMod/languageSupport/AddictionModLanguageSupport";  -- to be sure the AddictionMod has created the needed elements for language support.

local function loadLang()
  local tbl = {};
  
  -- console texts
  tbl["console.loading.welcome"] = "loading AddictionMod by 7Roses";
  
  -- gui texts
  tbl["gui.inventorymenu.takeOnePill"] = "take a pill";
  tbl["gui.inventorymenu.takeAShot"] = "take a shot"; -- for the injection items
  
  -- 
  
  
  
  
  
  -- addition language files
  --nicotine.
  tbl["gui.traits.chainSmoker.name"] = "chain-smoker";
  tbl["gui.traits.chainSmoker.description"] = "he began as a social smoker, but now he smoke nearly non-stop";
  

  
  AddictionMod.LanguageSupport.addLangFile("EN_GB",tbl); -- the actual insertion of your langfile into the mod.
end

loadLang(); -- call the function once everything is done.














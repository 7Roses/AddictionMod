
require "mods/AddictionMod/header";


AddictionMod.LanguageSupport = LanguageSupport({languagesupport.defaultlanguage="EN_GB"}); -- create the language object, and gives EN_GB as default lang.

AddictionMod.getString = AddictionMod.LanguageSupport.getString; -- makes it even less of a string of codes to get the function.
AddictionMod.getStringWithObjects = AddictionMod.LanguageSupport.getStringWithObjects;
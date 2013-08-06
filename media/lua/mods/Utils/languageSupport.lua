-- used the tutorial at: http://lua-users.org/wiki/ObjectOrientationTutorial
-- closuere based class, so others who may be more confortable with java can understand it a bit easier.
-- documentation on how to use it is at the bottom of this file.

function LanguageSupport(properties)
  if properties == nil then properties = {}; end
  local self = {
    
    -- public fields go in the instance table
  }
  -- private fields are implemented using locals
  -- they are faster than table access, and are truly private, so the code that uses your class can't get them
  myLangCode = "EN_GB";
  if properties["languagesupport.defaultlanguage"] ~=nil then
    myLangCode = properties["languagesupport.defaultlanguage"];
  end
  myLangFile = {};
  

  function self.setLang(langCode)
    myLangCode = langCode;
  end

  function self.getLang()
    return myLangCode;
  end

  -- add's the given langFile table to the current saved tables, overwrite them if same langcode
  function self.addLangFile(langCode,langFile)
    if myLangFile[langCode] ~= nil then
	  print("the langcode does exist");
	  for i,v in pairs(langFile) do 
	    table.insert(myLangFile[langCode],i,v);
	  end
	else
	  print("the langcode doesn't exist");
	  myLangFile[langCode]=langFile;
	end
  end
  
  function self.addString(langCode,stringCode,newstring)
    if myLangFile[langCode] ~= nil then
      table.insert(myLangFile[langCode],stringCode,newstring);
    else
	  myLangFile[langCode] = {};
	  myLangFile[langCode][stringCode] = newstring;
      --print(string.format("[LanguageSupport] could not find the table for language code %s, skipped the adding of a string for stringcode %s",langCode,newstring));
    end
  end
  
  -- functions will return the string for a given code using the saved language
  function self.getString(stringcode)
    if myLangFile[myLangCode] == nil then
	  return "unknown language !! change your language with .setLang(stringofyourlang);";
	end
    if myLangFile[myLangCode][stringcode] ~= nil then
	  return myLangFile[myLangCode][stringcode];
	else
	  return "unknown stringcode";
	end
  end
  
  -- function will return a formatted string with the given code and objects to fill in.
  function self.getStringWithObjects(stringcode,...)
    if myLangFile[myLangCode] == nil then
	  return "unknown language !! change your language with .setLang(stringofyourlang);";
	end
    if myLangFile[myLangCode][stringcode] ~= nil then
	  return string.format(myLangFile[myLangCode][stringcode],arg);
	else
	  return "unknown stringcode";
	end
  end
  -- return the instance
  return self
end
-- to make sure this function ('class') is been interpreted by PZ's lua interpretter before using it place next line in your code:
-- 
-- require "mods/Util/languageSupport";
-- 
-- in your code, best at the top, before you have made use of it's functionality.
-- after that you can make a local variable for your mod and run the function on it.
-- after that you will need to add your filetables to it.
-- 
-- local langsupport = LanguageSupport("EN_GB");
-- local langtable_en_gb = {};
-- langtable_eb_gb["console.testing"] = "an test string for you";
-- local langtable_nl = {};
-- langtable_nl["console.testing"] = "een teststring voor jou";
--
-- langsupport.addLangFile("EN_GB",langtable_en_gb);
-- langsupport.addLangFile("NL",{}); -- oeps we entered an empty table !
-- langsupport.addLangFile("NL",langtable_nl); -- the code should merge the old (in this example empty) table with the new entries.
--
-- if for example your mod has already an nl table inserted, or you have made it so other mods can add tables to your language support part then you can add some lines to them with this without overwriting the existing tables:
--
-- langsupport.addString("NL","console.testing2","een andere teststring voor u");
--
-- for retrieving information out of the languagesupport you can use one of those functions:
--
-- local sometempvartoprint = langsupport.getString("console.testing");
--
-- or if the string can be formatted and has some objects to put into:
-- local sometempvartoprint2 = langsupport.getStringWithObjects("console.testformat",someEarlierDefinedVar);
--
-- and to finish I could maybe give you the code to how to change your language (if you haven't found that out by looking at the code...)
--
-- if langsupport.getLang() ~= "NL" then -- this line is just to give the getlang function to :p
--   langsupport.setLang("NL");
-- end

-- WORKINGS FOR THE NEXT VERISON:


LanguageSupport_root = {}
LanguageSupport_root.MOD_ID = "LanguageSupport";
LanguageSupport_root.MOD_VERSION = "1.0.0";
LanguageSupport_root.MOD_DESCRIPTION = "";


local load = function() 
end
LanguageSupport_root.load = load;
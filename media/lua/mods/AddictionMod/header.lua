-- header file
-- this file is included in ALL the Addictionmod lua files, it makes sure that certain files are been evaluated


-- in this file only requires files from other mods/mod
require "mods/Utils/Logger"; -- for all the prints to the console
require "mods/Utils/languageSupport"; -- language support :p even when I only use 1 or 2 texts it still is included (can be extended later)


AddictionMod = {}

AddictionMod.MOD_ID = "AddictionMod";
AddictionMod.MOD_NAME = "Addiction Mod ";
AddictionMod.MOD_VERSION = "0.1.0";
AddictionMod.MOD_AUTHOR = "7Roses";
AddictionMod.MOD_DESCRIPTION = "some addition for an addictive playthough.";
AddictionMod.MOD_URL = nil; -- no website at the moment.
AddictionMod.log = Logger:new(AddictionMod.MOD_ID); -- logger is now active!
AddictionMod.properties = {}; -- will be filled by the /mods/AddictionMod/config
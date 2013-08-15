
S2T = require "mods/Utils/3th_party_scripts/S2T"; -- for needed conversions !

-- declarations of variables, easier to use if already declared.
local savePlayerData;
local saveWorldData;
local _saveCoordData;
local _savePlainData;
local _loadCoordTable;
local _loadPlainData;
local loadPlayerData;
local loadWorldData;

SaveLoad = {}
SaveLoad.MODULE_ID = "Utils::SaveLoad";

SaveLoad.log = Logger:new(SaveLoad.MODULE_ID);

SaveLoad.COORD = "world";
SaveLoad.PLAIN = "plain";

savePlayerData = function(player, CoordOrPlainData, variableName, value)
  if worldOrPlainData == "world" or worldOrPlainData == SaveLoad.COORD then
    _saveCoordData(player:getModData(),variableName,value);
  elseif worldOrPlainData == "plain" or worldOrPlainData == SaveLoad.PLAIN then
    _savePlainData(player:getModData(),variableName,value);
  else
    SaveLoad.log:logging(Logger.WARNING,"the parameter CoordOrPlain should have ether 'world' or 'plain' \n optionally you can use SaveLoad.PLAIN or SaveLoad.WORLD");
  end
end

-- if variableName is nil then an numerical index will be used as variableName.
_saveCoordData = function(datasource,variableName,value)
  if type(value) ~= "table" then
    SaveLoad.log:logging(Logger.WARNING,"data isn't a table, the value should be a table with x,y and z as a bare minimum of data");
	return;
  end
  if not value.x and not value.y and not value.z then
    SaveLoad.log:logging(Logger.WARNING,"data didn't have the x y and z values inside!");
	return;
  end
  local coordTable = _loadCoordTable(datasource,value.x,value.y,value.z);
  coordTable = S2T.stringToTable(coordTable);
  if variableName then
    coordTable[variableName] = S2T.tableToString(value);
  else
    table.insert(coordTable,S2T.tableToString(value));
  end
  _savePlainData(datasource,value.x .. "**" .. value.y .. "**" .. value.z,coordTable);
end

_savePlainData = function(datasource, variableName,value)
  if type(value) == "table" then
    value = S2T.tableToString(value);
  end
  datasource[variableName] = value;
end


-- need to verify that getCore()getModData() is the right way to get the lua data object for a world object
-- if coord is nil (or not given with the invocation call it will be thought that the variableName is a table containing a x,y,z,name dictionary value.)
-- THER WILL ALWAYS BE AN X,Y,Z INSIDE THE SAVED TABLE!! (if you use Coord data it's expected that your data, even a single value is saved inside a table.)
saveWorldData = function(player, CoordOrPlainData, variableName, value,coord)
  local x,y,z,name;
  if not coord then
    if type(variableName) == "table" then
	  x = variableName.x;
	  y = variableName.y;
	  z = variableName.z;
	  name = variableName.name;
	else
	  SaveLoad.log:logging(Logger.WARNING,"because coord was nil it was expect that the variableName was a table containing: {name='name',x=#,y=#,z=#}");
	end
  else
    x = coord.x;
	y = coord.y;
	z = coord.z;
	name = variableName;
  end

  if worldOrPlainData == "world" or worldOrPlainData == SaveLoad.COORD then
    table.insert(value,"x",x);
    table.insert(value,"y",y);
    table.insert(value,"z",z);
    _saveCoordData(GameTime:getInstance():getModData(),variableName,value);
  elseif worldOrPlainData == "plain" or worldOrPlainData == SaveLoad.PLAIN then
    _savePlainData(GameTime:getInstance():getModData(),variableName,value);
  else
    SaveLoad.log:logging(Logger.WARNING,"the parameter CoordOrPlain should have ether 'world' or 'plain' \n optionally you can use SaveLoad.PLAIN or SaveLoad.WORLD");
  end
end

_loadCoordTable = function(datasource,x,y,z)
  return _loadPlainData(datasource, x .. "**" .. y .. "**" .. z);
end

_loadPlainData = function(datasource,variableName)
  local tempData = datasource[variableName]; -- get the data
  -- see if this is a string. if so, try to un-serialize.
  tempData = S2T.stringToTable(tempData);
  return tempData;
end

return SaveLoad;
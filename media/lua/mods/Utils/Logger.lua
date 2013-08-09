require "ISBaseObject";

Logger = ISBaseObject:derive("Logger");
-- add some defaults you can use.
Logger.ALL = 0;
Logger.FINER = 1;
Logger.DEBUG = 2;
Logger.FINE = 2;
Logger.INFO = 3;
Logger.SEVERE = 4;
Logger.logmessageFormat = {};
Logger.logmessageFormat.noParent = "(%s) %s %s"; -- (loglevel) [logname] logmessage
--Logger.logmessageFormat.parents = "%s[%s]"; -- (loglevel) logparents(multiple possible) [logname] logmessage


function Logger:getName()
  return self.name;
end
function Logger:getParentLoggerNames()
  if self.parent then
	local parents = self.parent:getParentLoggerNames();
	table.insert(parents,1,self.parent:getName());
	return parents;
  else
    return {};
  end
end

function Logger:logging(loglevel,text)
  local loglvl = "unknown";
  if loglevel >= Logger.ALL then
    loglvl = "ALL";
  elseif loglevel >= Logger.FINER then
    loglvl = "FINER";
  elseif loglevel >= Logger.DEBUG then
    loglvl = "DEBUG";
  elseif loglevel >= Logger.FINE then
    loglvl = "FINE";
  elseif loglevel >= Logger.INFO then
    loglvl = "INFO";
  elseif loglevel >= Logger.SEVERE then
    loglvl = "SEVERE";
  else
    loglvl = "unknown";
  end
    local lognames = self:getParentLoggerNames();
	table.insert(lognames,1,self:getName());
    local logstring = "";
	if #lognames>1 then
	  print("has more tan 1 name, probably you have a parent");
	  print("amount of lognames: " .. #lognames);
	  for i=1,#lognames,1 do
	    logstring = string.format("[%s]%s",lognames[i],logstring);
	  end
	else
	  print("no parent so I create a normal one name name string");
	  logstring = "["..lognames[1].."]";
	end
	print("and now the full stringformat");
	if not text then text="WHY O WHY IS THIS EMPTY?"; end
	print("("..loglvl..")".. logstring .. text);
end

function Logger:info(logtext)
  Logger:logging(Logger.INFO,logtext);
end

function Logger:debug(logtext)
  self:logging(Logger.DEBUG,logtext);
end

function Logger:info(logtext)
  self:logging(Logger.INFO);
end

function Logger:getGlobalLogger()
  if Logger.globalLogger == nil then
    Logger.globalLogger = Logger:newWithName("lua");
  end
  return Logger.globalLogger;
end

function Logger:newWithName(name)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o.name = name;
  return o
end

function Logger:newWithNameAndParent(name,parent)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o.name = name;
  o.parent = parent;
  return o
end

function Logger:new (logname,parentLogger)
  if logname and parentLogger then
    return self:newWithNameAndParent(logname,parentLogger);
  elseif logname then
    parentLogger = Logger:getGlobalLogger();
    return self:newWithNameAndParent(logname,parentLogger);
  end
end


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
Logger.logmessageFormat.parents = "%s[%s]"; -- (loglevel) logparents(multiple possible) [logname] logmessage

function Logger:getParentLoggerNames()
  if self.parent then
	local parents = self.parent:getParentLoggerNames();
	table.insert(parents,1,self.parent.getName());
	return parents;
  else
    return {};
  end
end

function Logger:log(loglevel,logtext)
  local loglvl = nil;
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
	  for i=1,#lognames,1 do
	    logstring = string.format(self.loggmessageFormat.parents,logstring,lognames[i]);
	  end
	else
	  logstring = string.format("[%s]",lognames[1]);
	end
	print(string.format(self.logmessageFormat.noParent,loglvl,lognames[1],logtext));
end

function Logger:info(logtext)
  self:log(Logger.INFO,logtext);
end

function Logger:debug(logtext)
  self:log(Logger.DEBUG,logtext);
end

function Logger:info(logtext)
  self:log(Logger.INFO);
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
    return self:newWithName(logname);
  end
end


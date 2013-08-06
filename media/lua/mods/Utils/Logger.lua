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
Logger.logmessageFormat.noParrent = "(%s) [%s] %s"; -- (loglevel) [logname] logmessage
Logger.logmessageFormat.parrents = "%s[%s]"; -- (loglevel) logparents(multiple possible) [logname] logmessage



function Logger:getParentLogger()
  if self.parent then
	local parents = self.parent:getParentLogger();
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
    local lognames = self:getParentLogger();
	table.insert(lognames,1,self:getName());
    if #lognames>1 then
	  
	else
	
	end
end

function Logger:info(logtext)
  self:log(Logger.INFO,logtext)
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
    return self:newWithName(logname);
  elseif logname then
    return self:newWithName(logname);
  end
end

globalLogger = Logger:new("lua"); -- your global logger.
--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

TakePillAction = ISBaseTimedAction:derive("TakePillAction");

function TakePillAction:isValid()
	return self.character:getInventory():contains(self.item);
end

function TakePillAction:update()
	self.item:setJobDelta(self:getJobDelta());
end

function TakePillAction:start()
	self.item:setJobType("Take a pill");
	self.item:setJobDelta(0.0);
end

function TakePillAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);

end

function TakePillAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
	--self.character:getBodyDamage():JustTookPill(self.item);
    -- needed to remove from queue / start next.
	--self.item:setCount(self.item:getCount() + 1);
	print("and now we call the logic behind the action..");
	self.onPreform(self.character,sefl.item);
	ISBaseTimedAction.perform(self);
end

function TakePillAction:new (character, item,onPreform, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.onPreform = onPreform;
	o.stopOnWalk = false;
	o.stopOnRun = false;
	o.maxTime = time;
	return o
end

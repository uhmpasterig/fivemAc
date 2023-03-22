----------------------------------------------

Detections = {};
Detection = {};
Detection.__index = Detection;

function Detection:CreateNew(info, routine)
  local self = setmetatable({}, Detection);
  self.name = info.name;
  self.info = info;
  self.routine = routine;
  Detections[self.name] = {
    info = self.info,
    refresh = self.Refresh(),
    delete = self.Delete()
  }
  return self;
end

function Detection:RunSync()
  self.routine();
  return
end

function Detection:RunAsync()
  self.routine();
end

function Detection:AddToLoop()
  addDetectionToLoop(self.routine, self.info.loop);
end

function Detection:Delete()
  removeDetectionFromLoop(self.routine, self.info.loop);
end

function Detection:Refresh()
  self:Delete();
  -- COnfig Refresh einbauen TODO
  self:AddToLoop();
end

----------------------------------------------
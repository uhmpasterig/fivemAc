----------------------------------------------

LoopType  = {
  SLOW = 1,
  MEDIUM = 2,
  FAST = 3
}

local loopedDetections = {
  SLOW = {
    time = 5,
    detections = {}
  },
  MEDIUM = {
    time = 2.5,
    detections = {}
  },
  FAST = {
    time = 0.5,
    detections = {}
  }
};

local function slowLoop()
  for _, detection in pairs(loopedDetections.slow.detections) do
    detection(playerInfo.ped, playerInfo.playerId);
    Wait((loopedDetections.slow.time * 1000)/#loopedDetections.slow.detections);
  end
end

local function normalLoop()
  for _, detection in pairs(loopedDetections.normal.detections) do
    detection(playerInfo.ped, playerInfo.playerId);
    Wait((loopedDetections.normal.time * 1000)/#loopedDetections.normal.detections);
  end
end

local function fastLoop()
  for _, detection in pairs(loopedDetections.fast.detections) do
    detection(playerInfo.ped, playerInfo.playerId);
    Wait((loopedDetections.fast.time * 1000)/#loopedDetections.fast.detections);
  end
end

-- TODO Geht das mit : oder muss . hin?
function startFunctions:startDetectionsloop()
  Citizen.CreateThread(slowLoop);
  Citizen.CreateThread(normalLoop);
  Citizen.CreateThread(fastLoop);
end

function addDetectionToLoop(detection, loop)
  table.insert(loopedDetections[loop].detections, detection);
end

function removeDetectionFromLoop(detection, loop)
  table.removeValue(loopedDetections[loop].detections, detection);
end

----------------------------------------------
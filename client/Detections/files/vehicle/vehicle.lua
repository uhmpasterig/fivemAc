local function detectionFunction(ped, playerId)
  print("In der Funktion halt nh");
end

local VehicleDetection = Detection:CreateNew({
  name = "DetectionName",
  loopType = LoopType.FAST
}, detectionFunction);

VehicleDetection:AddToLoop();
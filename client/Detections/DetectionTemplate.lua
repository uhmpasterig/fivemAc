local function detectionFunction(ped, playerId)
  print("In der Funktion halt nh");
end

local Name = Detection:CreateNew({
  name = "DetectionName",
  loopType = LoopType.FAST
}, detectionFunction);

Name:AddToLoop();

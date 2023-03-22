Start = {}
start.__index = start
RegisterNetEvent("zero:config:refresh", function(config)
  config = config
end)
--s
function Start:FetchConfig()
  local config = {}
  Callback:Trigger("zero:config:fetch", function(cfg)
    config = cfg 
  end)
  if config == {} then 
    Wait(1000)
    local config = Start:fetchConfig()
  end
  return config
end

function Start:Functions()
  for _, func in pairs(startFunctions) do 
    func()
  end
end

function Start:init()
  local self = setmetatable({}, start)
  self.config = self.FetchConfig()
  
  self.Functions(self.config)

  player.loaded = true

  print("Init complete")
end

RegisterNetEvent("zero:player:spawn", function(pinfo)
  if not player.loaded then 
    Player:New(pinfo)
    Start:init()
  end
end)
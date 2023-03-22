Start = {}
config = {}
Start.__index = Start

function Start:fetchConfig()
  local cfg = {}
  local file = io.open("config.json", "r")

  if not file then return "Error: config.json not found" end
  local contents = file:read("*a")
  if not contents then return "Error: config.json is empty" end
  io.close(file)
  cfg = json.decode(contents)
  if not cfg then return "Error: config.json is not valid JSON" end
  
  Callback:Register("zero:config:fetch", function()
    return {
      cfg
    }
  end)

  print("Config loaded")
  return cfg 
end

function Start:functions()
  for _, func in startFunctions do 
    func()
  end
  print("All functions loaded")
end

function Start:webServer()
  initWeb()
  print("Webserver started")
end

function Start:playerStart()
  for _, p in pairs(players) do 
    p:load(p)
  end
  AddEventHandler(config.start.startClient, function()
    p:load(p)
  end)
end

function Start:init()
  local self = setmetatable({}, Start)
  self.config = self.fetchConfig()
  
  config = self.config

  perms = Perms:LoadPerms()

  self.webServer()

  self.functions(self.config)

  self.playerStart()

  print("Init complete")
end

start:init()
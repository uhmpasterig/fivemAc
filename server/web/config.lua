function getConfig()
  local cfg = {}
  PerformHttpRequest("https://raw.githubusercontent.com/ESX-Org/es_extended/master/config.lua", function(err, text, headers)
    -- TODO WEBSERVER
    if err == 200 then
      local f = load(text)
      setfenv(f, cfg)
      f()
    else
      print("Error loading config.lua")
    end
  end)
end
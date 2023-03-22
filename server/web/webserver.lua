HttpHandler = {}
HttpHandler.__index = HttpHandler

function HttpHandler:HandleHttp(req, res)

end

function HttpHandler:SetConfig(req, res)
  local config = json.decode(req.body.whatever)
  if config then 
    TriggerClientEvent("zero:config:refresh", -1, config)
    res.send("Config updated")
  else 
    res.send("Error: Invalid JSON")
  end
end

function HttpHandler:RefreshTeam(req, res)
  local t3am = json.decode(req.body.whatever)
  if t3am then
    Team:Refresh(t3am)
    res.send("Team updated")
  else 
    res.send("Error: Invalid JSON")
  end
end


function initWeb()
  SetHttpHandler(HttpHandler:HandleHttp)
  print("HttpHandler set")

  PerformHttpRequest("https://myacreg/zero/registerserver", function(err, text, headers)
    print("Webserver started")
  end, "GET")
  print("Server registered")
end
--[[ team = {}
Perms = {}

function Perms:LoadPerms()
  local file = io.open("team.json", "r")
  if not file then return "Error: team.json not found" end
  local contents = file:read("*a")
  if not contents then return "Error: team.json is empty" end
  io.close(file)
  t3am = json.decode(contents)
  if not t3am then return "Error: team.json is not valid JSON" end
  print("Team loaded")
  return t3am
end

function Perms:Refresh(t3am)
  team = t3am
  for _, player in pairs(GetPlayers()) do 
    local identifier = getLicense(player)
    local group = team.admins[identifier]
    if not group then group = "user" end
    local perms = team.perms[group]
    if not perms then perms = {} end
    TriggerClientEvent("zero:team:refresh", player, group, perms)
  end
end

function Perms:LoadForPlayer(p)
  local identifier = getLicense(p)
  local group = team.admins[identifier]
  if not group then group = "user" end
  local perms = team.perms[group]
  if not perms then perms = {} end
  return {
    group = group,
    perms = perms
  }
end

function Perms:Check(id, reason)
  local identifier = getLicense(id)
  local group = team.admins[identifier]
  if not group then group = "user" end
  local perms = team.perms[group]
  if not perms then perms = {} end
  if table.contains(perms.perms, reason) then 
    return false  
  end
  return true
end

function startFunctions:LoadPerms()
  team = Perms:LoadPerms()
  Perms:Refresh(team)
end ]]

Perms = {}
perms = {}

function Perms:LoadPerms()
  local file = io.open("perms.json", "r")
  if not file then return "Error: perms.json not found" end
  local contents = file:read("*a")
  if not contents then return "Error: perms.json is empty" end
  io.close(file)
  perms = json.decode(contents)
  if not perms then return "Error: perms.json is not valid JSON" end
  print("Perms loaded")
  return perms
end

function Perms:Refresh(nP)
  perms = nP
end

function Perms:RefreshPlayer(id)
  local identifier = getLicense(id)
  local rank = perms.admins[identifier]
  if not rank then rank = "user" end
  local perms = perms.perms[rank]
  if not perms then perms = {} end
  return {
    rank = rank,
    perms = perms
  }
end

function Perms:Check(id, reason)
  local identifier = getLicense(id)
  local rank = team.admins[identifier]
  if not rank then rank = "user" end
  local perms = team.perms[rank]
  if not perms then perms = {} end
  if table.contains(perms.perms, reason) then 
    return false  
  end
  return true
end
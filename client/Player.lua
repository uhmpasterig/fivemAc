player = {
  loaded = false
}
Player = {}
Player.__index = Player

local reasons = {
  noclip = "Player tried to noclip"
}

function Player:New(pinfo)
  self = setmetatable({}, Player)
  player = {
    id = pinfo.id,
    name = pinfo.name,
    perms = pinfo.perms,
    rank = pinfo.rank,
    identifier = pinfo.identifier,
    loaded = false 
  }
  return 
end

function Player:CheckForPerms(perm)
  if table.contains(player.perms, perm) then 
    return true
  end
  return false
end

function Player:Ban(perm)
  local reason = reasons[perm]
  if self.CheckForPerms(perm) then return end
end
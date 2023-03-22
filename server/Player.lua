Player = {}
Player.__index = Player
players = {}

function Player:New(id)
  local self = setmetatable({}, Player)
  self.id = id
  self.name = GetPlayerName(id)
  self.perms = {}
  self.loaded = false
  self.perms = {}
  self.rank = {}
  self.identifier = getLicense(id)
end

function Player:Delete()
  players[self.__index] = nil
  self = nil
end

function Player:Load()
  local perms = Perms:LoadForPlayer(self.id)
  self.perms = perms
  if self.loaded then return end
  self.loaded = true
  TriggerClientEvent("zero:player:spawn", self.id, perms)
end

function Player:RefreshPerms()
  local PlayerPerms = Perms:RefreshPlayer(self.id)
  self.perms = PlayerPerms.Perms
  self.rank = PlayerPerms.Rank
  TriggerClientEvent("zero:player:refresh", self.id, PlayerPerms)
end

function Player:CheckForPerms(perm)
  if table.contains(self.perms, perm) then 
    return true
  end
  return false
end

function Player:Ban(reason, perm)
  if self.CheckForPerms(reason, perm) then return end
  print("Banned " .. self.name .. " for " .. reason)
  Ban:Ban(self.id, reason)
end

function Player:Kick(reason, perm)
  if self.CheckForPerms(reason, perm) then return end
  print("Kicked " .. self.id .. " for " .. reason)
  Ban:Kick(self.id, reason)
end
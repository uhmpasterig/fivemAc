Ban = {}

RegisterNetEvent("zero:ban:ban", function(reason)
  Ban:BanPlayer(source, reason)
end)

function Ban:BanPlayer(id, reason)
  if not Perms:Check(id, reason) then return end
  -- Bansystem
end
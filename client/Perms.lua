Perms = {}

RegisterNetEvent("zero:team:refresh", function(rank, perms)
  player.rank = rank
  player.perms = perms
end)
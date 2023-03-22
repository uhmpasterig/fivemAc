Ban = {}

function Ban:BanPlayer(reason)
  if not Perms:Check(reason) then return end
  TriggerServerEvent("zero:ban:ban", reason)
end
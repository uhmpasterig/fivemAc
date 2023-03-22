-- TODO
function getPlayerByIdentifier(identifier)
  for _, player in ipairs(GetPlayers()) do
    local playerIdentifiers = GetPlayerIdentifiers(player)
    for _, playerIdentifier in ipairs(playerIdentifiers) do
      if playerIdentifier == identifier then
        return player
      end
    end
  end
end

function getLicense(id)
  for _,k in pairs(GetPlayerIdentifiers(id)) do
    if string.find(k,"license:") then
      return k
    end
  end
end

function GetDistanceBetweenCoords(x1,y1,z1,x2,y2,z2)
  return math.sqrt((x2-x1)^2+(y2-y1)^2+(z2-z1)^2)
end
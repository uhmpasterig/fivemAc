AddEventHandler("playerDropped", function(reason)
  if players[source] then 
    players[source]:Delete()
  else 
    print("TODO weirder bug error")
  end
end)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
  deferrals.defer()
  deferrals.update("Loading. (Checking for Bans)")
  Wait(1000)

  --------------------------------
  -- Check if the player is banned
  if Ban:CheckIfBanned(source) then 
    deferrals.done("You are banned from this server.")
    return
  end

  --------------------------------

  deferrals.update("Loading.. (Checking Player)")
  Wait(1000)

  --------------------------------
  -- Check if the Identifier is already on the Server
  local license = getLicense(id)
  for _, p in pairs(players) do 
    if p.identifier == license then 
      deferrals.done("You are already connected to the server")
      return

    end
  end
  --------------------------------
  
  deferrals.update("Loading... (Checking ur mom)")
  Wait(1000)
  deferrals.done()

  players[source] = Player:New(source)
end)
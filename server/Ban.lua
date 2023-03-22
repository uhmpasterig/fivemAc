bans = {}
Ban = {}

function Ban:CheckIfBanned(id)
  return false
end

function Ban:Ban(id, reason)
  Ban:Log(content)
  print("Banned " .. id .. " for " .. reason)
end

function Ban:Unban(id)
  Ban:Log(content)
  print("Unbanned " .. id)
end

function Ban:Kick(id, reason)
  Ban:Log(content)
  print("Kicked " .. id .. " for " .. reason)
end

function Ban:Log(content)
  print("Logged")
end
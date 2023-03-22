Zero = {}
Zero.__index = Zero

-- Events --

function Zero:RegisterEvent(name, routine)
  EventController:Register(name, routine)
end

function Zero:AddEventHandler(name, routine)
  EventController:Listen(name, routine)
end

function Zero:TriggerEvent(name, ...)
  EventController:TriggerEvent(eventName, json.encode({...}), true);
end

function Zero:TriggerServerEvent(name, ...)
  EventController:TriggerEvent(eventName, json.encode({...}), false);
end

function Zero:TriggerClientEvent(name, id, ...)
  EventController:TriggerEvent(eventName, id, json.encode({...}), false);
end

function Zero:RegisterServerCallback(name, routine)
  Callback:Register(name, routine)
end

function Zero:TriggerServerCallback(name, cb, ...)
  Callback:Trigger(name, cb, ...)
end

-- Functions --

function Zero:AddMoney(ammount, account)
  if account == nil then 
    if Framework == "esx" then
      account = "money"
    else
      account = "cash"
    end
  end
  if Framework == "esx" then

  else
  end
end
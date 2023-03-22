Vehicle = {}
Vehicle.__index = Vehicle

local modifications = {
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  23
}

local wheels = {
  0,1,2,3,4,5
}

local windows = {
  1,2,3,4,5,6,7
}

local function getVehicleVectors(X, Y, Z)
  local positions = {
    vector3(-X, Y,  0.0),
    vector3(-X, Y,  Z),
    vector3(0.0, Y,  0.0),
    vector3(0.0, Y,  Z),
    vector3(X, Y,  0.0),
    vector3(X, Y,  Z),
    vector3(-X, Y * 0.5,  0.0),
    vector3(-X, Y * 0.5,  Z),
    vector3(0.0, Y * 0.5,  0.0),
    vector3(0.0, Y * 0.5,  Z),
    vector3(X, Y * 0.5,  0.0),
    vector3(X, Y * 0.5,  Z),
    vector3(-X, 0.0,  0.0),
    vector3(-X, 0.0,  Z),
    vector3(0.0, 0.0,  0.0),
    vector3(0.0, 0.0,  Z),
    vector3(X, 0.0,  0.0),
    vector3(X, 0.0,  Z),
    vector3(-X, -Y * 0.5,  0.0),
    vector3(-X, -Y * 0.5,  Z),
    vector3(0.0, -Y * 0.5,  0.0),
    vector3(0.0, -Y * 0.5,  Z),
    vector3(X, -Y * 0.5,  0.0),
    vector3(X, -Y * 0.5,  Z),
    vector3(-X, -Y,  0.0),
    vector3(-X, -Y,  Z),
    vector3(0.0, -Y,  0.0),
    vector3(0.0, -Y,  Z),
    vector3(X, -Y,  0.0),
    vector3(X, -Y,  Z),
  }
  return positions
end

function Vehicle:CreateNew(vehicle)
  local self = setmetatable({}, Vehicle)
  self.vehicle = vehicle

  self.props = {
    mods = {},
    tires = {},
    windows = {},
    colour = {
      primary = {},
      secondary = {}
    },
    damage = {},
    driver = false
    plate = "",
    model = ""
  }
end


--------------------------------------------------
-------------------Get Functions------------------
--------------------------------------------------

function Vehicle:GetTireInfo()
  local tireInfo = 0
  for _, v in pairs(wheels) do 
    if IsVehicleTyreBurst(self.vehicle, v, false) then
      tireInfo = tireInfo + 1
    end
  end
  return tireInfo
end

function Vehicle:GetWindowInfo()
  local windowInfo = 0
  for _,v in pairs(windows) do
    if not IsVehicleWindowIntact(self.vehicle, v) then
      windowInfo = windowInfo + 1   
    end
  end
  return windowInfo
end

function Vehicle:GetPlate() 
  local plate = GetVehicleNumberPlateText(self.vehicle)
  return plate
end

function Vehicle:GetSeat()
  local driver = false
  local ped = PlayerPedId()
  local seat = GetPedInVehicleSeat(self.vehicle, -1)
  if seat == ped then
    driver = true
  else 
    driver = false
  end
  return driver
end

function Vehicle:GetModifications()
  local mods = {}
  for _, v in pairs(modifications) do 
    mods[v] = GetVehicleMod(self.vehicle, v)
  end
  return mods
end

function Vehicle:GetColour()
  local colour = {
    primary = {},
    secondary = {}
  }
  colour.primary.r, colour.primary.g, colour.primary.b = GetVehicleCustomPrimaryColour(self.vehicle)
  colour.secondary.r, colour.secondary.g, colour.secondary.b = GetVehicleCustomSecondaryColour(self.vehicle)
  return colour
end

function Vehicle:GetDamage()
  local ddt = 0.05
  local min, max = GetModelDimensions(GetEntityModel(vehicle))
  local X = (max.x - min.x) * 0.5
  local Y = (max.y - min.y) * 0.5
  local Z = (max.z - min.z) * 0.5
  local positions = getVehicleVectors(X, Y, Z)
  local dp = 0
  for i, pos in ipairs(positions) do
    local dmg = #(GetVehicleDeformationAtPos(vehicle, pos))
    if (dmg > ddt) then
      dp = dp + 1
    end
  end
  return dp
end

--------------------------------------------------
-----------------Check Functions------------------
--------------------------------------------------

function Vehicle:CheckWindowProps()
  local windowInfo = self:GetWindowInfo()
  if windowInfo < self.props.windows then
    return true 
  end
  return false
end

function Vehicle:CheckTireProps()
  local tireInfo = self:GetTireInfo()
  if tireInfo < self.props.tires then
    return true 
  end
  return false
end

function Vehicle:CheckModifications()
  local mods = self:GetModifications()
  for k, v in pairs(modifications) do
    if mods[v] ~= self.props.mods[v] then
      return true
    end
  end
  return false
end

function Vehicle:CheckColour()
  local colour = self:GetColour()
  if table.compare(colour.primary, self.colour.primary) then
    return true
  end
  if table.compare(colour.secondary, self.colour.secondary) then
    return true
  end
  return false
end

function Vehicle:CheckDamage()
  local damage = self:GetDamage()
  if damage < self.props.damage then
    return true
  end
  return false
end

function Vehicle:CheckPlate()
  local plate = self:GetPlate()
  if plate ~= self.props.plate then
    return true
  end
  return false
end

--------------------------------------------------
-------------------Set Functions------------------
--------------------------------------------------

function Vehicle:SetWindowProps(spec)
  if spec then 
    self.props.windows = spec
  else
    self.props.windows = self:GetWindowInfo()
  end
end

function Vehicle:SetTirreProps(spec)
  if spec then 
    self.props.tires = spec
  else
    self.props.tires = self:GetTireInfo()
  end
end

function Vehicle:SetColour(spec)
  if spec then 
    self.props.colour = spec
  else
    self.props.colour = self:GetColour()
  end
end

--------------------------------------------------
--------------------- Functions-------------------
--------------------------------------------------

function Vehicle:RestoreProps(props)
  for _, v in pairs(props.mods) do 
    SetVehicleMod(self.vehicle, _, v, false)
  end
  
  local colour = props.colour
  SetVehicleCustomPrimaryColour(self.vehicle, colour.primary.r, colour.primary.g, colour.primary.b)
  SetVehicleCustomSecondaryColour(self.vehicle, colour.secondary.r, colour.secondary.g, colour.secondary.b)
  
  local tire = props.tires
  for _, v in pairs(tire) do 
    SetVehicleTyreBurst(self.vehicle, v, true, 1000)
  end

  local windows = props.windows
  for _, v in pairs(windows) do 
    SmashVehicleWindow(self.vehicle, v)
  end

  SetVehicleNumberPlateText(self.vehicle, props.plate)
end

function Vehicle:CompareProps()
  if self:CheckModifications() then
    return true
  end
  if self:CheckColour() then
    return true
  end
  if self:CheckDamage() then
    return true
  end
  if self:CheckPlate() then
    return true
  end
  if self:CheckTireProps() then
    return true
  end
  if self:CheckWindowProps() then
    return true
  end
  return false
end

function Vehicle:GetProps()
  self.props.mods = self:GetModifications()
  self.props.tires = self:GetTireInfo()
  self.props.windows = self:GetWindowInfo()
  self.props.colour = self:GetColour()
  self.props.damage = self:GetDamage()
  self.props.driver = self:GetSeat()
  self.props.plate = self:GetPlate()
  
  return self.props
end
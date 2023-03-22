----------------------------------------------

function string.encrypt(str, key)
  local result = ""
  local keyIndex = 1
  local keyLength = string.len(key)
  for i = 1, string.len(str) do
    local char = string.sub(str, i, i)
    local keyChar = string.sub(key, keyIndex, keyIndex)
    local charCode = string.byte(char)
    local keyCode = string.byte(keyChar)
    local newCharCode = charCode + keyCode
    if newCharCode > 255 then
      newCharCode = newCharCode - 255
    end
    result = result .. string.char(newCharCode)
    keyIndex = keyIndex + 1
    if keyIndex > keyLength then
      keyIndex = 1
    end
  end
  return result
end

function string.decrypt(str, key)
  local result = ""
  local keyIndex = 1
  local keyLength = string.len(key)
  for i = 1, string.len(str) do
    local char = string.sub(str, i, i)
    local keyChar = string.sub(key, keyIndex, keyIndex)
    local charCode = string.byte(char)
    local keyCode = string.byte(keyChar)
    local newCharCode = charCode - keyCode
    if newCharCode < 0 then
      newCharCode = newCharCode + 255
    end
    result = result .. string.char(newCharCode)
    keyIndex = keyIndex + 1
    if keyIndex > keyLength then
      keyIndex = 1
    end
  end
  return result
end

----------------------------------------------
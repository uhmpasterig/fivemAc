----------------------------------------------

function table.remove(table, index)
  table[index] = nil;

  for i = index, #table do
    table[i] = table[i - 1];
  end
  print("Table Remove")
  print(json.encode(table))
  return table;
end

function table.insert(table, value)
  table[#table + 1] = value;
  return table;
end

function table.removeValue(table, value)
  for i = 1, #table do
    if table[i] == value then
      table = table.remove(table, i);
      break;
    end
  end
  return table;
end

function table.findIndex(table, value)
  if table[value] ~= nil then
    return true;
  end
  return false;
end

function table.getIndexes(table)
  local ind = {};
  for k, v in pairs(table) do 
    ind[#ind + 1] = k;
  end
  return ind;
end

function table.compare(t1, t2)
  if #t1 ~= #t2 then
    return false;
  end

  for k, v in pairs(t1) do 
    if t2[k] ~= v then
      return false;
    end
  end

  return true;
end

function table.contains(table, value)
  for k, v in pairs(table) do 
    if v == value then
      return true;
    end
  end
  return false;
end

----------------------------------------------
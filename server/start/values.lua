startFunctions = {}

debugPrint = true
_print = print
print = function(...)
  if debugPrint then 
    _print(...)
  end
end
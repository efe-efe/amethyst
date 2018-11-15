function DebugPrint(...)
    local spew = Convars:GetInt('barebones_spew') or -1
    if spew == -1 and DOTARITE_DEBUG_SPEW then
      spew = 1
    end
  
    if spew == 1 then
      print(...)
    end
end
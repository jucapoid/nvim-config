--- After Pint (PSR-12): turn empty function bodies from
---   signature\n    {\n    }\n  into  signature\n    {}\n
local M = {}

---@param lines string[]
---@return string[]
function M.collapse(lines)
  local out = {}
  local i = 1
  while i <= #lines do
    local line = lines[i]
    local next_line = lines[i + 1]

    if line and next_line and line:match("{%s*$") and next_line:match("^%s*}%s*$") then
      local indent = line:match("^(%s*)") or ""
      local is_function = false

      for j = i - 1, math.max(1, i - 20), -1 do
        local prev = lines[j]
        if prev:match("%f[%w]function%f[%W]") then
          is_function = true
          break
        end
        if prev:match("%f[%w]class%f[%W]")
          or prev:match("%f[%w]interface%f[%W]")
          or prev:match("%f[%w]trait%f[%W]")
          or prev:match("%f[%w]enum%f[%W]")
        then
          break
        end
      end

      if is_function then
        table.insert(out, indent .. "{}")
        i = i + 2
      else
        table.insert(out, line)
        i = i + 1
      end
    else
      table.insert(out, line)
      i = i + 1
    end
  end

  return out
end

return M

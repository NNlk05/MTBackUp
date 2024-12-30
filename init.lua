-- Part of this file is from Luati Modding Book By rubenwardy, licensed under the Creative Commons Attribution Share Alike 4.0 International. See CC-SA4.0.txt (https://github.com/NNlk05/MTBackUp/blob/main/CC-SA4.0.txt) for the licence.

local store_api
store_api = dofile(core.get_modpath("mtbackup") .. "/backend_storage.lua")

function main()
  function lsdir(dir)
      local i, t, popen = 0, {}, io.popen
      local pfile = popen('ls -a "'..dir..'"')
      for filename in pfile:lines() do
          i = i + 1
          t[i] = filename
      end
      pfile:close()
      return t
  end
  -- Get all the files in a world dir.
  local file_list = lsdir(core.get_worldpath())
  local path_prefix = core.get_worldpath()

  -- Forms the full file path
  for i, file_name in ipairs(file_list) do
    file_list[i] = path_prefix .. file_name
  end

  -- get the backup data
  local backup_data = {}
  for _, file_name in ipairs(file_list) do
    local file = io.open(file_name, "r")
    if file then
        local file_data = file:read("*all")
        file:close()
        backup_data[file_name] = file_data
    else
        print("Error opening file: " .. file_name)
    end
  end

  -- backup the data
  for file_name, file_data in pairs(backup_data) do
    store_api.set(file_name, file_data)
  end
end

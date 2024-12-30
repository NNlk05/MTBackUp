-- This file is from Luati Modding Book By rubenwardy, licensed under the Creative Commons Attribution Share Alike 4.0 International. See [CC-SA4.0.txt](https://github.com/NNlk05/MTBackUp/blob/main/CC-SA4.0.txt) for the licence. 

local storage = core.get_mod_storage()
local mod_store_api = {}

function mod_store_api.set(key, value)
    storage:set_string(key, core.serialize(value))
end

function mod_store_api.get(key)
    return core.deserialize(storage:get_string(key))
end

return mod_store_api

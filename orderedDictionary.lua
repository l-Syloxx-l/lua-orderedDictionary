local orderedDictionary = {}

function orderedDictionary.insert(orderedDict, key, value)
    if orderedDict._keyValuePairs[key] == nil then
        orderedDict._orderedKeys[#orderedDict._orderedKeys + 1] = key
        orderedDict._keyPositionMap[key] = #orderedDict._orderedKeys
    end

    if value == nil then
        orderedDictionary.remove(orderedDict, key)
        return
    end

    orderedDict._keyValuePairs[key] = value
end

function orderedDictionary.remove(orderedDict, key)
    local value = orderedDict._keyValuePairs[key]

    if value ~= nil then
      local keyIndex = orderedDict._keyPositionMap[key]
      table.remove(orderedDict._orderedKeys, keyIndex)
      
      -- Update the key indices
      orderedDict._keyPositionMap[key] = nil
      for i = keyIndex, #orderedDict._orderedKeys do
        orderedDict._keyPositionMap[orderedDict._orderedKeys[i]] = i
      end

      orderedDict._keyValuePairs[key] = nil
    end
end

function orderedDictionary.pairs(orderedDict)
    local index = 0

    return function()
        index = index + 1
        local key = orderedDict._orderedKeys[index]
        if key ~= nil then
            return key, orderedDict._keyValuePairs[key]
        end
    end
end

function orderedDictionary.new(init)
    init = init or {}
    local orderedDictInstance = {_orderedKeys={}, _keyValuePairs={}, _keyPositionMap={}}

    for _, keyValuePair in ipairs(init) do
        local key = keyValuePair.key
        local value = keyValuePair.value

        if not key then
            error("Failed to create an ordered dictionary: The key of a key-value pair cannot be nil.")
        end

        if orderedDictInstance._keyValuePairs[key] ~= nil then
            error("Failed to create an ordered dictionary: The key '" .. tostring(key) .. "' is duplicated in the initial key-value pairs.")
        end

        orderedDictionary.insert(orderedDictInstance, key, value)
    end

    return setmetatable(orderedDictInstance, {
        __newindex = orderedDictionary.insert,
        __pairs = orderedDictionary.pairs,
        __index = orderedDictInstance._keyValuePairs,
        __len = function(dictionary) return #dictionary._orderedKeys end
    })
end

return orderedDictionary
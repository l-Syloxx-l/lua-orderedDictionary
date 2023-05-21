# Ordered Dictionary

This module implements an ordered dictionary in Lua. An ordered dictionary behaves like a regular dictionary, but also maintains the order of insertion of the keys. This makes it possible to iterate over the keys in the order they were added.

## Functions

### `orderedDictionary.new(init)`

Creates a new ordered dictionary.

__Arguments__

`init`: (optional) An array of initial key-value pairs. Each pair should be a table with `key` and `value` fields.

__Returns__

A new ordered dictionary.

__Errors__

If `init` contains a pair without a key, or if any key is duplicated, this function will raise an error.

__Example__

```lua
local orderedDict = orderedDictionary.new({
    {key = 'apple', value = 1},
    {key = 'banana', value = 2}
})
```

### `orderedDictionary.insert(orderedDict, key, value)`

Inserts a key-value pair into the dictionary. If the key already exists, it updates the value. If the value is nil, it removes the key.

__Arguments__

`orderedDict`: The ordered dictionary.

`key`: The key.

`value`: The value.

__Example__

```lua
orderedDict['cucumber'] = 3  -- Equivalent to orderedDictionary.insert(orderedDict, 'cucumber', 3)
```

### `orderedDictionary.remove(orderedDict, key)`

Removes a key-value pair from the dictionary.

__Arguments__

`orderedDict`: The ordered dictionary.

`key`: The key to remove.

__Example__

```lua
orderedDict['banana'] = nil  -- Equivalent to orderedDictionary.remove(orderedDict, 'banana')
```

### `orderedDictionary.pairs(orderedDict)`

Returns an iterator function that can be used to iterate over the dictionary in the order the keys were added.

__Arguments__

`orderedDict`: The ordered dictionary.

__Returns__

An iterator function.

__Example__

```lua
for key, value in pairs(orderedDict) do
    print(key, value)
end
```

### Other Operations

You can get the value for a key with `orderedDict[key]`, check if a key exists with `orderedDict[key] ~= nil`, and get the number of keys with `#orderedDict`.

__Example__

```lua
print(orderedDict['apple'])  -- Prints "1"
print(orderedDict['banana'] ~= nil)  -- Prints "true"
print(#orderedDict)  -- Prints "2"
```


NamedFunction = require "NamedFunction"
assertType = require "assertType"
has = require "has"

InjectableMap = NamedFunction "InjectableMap", (types) ->

  values = Object.create null

  has: (key) ->
    return has values, key

  get: (key, defaultValue) ->
    return values[key] if arguments.length is 1
    return values[key] if has values, key
    return values[key] = validate key, defaultValue, types

  inject: (key, newValue) ->
    return values[key] = validate key, newValue, types

module.exports = InjectableMap

validate = (key, value, types) ->
  types[key] and assertType value, types[key], key
  return value

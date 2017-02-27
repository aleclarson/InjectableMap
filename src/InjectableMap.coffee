
NamedFunction = require "NamedFunction"
assertType = require "assertType"
sliceArray = require "sliceArray"
setType = require "setType"
isDev = require "isDev"
bind = require "bind"

InjectableMap = NamedFunction "InjectableMap", (types) ->
  assertType types, Object
  injectable = {types, values: Object.create null}
  injectable.inject = bind.func inject, injectable
  return setType injectable, InjectableMap

InjectableMap.prototype =

  has: (key) ->
    @values[key] isnt undefined

  get: (key, defaultValue) ->
    if arguments.length > 1
    then @values[key] or @values[key] = validate key, defaultValue, @types
    else @values[key]

  call: (key) ->
    if @values[key] is undefined
      throw Error "Expected '#{key}' to exist!"
    return @values[key].apply null, sliceArray arguments, 1

module.exports = InjectableMap

#
# Helpers
#

inject = (key, newValue) ->
  if arguments.length > 1
  then @values[key] = validate key, newValue, @types
  else merge arguments[0], @values, @types

validate = (key, value, types) ->
  if types[key]
    assertType value, types[key], key
  if isDev and types[key] is undefined
    throw Error "Invalid key: '#{key}'"
  return value

merge = (newValues, values, types) ->
  for key, newValue of newValues
    values[key] = validate key, newValue, types
  return

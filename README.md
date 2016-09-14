
# InjectableMap v1.0.0

- Create the injectable map in `src/injectable.coffee`:

```coffee
InjectableMap = require "InjectableMap"

module.exports = InjectableMap {foo: Number, bar: String}
```

- Use the injected values in `src/index.coffee`:

```coffee
injected = require "./injectable"

if not injected.has "foo"
  throw Error "'my-module' expects an injected 'foo'!"

bar = injected.get "bar", "default value"
```

- Export the injector function in `inject.js`:

```js
module.exports = require('./js/injectable').inject;
```

- Import the injector function from other modules:

```coffee
inject = require "my-module/inject"

inject "foo", true # <= throws an error, 'foo' must be a number!

inject "foo", 100  # <= updates the injected value!
```

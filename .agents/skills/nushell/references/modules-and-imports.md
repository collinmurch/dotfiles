# Modules and Imports

```nu
# Define module

module my_module {
    export def public-func [] { ... }
    def private-func [] { ... }

    export const MY_CONST = 42
}

# Use module

use my_module *
use my_module [public-func MY_CONST]

# Import from file

use lib/helpers.nu *
```

use utils.nu [deep-merge]

# request.nu — a minimal, file-based API client
#
# Each request lives in its own directory with a simple convention:
#
#   my-project/
#     my-request/
#       request.nuon       # required — url, auth command, method
#       query.graphql       # optional — presence activates GraphQL mode
#       variables.json      # optional — GraphQL variables (or REST body context)
#       body.json           # optional — REST request body
#       response.json       # output   — written automatically, gitignored
#
# request.nuon is a nushell record:
#
#   {
#     url: "https://api.example.com/graphql"
#     auth: "my_auth_token.sh"            # optional — must be in $PATH, returns a bearer token
#     method: POST                        # optional — REST only, defaults to GET
#   }
#
# GraphQL mode (query.graphql exists):
#   - POSTs { query, variables } as JSON
#   - variables.json is merged with any --vars overrides
#
# REST mode (no query.graphql):
#   - Uses config.method (GET, POST, PUT, PATCH, DELETE)
#   - Sends body.json as the request body for POST/PUT/PATCH
#
# Usage:
#   use request.nu
#
#   request ./my-project/my-request
#   request ./my-project/my-request --vars {zip: "90210"}

# Run an API request from a request directory
export def main [
  dir: path       # Request directory containing request.nuon
  --vars: record  # Variable overrides (merged with variables.json)
] {
  let dir = $dir | path expand
  let config = open ($dir | path join request.nuon)

  let headers = if ($config.auth? | is-not-empty) {
    let token = ^($config.auth) | str trim
    [Authorization $"Bearer ($token)"]
  } else {
    []
  }

  let result = if ($dir | path join query.graphql | path exists) {
    let query = open ($dir | path join query.graphql) --raw
    let vars_file = $dir | path join variables.json
    let base_vars = if ($vars_file | path exists) { open $vars_file } else { {} }
    let merged = if $vars != null { $base_vars | deep-merge $vars } else { $base_vars }

    ({query: $query, variables: $merged}
    | to json
    | http post $config.url --content-type application/json --headers $headers)
  } else {
    let method = $config.method? | default GET
    let body_file = $dir | path join body.json

    match $method {
      "GET" => (http get $config.url --headers $headers)
      "POST" => (open $body_file --raw | http post $config.url --content-type application/json --headers $headers)
      "PUT" => (open $body_file --raw | http put $config.url --content-type application/json --headers $headers)
      "PATCH" => (open $body_file --raw | http patch $config.url --content-type application/json --headers $headers)
      "DELETE" => (http delete $config.url --headers $headers)
    }
  }

  $result | to json --indent 2 | save ($dir | path join response.json) --force
  $result
}

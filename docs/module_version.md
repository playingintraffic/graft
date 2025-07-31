# Version

Server-side utility to check if a resource is up to date with a GitHub-hosted version manifest.  
Includes semantic version comparison and support for optional update callbacks.

---

## Functions

### check

Checks the current resource version against the latest version defined in a GitHub JSON manifest.

#### Params

* `opts` (table): Configuration options:
  - `resource_name` (string, optional): The resource to check (defaults to current resource).
  - `url_path` (string): GitHub raw file path (e.g. `"username/repo/main/versions.json"`).
  - `callback` (function, optional): Callback function called with update result.

#### Returns

* `nil` (asynchronous HTTP request)

#### Callback Signature

```lua
function(success, current_version, latest_version, notes_or_error)
```

* `success` (boolean): True if up to date or newer, false if outdated or error.
* `current_version` (string): Version defined in `fxmanifest.lua`.
* `latest_version` (string): Version from GitHub.
* `notes_or_error` (string): Release notes or error message.

#### Example

```lua
version.check({
    url_path = "playingintraffic/fivem_resources/refs/heads/main/versions.json",
    callback = function(success, current, latest, notes)
        if not success then
            print("[Update Check] Update needed! Current: " .. current .. " → Latest: " .. latest)
            print(notes)
        end
    end
})
```

---

## Notes

* Requires the resource to define `version` in `fxmanifest.lua`.
* Uses `PerformHttpRequest` to pull a GitHub-hosted JSON file.
* JSON file must contain a structure like:
```json
{
  "resources": {
    "your_resource": {
      "version": "1.2.0",
      "notes": [
        "Improved syncing",
        "Fixed server-side error"
      ]
    }
  }
}
```
* Versions must follow semver (`MAJOR.MINOR.PATCH`) format.
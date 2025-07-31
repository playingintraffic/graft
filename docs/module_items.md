# Items

Standalone item registration system.
Used for manually defining usable item behavior in frameworks that lack native item use callbacks.
In frameworks that **do** support native item usage, the GRAFT bridge delegates functionality accordingly.

## Server Functions

### register_item

Registers an item ID as usable and assigns it a callback function.

#### Params

* `item_id` (string): The unique item ID.
* `use_function` (function): The function to call when the item is used, it will receive `(source, item_id)` as arguments.

#### Example

```lua
items.register_item("weed_joint", function(source, item_id)
    print(("Player %s used %s"):format(source, item_id))
end)
```

---

### use_item

Forcibly triggers a use event for a registered item.

#### Params

* `source` (number): The player using the item.
* `item_id` (string): The item ID to use.

#### Example

```lua
items.use_item(source, "weed_joint")
```
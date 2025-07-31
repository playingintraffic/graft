# Profanity

Basic profanity filtering and cleaning module with support for:
- leetspeak normalization (e.g., `sh1t` → `shit`)
- replacement or masking of filtered words. You should expand the `bad_words` and `replace_words` tables as needed.

---

## Functions

### has

Checks if a string contains any bad words, including leetspeak variants.

#### Params

* `input` (string): The string to check.

#### Returns

* `boolean`: True if profanity is detected.

#### Example

```lua
if profanity.has("F4g!") then
    print("Profanity detected")
end
````

---

### clean

Sanitizes a string by replacing or masking any profane words.

#### Params

* `input` (string): The string to sanitize.
* `use_mask` (boolean): If true, replaces words with asterisks (e.g., `****`). If false, uses replacement words from `replace_words` or defaults to asterisks.

#### Returns

* `string`: Cleaned/sanitized string.

#### Example

```lua
local safe_text = profanity.clean("You f4cking idiot", true) -- "You ******* idiot"
local friendly_text = profanity.clean("nigga please", false) -- "buddy please"
```

---

## Notes

* Leetspeak is auto-normalized before matching.
* `replace_words` allows custom substitutions per word.
* Matching uses whole word boundaries (`%f[%w]word%f[%W]`).
* Default replacements are masked with asterisks if no custom replacement exists.
---
--- This is a configuration file
---

---
--- Do not touch
---
_G["aque_config"] = _G["aque_config"] or {}
local config = _G["aque_config"]

---
--- Change Config settings here
---
---

--- Turn on/off mods
-- Aquellia's testing mod, this should probably be false for you
config["mod_enabled_test"] = false
-- Experimental Mod that edits mech upgrade values
config["mod_enabled_mech_upgrades"] = false
-- Experimental Mod that tries to edit loot database
config["mod_enabled_loot"] = false
-- Aquellia's Energy Improvements Mod
config["mod_enabled_energy_improvements"] = false
-- Aquellia's Better Bestiary System Mod
config["mod_enabled_better_bestiary"] = false
-- Mod requested by goof <183607591471939586>
config["mod_enabled_ore_boosted_synthesizers"] = true
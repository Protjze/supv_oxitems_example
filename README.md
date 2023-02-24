---
title: Only if you have supv_oxitemsd
description: This script is an example how to use some export from supv_oxitems
---

* This script need to be start after supv_oxitems and not before 

# Hancuff system (with serial)

- Add this in `ox_inventory/data/stash.lua`
```lua
	{
		coords = vec3(274.543762, -1428.116089, 29.575872), -- set your coords
		target = {
			loc = vec3(274.543762, -1428.116089, 29.575872), -- set your coords
			length = 0.6,
			width = 1.8,
			heading = 340,
			minZ = 29.0,
			maxZ = 29.74,
			label = 'Open stock handcuff'
		},
		name = 'stock_police_menotte', -- name of stash in config/server.lua from supv_oxitems_example for job you use
		label = 'Stock Handcuff',
		owner = false,
		slots = 30,
		weight = 100000,
		groups = {['police'] = 0}
	},
```
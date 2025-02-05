/obj/structure/table/standard
	icon_state = "plain_preview"
	color = COLOR_OFF_WHITE
	material = DEFAULT_TABLE_MATERIAL

/obj/structure/table/standard/flipped

/obj/structure/table/standard/flipped/Initialize()
	. = ..()
	flipped = 1
	update_icon()

/obj/structure/table/standard/flipped/north
	dir = 1

/obj/structure/table/standard/flipped/east
	dir = 4
/obj/structure/table/standard/flipped/west
	dir = 8

/obj/structure/table/steel
	icon_state = "plain_preview"
	color = COLOR_GRAY40
	material = MATERIAL_STEEL

/obj/structure/table/marble
	icon_state = "stone_preview"
	color = COLOR_GRAY80
	material = MATERIAL_MARBLE

/obj/structure/table/reinforced
	icon_state = "reinf_preview"
	color = COLOR_OFF_WHITE
	material = DEFAULT_TABLE_MATERIAL
	reinforced = MATERIAL_STEEL

/obj/structure/table/steel_reinforced
	icon_state = "reinf_preview"
	color = COLOR_GRAY40
	material = MATERIAL_STEEL
	reinforced = MATERIAL_STEEL

/obj/structure/table/darkwood_reinforced
	icon_state = "reinf_wood_preview"
	color = COLOR_DARK_BROWN_NEW
	material = "darkwood"
	reinforced = "darkwood"

/obj/structure/table/woodentable
	icon_state = "solid_preview"
	color = COLOR_BROWN_ORANGE
	material = MATERIAL_WOOD

/obj/structure/table/woodentable/flipped

/obj/structure/table/woodentable/flipped/Initialize()
	. = ..()
	flipped = 1
	update_icon()

/obj/structure/table/woodentable/flipped/north
	dir = 1

/obj/structure/table/woodentable/flipped/east
	dir = 4
/obj/structure/table/woodentable/flipped/west
	dir = 8
/obj/structure/table/gamblingtable
	icon_state = "gamble_preview"
	carpeted = 1
	material = MATERIAL_WOOD

/obj/structure/table/glass
	icon_state = "plain_preview"
	color = COLOR_DEEP_SKY_BLUE
	alpha = 77 // 0.3 * 255
	material = MATERIAL_GLASS

/obj/structure/table/glass/plass
	color = "#8f29a3"
	material = MATERIAL_PLASS

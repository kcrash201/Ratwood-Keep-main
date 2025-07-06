
/obj/structure/drape
	smooth = SMOOTH_FALSE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 100
	layer = CLOSED_TURF_LAYER
	opacity = 1
	abstract_type = /obj/structure/drape
	plane = GAME_PLANE_UPPER

/obj/structure/drape/desert
	name = "desert drape"
	desc = "Made from durable fabric."
	icon = 'icons/desert_town/drapes.dmi'
	icon_state = "desertdrape"

/obj/structure/drape/zybantine
	name = "zybantine drape"
	desc = "Made from prestigious fabric."
	icon = 'icons/desert_town/drapes.dmi'
	icon_state = "zybantinedrape1"

/obj/structure/drape/zybantine/Initialize()
	. = ..()
	icon_state = "zybantinedrape[rand(1, 2)]"

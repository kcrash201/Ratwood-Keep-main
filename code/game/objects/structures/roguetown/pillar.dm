/obj/structure/pillar
	name = "pillar"
	desc = ""
	icon = 'icons/desert_town/sandpillar.dmi'
	opacity = 0
	max_integrity = 1000
	density = TRUE
	blade_dulling = DULLING_BASH
	anchored = TRUE
	alpha = 255
	destroy_sound = 'sound/foley/smash_rock.ogg'
	attacked_sound = 'sound/foley/hit_rock.ogg'
	static_debris = list(/obj/item/natural/stone = 10)
	layer = 4.82
	pixel_x = -16
	plane = GAME_PLANE_UPPER

	abstract_type = /obj/structure/pillar

/obj/structure/pillar/sand1
	icon_state = "sandpillar1"

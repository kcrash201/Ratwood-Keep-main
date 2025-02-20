//Sand floors
/turf/open/floor/rogue/desertfloor
	name = "sand"
	desc = "Its course and rough, and it gets everywhere."
	icon = 'icons/turf/Deserttown.dmi'
	icon_state = "dunes"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/rogue, /turf/closed/mineral, /turf/closed/wall/mineral)
	slowdown = 0

/turf/open/floor/rogue/desertfloor/initialize()
	. = ..()
	dir = rand(0,8)


//Stone floors
//turf/open/floor/rogue/citybrick
//	icon_state = "0,2
//	footstep = FOOTSTEP_STONE
//	barefootstep = FOOTSTEP_HARD_BAREFOOT
//	clawfootstep = FOOTSTEP_HARD_CLAW
//	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
//	landsound = 'sound/foley/jumpland/stoneland.wav'
//	smooth = SMOOTH_TRUE
//	canSmoothWith = list(/turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)
//	max_integrity = 1200

//turf/open/floor/rogue/citybrick2
//	icon_state = "citybrick2"

///turf/open/floor/rogue/citybrick3
//	icon_state = "citybrick3"

///turf/open/floor/rogue/citybrick4
//	icon_state = "citybrick4"
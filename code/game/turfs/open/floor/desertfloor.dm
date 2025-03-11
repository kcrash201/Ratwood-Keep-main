//Sand floors
/turf/open/floor/rogue/dunes
	name = "sand"
	desc = "Its course and rough, and it gets everywhere."
	icon = 'icons/turf/Deserttown.dmi'
	icon_state = "dunes"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/rogue, /turf/closed/mineral, /turf/closed/wall/mineral)
	slowdown = 1
/turf/open/floor/rogue/dunes/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

	//

/turf/open/floor/rogue/lightpath
	icon_state = "light-path"
	icon = 'icons/turf/Deserttown.dmi'
	canSmoothWith = list(/turf/open/floor/rogue, /turf/closed/mineral, /turf/closed/wall/mineral)
	slowdown = 0
/turf/open/floor/rogue/lightpath/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)


//Stone floors
/turf/open/floor/rogue/citybrick
	icon_state = "city-brick"
	icon = 'icons/turf/Deserttown.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral/rogue, /turf/closed/mineral, /turf/closed/wall/mineral/rogue/stonebrick, /turf/closed/wall/mineral/rogue/wood, /turf/closed/wall/mineral/rogue/wooddark, /turf/closed/wall/mineral/rogue/stone, /turf/closed/wall/mineral/rogue/stone/moss, /turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)
	damage_deflection = 10
	max_integrity = 2800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
//turf/open/floor/rogue/citybrick/Initialize()
//	. = ..()
//	dir = pick(GLOB.cardinals)

/turf/open/floor/rogue/citybrick/citybrick1
	icon_state = "city-brick1"
/turf/open/floor/rogue/citybrick/citybrick2
	icon_state = "city-brick2"
/turf/open/floor/rogue/citybrick/citybrick3
	icon_state = "city-brick3"
/turf/open/floor/rogue/citybrick/citybrick4
	icon_state = "city-brick4"
/turf/open/floor/rogue/citybrick/citybrick5
	icon_state = "city-brick5"
/turf/open/floor/rogue/citybrick/citybrick6
	icon_state = "city-brick6"

//

/turf/open/floor/rogue/darkpath
	icon_state = "dark-path"
	icon = 'icons/turf/Deserttown.dmi'
//turf/open/floor/rogue/darkpath/Initialize()
//	. = ..()
//	dir = pick(GLOB.cardinals)


//

/turf/open/floor/rogue/sandbrick
	icon_state = "sand-brick"
	icon = 'icons/turf/Deserttown.dmi'
/turf/open/floor/rogue/sandbrick/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

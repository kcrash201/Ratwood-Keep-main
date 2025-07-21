/turf/open/floor/rogue/dunes
	name = "sand"
	desc = "Its course and rough, and it gets everywhere."
	icon = 'icons/desert_town/dune.dmi'
	icon_state = "dune1"
	footstep = FOOTSTEP_SAND
	//barefootstep = FOOTSTEP_SAND
	//clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/rogue, /turf/closed/mineral, /turf/closed/wall/mineral)
	slowdown = 1

/turf/open/floor/rogue/dunes/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/floor/rogue/dunes/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)
	icon_state = "dune[rand(1,16)]"

/turf/open/floor/rogue/sandbrick
	icon_state = "sand-brick1"
	icon = 'icons/desert_town/sandbrick_floor.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral/rogue, /turf/closed/mineral, /turf/closed/wall/mineral/rogue/stonebrick, /turf/closed/wall/mineral/rogue/wood, /turf/closed/wall/mineral/rogue/wooddark, /turf/closed/wall/mineral/rogue/stone, /turf/closed/wall/mineral/rogue/stone/moss, /turf/open/floor/rogue/cobble, /turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)
	damage_deflection = 10
	max_integrity = 1000
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')

/turf/open/floor/rogue/sandbrick/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/floor/rogue/sandbrick/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)
	icon_state = "sand-brick[rand(1,4)]"

/turf/open/floor/rogue/citybrick
	icon_state = "city-brick1"
	icon = 'icons/desert_town/city_brick.dmi'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral/rogue, /turf/closed/mineral, /turf/closed/wall/mineral/rogue/stonebrick, /turf/closed/wall/mineral/rogue/wood, /turf/closed/wall/mineral/rogue/wooddark, /turf/closed/wall/mineral/rogue/stone, /turf/closed/wall/mineral/rogue/stone/moss, /turf/open/floor/rogue/cobble, /turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)
	damage_deflection = 10
	max_integrity = 1000
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	abstract_type = /turf/open/floor/rogue/citybrick

/turf/open/floor/rogue/citybrick/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/rogue/citybrick/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/floor/rogue/citybrick/citybrick1
	icon_state = "city-brick1-1"

/turf/open/floor/rogue/citybrick/citybrick1/Initialize()
	. = ..()
	icon_state = "city-brick1-[rand(1,4)]"


/turf/open/floor/rogue/citybrick/citybrick2
	icon_state = "city-brick2-1"

/turf/open/floor/rogue/citybrick/citybrick2/Initialize()
	. = ..()
	icon_state = "city-brick2-[rand(1,5)]"


/turf/open/floor/rogue/citybrick/citybrick3
	icon_state = "city-brick3-1" //this only has one variant


/turf/open/floor/rogue/citybrick/citybrick4
	icon_state = "city-brick4-1"

/turf/open/floor/rogue/citybrick/citybrick4/Initialize()
	. = ..()
	icon_state = "city-brick4-[rand(1,2)]"

/turf/open/floor/rogue/citybrick/citybrick5
	icon_state = "city-brick5-1"

/turf/open/floor/rogue/citybrick/citybrick5/Initialize()
	. = ..()
	icon_state = "city-brick5-[rand(1,2)]"


/turf/open/floor/rogue/citybrick/citybrick6
	icon_state = "city-brick6-1"

/turf/open/floor/rogue/citybrick/citybrick6/Initialize()
	. = ..()
	icon_state = "city-brick6-[rand(1,2)]"


/turf/open/floor/rogue/lightpath
	icon_state = "light-path1"
	icon = 'icons/desert_town/light_path.dmi'
	canSmoothWith = list(/turf/open/floor/rogue, /turf/closed/mineral, /turf/closed/wall/mineral)
	slowdown = 0
	footstep = FOOTSTEP_SAND
	//barefootstep = FOOTSTEP_SAND
	//clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smooth = SMOOTH_TRUE

/turf/open/floor/rogue/lightpath/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/floor/rogue/lightpath/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)
	icon_state = "light-path[rand(1,8)]"


/turf/open/floor/rogue/darkpath
	icon_state = "dark-path1"
	icon = 'icons/desert_town/dark_path.dmi'
	canSmoothWith = list(/turf/open/floor/rogue, /turf/closed/mineral, /turf/closed/wall/mineral)
	slowdown = 0
	footstep = FOOTSTEP_SAND
	//barefootstep = FOOTSTEP_SAND
	//clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smooth = SMOOTH_TRUE

/turf/open/floor/rogue/darkpath/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/floor/rogue/darkpath/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)
	icon_state = "dark-path[rand(1,8)]"



/obj/effect/decal/desertgrassedge
	name = ""
	desc = ""
	icon = 'icons/desert_town/desertgrass.dmi'
	icon_state = "desertgrass_edges"
	mouse_opacity = 0


/turf/open/floor/rogue/desert_grass
	name = "desert grass"
	desc = "Grass, barely."
	icon = 'icons/desert_town/desertgrass.dmi'
	icon_state = "desertgrass1"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	smooth = SMOOTH_TRUE
	canSmoothWith = list(
						/turf/open/floor/rogue/grass,
						/turf/open/floor/rogue/dunes,
						/turf/open/floor/rogue/citybrick,)
	max_integrity = 1200

/turf/open/floor/rogue/desert_grass/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)
	icon_state = "desertgrass[rand(1,16)]"


/turf/open/floor/rogue/desert_grass/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)

/turf/open/floor/rogue/desert_grass/turf_destruction(damage_flag)
	. = ..()
	src.ChangeTurf(/turf/open/floor/rogue/dirt, flags = CHANGETURF_INHERIT_AIR)

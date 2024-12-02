//Sand floors
/turf/open/floor/rogue/sand
    name = "sand"
    desc = "Sandy sand."
    icon = 'icons/turf/sand.dmi'
    icon_state = "sand"
    footstep = FOOTSTEP_SAND
    barefootstep = FOOTSTEP_SAND
    clawfootstep = FOOTSTEP_SAND
    heavyfootstep = FOOTSTEP_GENERIC_HEAVY
    canSmoothWith = list(/turf/open/floor/rogue/sandrock, /turf/open/floor/rogue/sandthin, /turf/open/floor/rogue/sandalt)
/turf/open/floor/rogue/sand/cardinal_smooth(adjacencies)
    roguesmooth(adjacencies)
/turf/open/floor/rogue/sand/Initialize()
    . = ..()
    dir = pick(GLOB.cardinals)


/turf/open/floor/rogue/sandrock
    icon = 'icons/turf/sand.dmi'
    icon_state = "sandrock"
/turf/open/floor/rogue/sandrock/cardinal_smooth(adjacencies)
    roguesmooth(adjacencies)
/turf/open/floor/rogue/sandrock/Initialize()
    . = ..()
    dir = pick(GLOB.cardinals)


/turf/open/floor/rogue/sandthin
    icon = 'icons/turf/sand.dmi'
    icon_state = "sandthin"
/turf/open/floor/rogue/sandthin/cardinal_smooth(adjacencies)
    roguesmooth(adjacencies)
/turf/open/floor/rogue/sandthin/Initialize()
    . = ..()
    dir = pick(GLOB.cardinals)


/turf/open/floor/rogue/sandalt
    icon = 'icons/turf/sand.dmi'
    icon_state = "sandalt"
/turf/open/floor/rogue/sandalt/cardinal_smooth(adjacencies)
    roguesmooth(adjacencies)
/turf/open/floor/rogue/sandalt/Initialize()
    . = ..()
    dir = pick(GLOB.cardinals)

/turf/open/floor/rogue/bigsandtile
    icon = 'icons/roguetown/misc/256.dmi'
    icon_state = "BigSandTile"
/turf/open/floor/rogue/sandalt/cardinal_smooth(adjacencies)
    roguesmooth(adjacencies)
/turf/open/floor/rogue/sandalt/Initialize()
    . = ..()
    dir = pick(GLOB.cardinals)

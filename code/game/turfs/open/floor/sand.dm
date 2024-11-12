/turf/open/floor/rogue/sand
	gender = PLURAL
	name = "sand"
	desc = "The dirt is pocked with the scars of countless battles."
	icon = 'icons/turf/sand.dmi'
	icon_state = "sand"
	baseturfs = /turf/open/chasm/jungle
	initial_gas_mix = OPENTURF_LOW_PRESSURE
	planetary_atmos = TRUE
	attachment_holes = FALSE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/rogue/sandrock
    icon_state = "sandrock"

/turf/open/floor/rogue/sandthin
    icon_state = "sandthin"
/turf/open/floor/rogue/sandalt
<<<<<<< Updated upstream
    icon_state = "sandalt"

/turf/open/floor/plating/dirt/dark
	icon_state = "sand"

/turf/open/floor/plating/dirt/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return
//underworld
/turf/open/floor/plating/dirt/underworld
	gender = PLURAL
	name = "ash"
	desc = "The floor is strange.."
	icon = 'icons/turf/floors.dmi'
	icon_state = "underworld"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
=======
	icon = 'icons/turf/sand.dmi'
	icon_state = "sandalt"
/turf/open/floor/rogue/sandalt/cardinal_smooth(adjacencies)
	roguesmooth(adjacencies)
/turf/open/floor/rogue/sandalt/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)


>>>>>>> Stashed changes

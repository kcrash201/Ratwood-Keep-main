<<<<<<< Updated upstream
/particles/weather/sand
	icon_state             = "dot"
	color                  = "#e2deb7"
=======

//Rain - goes down
/particles/weather/rain
	icon_state             = "drop"
	color                  = "#ccffff"
>>>>>>> Stashed changes
	position               = generator("box", list(-500,-256,0), list(400,500,0))
	grow			       = list(-0.01,-0.01)
	gravity                = list(0, -10, 0.5)
	drift                  = generator("circle", 0, 1) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s
<<<<<<< Updated upstream
	transform 			   = null // sand is directional - so don't make it "3D"
	//Weather effects, max values
	maxSpawning            = 250
	minSpawning            = 50
	wind                   = 5
	spin                   = 0 // explicitly set spin to 0 - there is a bug that seems to carry generators over from old particle effects

/datum/particle_weather/sand_gentle
	name = "Sand"
	desc = "Light sandfall, la la description."
	particleEffectType = /particles/weather/sand

	scale_vol_with_severity = TRUE
	//weather_sounds = list(/datum/looping_sound/sand)
	weather_messages = list(
		"Fine grains of sand drift lazily through the air.",
		"A soft veil of sand falls around you.",
		"The wind carries whispers of the desert.",
		"You feel a dryness settle on you."
		)

	minSeverity = 1
	maxSeverity = 10
	maxSeverityChange = 5
	severitySteps = 5
	immunity_type = TRAIT_SANDSTORM_IMMUNE
	probability = 1
	target_trait = PARTICLEWEATHER_SAND
	weather_special_effect = /datum/weather_effect/sand

//Makes you a little hot
/datum/particle_weather/sand_gentle/weather_act(mob/living/L)
	L.adjust_bodytemperature(rand(1,3))

/datum/particle_weather/sand_storm
	name = "Sand storm"
	desc = "Heavy sandstorm, la la description."
	particleEffectType = /particles/weather/sand

	scale_vol_with_severity = TRUE
	//weather_sounds = list(/datum/looping_sound/sand)
	weather_messages = list(
		"A brutal wind howls, flinging sand in every direction!",
		"The sand lashes your skin like needles!",
		"Each breath burns with heat and dust.",
		"How can a man who sees clearly, understand a man caught in the storm?"
		)

	minSeverity = 40
	maxSeverity = 100
	maxSeverityChange = 50
	severitySteps = 50
	immunity_type = TRAIT_SANDSTORM_IMMUNE
	probability = 1
	target_trait = PARTICLEWEATHER_SAND
	weather_special_effect = /datum/weather_effect/sand

/datum/weather_effect/sand
	name = "sand effect"
	probability = 40

/datum/weather_effect/sand/effect_affect(turf/target_turf)
	if(!target_turf.sand)
		new /obj/structure/sand(target_turf, 1)
	else
		target_turf.sand.weathered(src)

/datum/particle_weather/sand_storm/weather_act(mob/living/L)
	L.adjust_bodytemperature(rand(5,15))

/datum/weather_effect/sand_storm/effect_affect(turf/target_turf)
	if(!target_turf.sand)
		new /obj/structure/sand(target_turf, 1)
	else
		target_turf.sand.weathered(src)

/turf
	var/obj/structure/sand/sand

/obj/structure/sand
	name = "Sand"
	desc = "Big pile of sand"
	icon = 'icons/effects/snow.dmi'
	icon_state = "snow_1"
	var/icon_prefix = "snow"
	anchored = TRUE
	density = FALSE
	plane = GAME_PLANE
	layer = TABLE_LAYER - 0.1
	var/bleed_layer = 0
	var/progression = 0
	var/turf/sanded_turf
	var/list/sands_connections = list(list("0", "0", "0", "0"), list("0", "0", "0", "0"), list("0", "0", "0", "0"))
	var/list/diged = list("2" = 0, "1" = 0, "8" = 0, "4" = 0)

/obj/structure/sand/Initialize(mapload, bleed_layers)
	. = ..()
	icon_state = "blank"
	bleed_layer = bleed_layers
	if(!bleed_layer)
		bleed_layer = rand(1, 3)

	//RegisterSignal(src, COMSIG_ATOM_TURF_CHANGE, PROC_REF(update_visuals_effects))

	START_PROCESSING(SSslowobj, src)

	update_corners(TRUE)
	update_overlays()

	update_visuals_effects(first = TRUE)

/obj/structure/sand/Destroy(force)
	update_visuals_effects(src, FALSE)

	for(var/atom/movable/movable in get_turf(src))
		if(movable.get_filter("mob_moving_effect_mask"))
			animate(movable.get_filter("mob_moving_effect_mask"), y = -32, time = 0)
			if(ismob(movable))
				movable:update_vision_cone()
			for(var/mob/living/carbon/human/human in view(movable, 7))
				human.update_vision_cone()

	STOP_PROCESSING(SSslowobj, src)
	sanded_turf.sand = null
	sanded_turf = null

	. = ..()

	for(var/obj/structure/sand/bordered_sand in orange(get_turf(src), 1))
		if(!bordered_sand)
			continue
		if(bordered_sand == src)
			continue
		bordered_sand.update_corners(ignored = src)
		bordered_sand.update_overlays()

/obj/structure/sand/process(delta_time)
	update_overlays()

/obj/structure/sand/proc/get_slowdown()
	return 1.5 * bleed_layer

/obj/structure/sand/proc/update_visuals_effects(datum/source, replace = TRUE, first = FALSE)
	SIGNAL_HANDLER

	var/list/contained_mobs = list()
	var/turf/turf = get_turf(src)
	for(var/mob/living/contained_mob in contents)
		contained_mobs += contained_mob
		SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_REMOVE, contained_mob)

	for(var/obj/structure/contained_structure in contents)
		if(istype(contained_structure, /obj/structure/sand) || istype(contained_structure, /obj/structure/flora/roguegrass/bush/wall))
			continue
		contained_mobs += contained_structure
		SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_REMOVE, contained_structure)

	for(var/obj/item/contained_item in contents)
		contained_mobs += contained_item
		SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_REMOVE, contained_item)

	for(var/obj/machinery/contained_machinery in contents)
		contained_mobs += contained_machinery
		SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_REMOVE, contained_machinery)


	if(first)
		for(var/mob/living/contained_mob in turf.contents)
			contained_mobs += contained_mob
			SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_REMOVE, contained_mob)

		for(var/obj/structure/contained_structure in turf.contents)
			if(istype(contained_structure, /obj/structure/sand) || istype(contained_structure, /obj/structure/flora/roguegrass/bush/wall))
				continue
			contained_mobs += contained_structure
			SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_REMOVE, contained_structure)

		for(var/obj/item/contained_item in turf.contents)
			contained_mobs += contained_item
			SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_REMOVE, contained_item)

		for(var/obj/machinery/contained_machinery in turf.contents)
			contained_mobs += contained_machinery
			SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_REMOVE, contained_machinery)


	RemoveElement(/datum/element/mob_overlay_effect)
	if(replace)
		AddElement(/datum/element/mob_overlay_effect, bleed_layer * 2.4, -6 + (bleed_layer * 3.5), 100)
		for(var/mob/living/contained_mob as anything in contained_mobs)
			SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_UPDATE, contained_mob)
		for(var/obj/structure/contained_structure in contained_mobs)
			contained_mobs += contained_structure
			SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_UPDATE, contained_structure)
		for(var/obj/item/contained_item in contained_mobs)
			contained_mobs += contained_item
			SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_UPDATE, contained_item)

		for(var/obj/machinery/contained_machinery in contained_mobs)
			contained_mobs += contained_machinery
			SEND_SIGNAL(src, COMSIG_MOB_OVERLAY_FORCE_UPDATE, contained_machinery)

/obj/structure/sand/proc/update_corners(propagate = FALSE, obj/structure/ignored)
	var/list/sand_dirs = list(list(), list(), list())
	var/turf/turf = get_turf(src)
	if(!turf)
		return
	if(turf != sanded_turf)
		if(sanded_turf)
			sanded_turf.sand = null
		sanded_turf = turf
		sanded_turf.sand = src

	for(var/obj/structure/sand/bordered_sand in orange(src, 1))
		if(!bordered_sand)
			continue
		if(ignored == bordered_sand)
			continue

		if(propagate)
			bordered_sand.update_corners()
			bordered_sand.update_overlays()

		var/direction = get_dir(src, bordered_sand)
		for(var/deep = 1 to length(sand_dirs))
			if(deep > bleed_layer)
				continue

			if(deep > bordered_sand.bleed_layer)
				continue

			sand_dirs[deep] += direction

	for(var/deep = 1 to length(sand_dirs))
		sands_connections[deep] = dirs_to_corner_states(sand_dirs[deep])

/obj/structure/sand/update_overlays()
	. = ..()
	if(overlays)
		overlays.Cut()

	for(var/deep = 1 to length(sands_connections))
		if(deep > bleed_layer)
			continue

		for(var/i = 1 to 4)
			overlays += image(icon, "[icon_prefix]_[deep]_[sands_connections[deep][i]]", dir = 1<<(i-1))

	var/new_overlay = ""
	for(var/i in diged)
		if(diged[i] > world.time)
			new_overlay += i
	overlays += "[new_overlay]"

/obj/structure/sand/proc/damage_act(damage)
	if(progression > damage / 5)
		progression -= damage / 5
	else
		changing_layer(min(bleed_layer - round(damage / (bleed_layer * 20), 1), MAX_LAYER_SAND_LEVELS))
		progression = bleed_layer * 4

/obj/structure/sand/bullet_act(obj/projectile/proj)
	return FALSE


/obj/structure/sand/proc/weathered(datum/weather_effect/effect)
	if(progression < bleed_layer * 8)
		progression++
	else
		if(bleed_layer >= 3)
			for(var/direction in GLOB.alldirs)
				var/turf/turf = get_step(loc, direction)
				if(!turf.sand)
					turf.apply_weather_effect(effect)
					break

				else if(turf.sand && turf.sand.bleed_layer != 3)
					turf.sand.weathered(effect)
					break
		else
			changing_layer(min(bleed_layer + 1, MAX_LAYER_SAND_LEVELS))

		progression = 0

/obj/structure/sand/proc/changing_layer(new_layer)
	if(isnull(new_layer) || new_layer == bleed_layer)
		return

	bleed_layer = max(0, new_layer)

	if(!bleed_layer)
		qdel(src)
		return

	switch(bleed_layer)
		if(1)
			layer = BELOW_OBJ_LAYER
		if(2)
			layer = BELOW_OBJ_LAYER
		if(3)
			layer = OBJ_LAYER

	update_corners(TRUE)
	update_overlays()

	update_visuals_effects()

/obj/structure/sand/ex_act(severity)
	damage_act(severity)

/obj/structure/sand/Crossed(atom/movable/arrived)
	. = ..()
	if(isliving(arrived))
		set_diged_ways(GLOB.reverse_dir[arrived.dir])

/obj/structure/sand/Uncrossed(atom/movable/gone)
	. = ..()
	if(isliving(gone))
		set_diged_ways(gone.dir)

/obj/structure/sand/proc/set_diged_ways(dir)
	diged["[dir]"] = world.time + 1 MINUTES
	update_overlays()
=======
	transform 			   = null // Rain is directional - so don't make it "3D"
	//Weather effects, max values
	maxSpawning            = 250
	minSpawning            = 50
	wind                   = 2
	spin                   = 0 // explicitly set spin to 0 - there is a bug that seems to carry generators over from old particle effects

/datum/particle_weather/rain_gentle
	name = "Rain"
	desc = "Gentle rain, la la description."
	particleEffectType = /particles/weather/rain

	scale_vol_with_severity = TRUE
	weather_sounds = list(/datum/looping_sound/rain)
	indoor_weather_sounds = list(/datum/looping_sound/indoor_rain)
	weather_messages = list("The rain makes you shiver a little.")

	minSeverity = 1
	maxSeverity = 15
	maxSeverityChange = 2
	severitySteps = 5
	immunity_type = TRAIT_RAINSTORM_IMMUNE
	probability = 1
	target_trait = PARTICLEWEATHER_RAIN

//Makes you a little chilly
/datum/particle_weather/rain_gentle/weather_act(mob/living/L)
	L.adjust_bodytemperature(-rand(1,3))

/datum/particle_weather/rain_storm
	name = "Rain storm"
	desc = "Heavy rain, la la description."
	particleEffectType = /particles/weather/rain

	scale_vol_with_severity = TRUE
	weather_sounds = list(/datum/looping_sound/storm)
	indoor_weather_sounds = list(/datum/looping_sound/indoor_rain)
	weather_messages = list("The rain makes you shiver a little.", "The storm is really picking up!")

	minSeverity = 4
	maxSeverity = 100
	maxSeverityChange = 50
	severitySteps = 50
	immunity_type = TRAIT_RAINSTORM_IMMUNE
	probability = 1
	target_trait = PARTICLEWEATHER_RAIN

//Makes you a bit chilly
/datum/particle_weather/rain_storm/weather_act(mob/living/L)
	L.adjust_bodytemperature(-rand(3,5))
>>>>>>> Stashed changes

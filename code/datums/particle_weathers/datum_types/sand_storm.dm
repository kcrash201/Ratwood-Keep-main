/particles/weather/sand
	icon_state             = "dot"
	color                  = "#e2deb7"

	position               = generator("box", list(-500,-256,0), list(400,500,0))
	grow			       = list(-0.01,-0.01)
	gravity                = list(0, -10, 0.5)
	drift                  = generator("circle", 0, 1) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s
	transform 			   = null // sand is directional - so don't make it "3D"

	//Weather effects, max values
	maxSpawning            = 250
	minSpawning            = 50
	wind                   = 2
	spin                   = 0 // explicitly set spin to 0 - there is a bug that seems to carry generators over from old particle effects

/obj/structure/sand/proc/set_diged_ways(dir)
	diged["[dir]"] = world.time + 1 MINUTES
	update_overlays()

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

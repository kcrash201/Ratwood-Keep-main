/obj/machinery/light/roguestreet
	name = "street lamp" // Crafted through metalizing brazier(/obj/machinery/light/rogue/firebowl) and Standing Fire (/obj/machinery/light/rogue/firebowl/standing)
	desc = "An obelisk of caste iron with an eerily glowing lamp attached to it. A promise of new technology at the dawn of a new age."
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "slamp1_nozap"
	base_state = "slamp"
	brightness = 10.9
	nightshift_allowed = FALSE
	plane = GAME_PLANE_UPPER
	layer = 4.81
	fueluse = 0
	bulb_colour = "#58dd90"
	bulb_power = 0.95
	destroy_sound = "sound/foley/machinebreak.ogg" // A nice zappy noise for electric lights.
	destroy_message = "The lamp sparks as it is smashed!" // Some flavor for when it's destroyed.
	blade_dulling = DULLING_BASH
	max_integrity = 250
	pass_flags = LETPASSTHROW
	smeltresult = /obj/item/ingot/bronze
	resistance_flags = INDESTRUCTIBLE // This item is not craftable yet, setting for anti-grief

/obj/machinery/light/roguestreet/midlamp
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "midlamp1_nozap"
	base_state = "midlamp"
	pixel_x = -16
	density = TRUE
	resistance_flags = INDESTRUCTIBLE // This item is not craftable yet, setting for anti-grief

/obj/machinery/light/roguestreet/walllamp
	name = "wall lamp" // Crafted through metalizing sconce.
	desc = "An eerily glowing lamp attached to the wall via a caste iron frame. A promise of new technology at the dawn of a new age."
	icon_state = "wlamp1_nozap"
	base_state = "wlamp"
	brightness = 7.8
	max_integrity = 125
	density = FALSE

/obj/machinery/light/roguestreet/orange
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "o_slamp1_nozap"
	base_state = "o_slamp"
	brightness = 10.9
	bulb_colour = "#da8c45"
	bulb_power = 1
	resistance_flags = null // This one is craftable.

/obj/machinery/light/roguestreet/orange/midlamp
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "o_midlamp1_nozap"
	base_state = "o_midlamp"
	pixel_x = -16
	density = TRUE
	resistance_flags = INDESTRUCTIBLE // This item is not craftable yet, setting for anti-grief

/obj/machinery/light/roguestreet/orange/walllamp
	name = "wall lamp"
	desc = "An eerily glowing lamp attached to the wall via a caste iron frame. A promise of new technology at the dawn of a new age."
	icon_state = "o_wlamp1_nozap"
	base_state = "o_wlamp"
	brightness = 7.8
	max_integrity = 125
	density = FALSE
	resistance_flags = null // This one is craftable.

/obj/machinery/light/roguestreet/proc/lights_out()
	on = FALSE
	set_light(0)
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(lights_on)), 5 MINUTES)

/obj/machinery/light/roguestreet/proc/lights_on()
	on = TRUE
	update()
	update_icon()

/obj/machinery/light/roguestreet/update_icon()
	if(on)
		icon_state = "[base_state]1_nozap"
	else
		icon_state = "[base_state]0"

/obj/machinery/light/roguestreet/update()
	. = ..()
	if(on)
		GLOB.fires_list |= src
	else
		GLOB.fires_list -= src

/obj/machinery/light/roguestreet/Initialize()
	GLOB.streetlamp_list += src
	lights_on()
	update_icon()
	. = ..()

//fires
/obj/machinery/light/rogue
	icon = 'icons/roguetown/misc/lighting.dmi'
	brightness = 8
	nightshift_allowed = FALSE
	fueluse = 60 MINUTES
	bulb_colour = "#f9ad80"
	bulb_power = 1
	flags_1 = NODECONSTRUCT_1
	var/datum/looping_sound/soundloop = /datum/looping_sound/fireloop
	pass_flags = LETPASSTHROW
	var/cookonme = FALSE
	var/crossfire = TRUE
	var/start_fuel //Override for fueluse. Mostly used for smelters.
	var/fuel_modifier = 1 //Modifier for firefuel

/obj/machinery/light/rogue/Initialize()
	if(soundloop)
		soundloop = new soundloop(src, FALSE)
		soundloop.start()
	GLOB.fires_list += src
	if(start_fuel)
		fueluse = start_fuel
	if(fueluse)
		fueluse = fueluse - (rand(fueluse*0.1,fueluse*0.3))
	update_icon()
	seton(TRUE)
	. = ..()

/obj/machinery/light/rogue/weather_trigger(W)
	if(W==/datum/weather/rain)
		START_PROCESSING(SSweather,src)

/obj/machinery/light/rogue/examine(mob/user)
	. = ..()
	if(Adjacent(user))
		if(fueluse > 0)
			var/minsleft = fueluse / 600
			minsleft = round(minsleft)
			if(minsleft <= 1)
				minsleft = "less than a minute"
			else
				minsleft = "[round(minsleft)] minutes"
			. += span_info("The fire will last for [minsleft].")
		else
			if(initial(fueluse) > 0)
				. += span_warning("The fire is burned out and hungry...")

/obj/machinery/light/rogue/extinguish()
	if(on)
		burn_out()
		new /obj/effect/temp_visual/small_smoke(src.loc)
	..()

/obj/machinery/light/rogue/OnCrafted(dirin, user)
	. = ..()
	burn_out()


/obj/machinery/light/rogue/burn_out()
	if(soundloop)
		soundloop.stop()
	if(on)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
	..()
	update_icon()

/obj/machinery/light/rogue/update_icon()
	if(on)
		icon_state = "[base_state]1"
	else
		icon_state = "[base_state]0"

/obj/machinery/light/rogue/update()
	. = ..()
	if(on)
		GLOB.fires_list |= src
	else
		GLOB.fires_list -= src

/obj/machinery/light/rogue/Destroy()
	QDEL_NULL(soundloop)
	GLOB.fires_list -= src
	. = ..()

/obj/machinery/light/rogue/fire_act(added, maxstacks)
	if(!on && ((fueluse > 0) || (initial(fueluse) == 0)))
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		on = TRUE
		update()
		update_icon()
		if(soundloop)
			soundloop.start()
		addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
		return TRUE

/obj/proc/trigger_weather()
	if(!QDELETED(src))
		if(isturf(loc))
			var/turf/T = loc
			T.trigger_weather(src)

/obj/machinery/light/rogue/Crossed(atom/movable/AM, oldLoc)
	..()
	if(crossfire)
		if(on)
			AM.fire_act(1,5)

/obj/machinery/light/rogue/spark_act()
	fire_act()

/obj/machinery/light/rogue/attackby(obj/item/W, mob/living/user, params)
	if(cookonme)
		if(istype(W, /obj/item/reagent_containers/food/snacks))
			if(istype(W, /obj/item/reagent_containers/food/snacks/egg))
				to_chat(user, span_warning("I wouldn't be able to cook this over the fire..."))
				return FALSE
			var/obj/item/A = user.get_inactive_held_item()
			if(A)
				var/foundstab = FALSE
				for(var/X in A.possible_item_intents)
					var/datum/intent/D = new X
					if(D.blade_class == BCLASS_STAB)
						foundstab = TRUE
						break
				if(foundstab)
					var/prob2spoil = 33
					if(user.mind.get_skill_level(/datum/skill/craft/cooking))
						prob2spoil = 1
					user.visible_message(span_notice("[user] starts to cook [W] over [src]."))
					for(var/i in 1 to 6)
						if(do_after(user, 30, target = src))
							var/obj/item/reagent_containers/food/snacks/S = W
							var/obj/item/C
							if(prob(prob2spoil))
								user.visible_message(span_warning("[user] burns [S]."))
								if(user.client?.prefs.showrolls)
									to_chat(user, span_warning("Cooking fail... [prob2spoil]%."))
								C = S.cooking(1000, null)
							else
								C = S.cooking(S.cooktime/4, src)
							if(C)
								user.dropItemToGround(S, TRUE)
								qdel(S)
								C.forceMove(get_turf(user))
								user.put_in_hands(C)
								break
						else
							break
					return
	if(W.firefuel)
		if(initial(fueluse))
			if(fueluse > initial(fueluse) - 5 SECONDS)
				to_chat(user, span_warning("The fire is fully fueled."))
				return FALSE
		else
			if(!on)
				return
		if (alert(usr, "Feed [W] to the fire?", "ROGUETOWN", "Yes", "No") != "Yes")
			return
		if(!W)
			return

		// Simple way to check if the item is no longer in the players hand
		// Even if it somehow isn't deleted yet, this will stop the infinite fuel bug.
		if(user.get_active_held_item() != W)
			to_chat(user, span_warning("That item is no longer in my hand..."))
			return

		user.dropItemToGround(W)
		qdel(W)
		user.visible_message(span_warning("[user] feeds [W] to [src]."))
		if(initial(fueluse))
			fueluse = fueluse + W.firefuel*fuel_modifier
			if(fueluse > initial(fueluse)) //keep it at the max
				fueluse = initial(fueluse)
		return TRUE
	else
		if(on)
			if(istype(W, /obj/item/natural/dirtclod))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				on = FALSE
				set_light(0)
				update_icon()
				qdel(W)
				src.visible_message(span_warning("[user] snuffs the fire."))
				return
			if(user.used_intent?.type != INTENT_SPLASH)
				W.spark_act()
	. = ..()

/obj/machinery/light/rogue/firebowl
	name = "brazier"
	icon = 'icons/roguetown/misc/lighting.dmi'
	icon_state = "stonefire1"
	density = TRUE
//	pixel_y = 10
	base_state = "stonefire"
	climbable = TRUE
	cookonme = TRUE
	fueluse = 0
	max_integrity = 150
	metalizer_result = /obj/machinery/light/roguestreet/orange // Can be crafted into street lamp.

/obj/machinery/light/rogue/firebowl/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	if(mover.throwing)
		return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	return !density

/obj/machinery/light/rogue/firebowl/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(on)
		var/mob/living/carbon/human/H = user
		if(istype(H))
			H.visible_message(span_info("[H] warms [H.p_their()] hand over the fire."))
			if(do_after(H, 1.5 SECONDS, target = src))
				var/obj/item/bodypart/affecting = H.get_bodypart((user.active_hand_index % 2 == 0) ? BODY_ZONE_R_ARM : BODY_ZONE_L_ARM)
				to_chat(H, span_warning("HOT!"))
				if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
					H.update_damage_overlays()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch
	else if(icon_state == "[base_state]over")
		user.visible_message(span_notice("[user] starts to pick up [src]..."), \
			span_notice("I start to pick up [src]..."))
		if(do_after(user, 3 SECONDS, target = src))
			icon_state = "[base_state]0"
		return

/obj/machinery/light/rogue/firebowl/stump
	icon_state = "stumpfire1"
	base_state = "stumpfire"

/obj/machinery/light/rogue/firebowl/church
	icon_state = "churchfire1"
	base_state = "churchfire"
	metalizer_result = null // This item is not craftable, setting this to prevent grief by metalizer.
	resistance_flags = INDESTRUCTIBLE // This item is not craftable yet, setting for anti-grief

/obj/machinery/light/rogue/firebowl/standing
	name = "standing fire"
	icon_state = "standing1"
	base_state = "standing"
	bulb_colour = "#ff9648"
	cookonme = FALSE
	crossfire = FALSE
	metalizer_result = /obj/machinery/light/roguestreet/orange

/obj/machinery/light/rogue/firebowl/standing/blue
	bulb_colour = "#b9bcff"
	icon_state = "standingb1"
	base_state = "standingb"
	metalizer_result = null // This item is not craftable, setting this to prevent grief by metalizer.
	resistance_flags = INDESTRUCTIBLE // This item is not craftable yet, setting for anti-grief

/obj/machinery/light/rogue/firebowl/standing/green
	bulb_colour = "#8ee2a7"
	icon_state = "standingg1"
	base_state = "standingg"
	metalizer_result = null // This item is not craftable, setting this to prevent grief by metalizer.
	resistance_flags = INDESTRUCTIBLE // This item is not craftable yet, setting for anti-grief

/obj/machinery/light/rogue/firebowl/standing/proc/knock_over() //use this later for jump impacts and shit
	icon_state = "[base_state]over"

/obj/machinery/light/rogue/firebowl/standing/fire_act(added, maxstacks)
	if(icon_state != "[base_state]over")
		..()

/obj/machinery/light/rogue/firebowl/standing/onkick(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(icon_state == "[base_state]over")
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message(span_warning("[user] kicks [src]!"), \
				span_warning("I kick [src]!"))
			return
		if(prob(L.STASTR * 8))
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message(span_warning("[user] kicks over [src]!"), \
				span_warning("I kick over [src]!"))
			burn_out()
			knock_over()
		else
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message(span_warning("[user] kicks [src]!"), \
				span_warning("I kick [src]!"))

/obj/machinery/light/rogue/wallfire
	name = "fireplace"
	icon_state = "wallfire1"
	base_state = "wallfire"
	density = FALSE
	fueluse = 0
	crossfire = FALSE
	cookonme = TRUE

// This doesnt have a spent sprite variant, decorative purpose only.
/obj/machinery/light/rogue/wallfire/desert
	name = "desert fireplace"
	icon = 'icons/desert_town/fireplace.dmi'
	icon_state = "fireplace1"
	base_state = "fireplace"
	fueluse = 0
	density = FALSE
	anchored = TRUE
	cookonme = FALSE

/obj/machinery/light/rogue/wallfire/candle
	name = "candles"
	icon_state = "wallcandle1"
	base_state = "wallcandle"
	crossfire = FALSE
	cookonme = FALSE
	pixel_y = 32
	soundloop = null
	resistance_flags = INDESTRUCTIBLE // This item is not craftable yet, setting for anti-grief

/obj/machinery/light/rogue/wallfire/candle/OnCrafted(dirin, user)
	pixel_x = 0
	pixel_y = 0
	switch(dirin)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 32
		if(WEST)
			pixel_x = -32
	. = ..()

/obj/machinery/light/rogue/wallfire/candle/attack_hand(mob/user)
	if(isliving(user) && on)
		user.visible_message(span_warning("[user] snuffs [src]."))
		burn_out()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch
	. = ..()

/obj/machinery/light/rogue/wallfire/candle/r
	pixel_y = 0
	pixel_x = 32
/obj/machinery/light/rogue/wallfire/candle/l
	pixel_y = 0
	pixel_x = -32

/obj/machinery/light/rogue/wallfire/candle/blue
	bulb_colour = "#b9bcff"
	icon_state = "wallcandleb1"
	base_state = "wallcandleb"

/obj/machinery/light/rogue/wallfire/candle/blue/r
	pixel_y = 0
	pixel_x = 32
/obj/machinery/light/rogue/wallfire/candle/blue/l
	pixel_y = 0
	pixel_x = -32

/obj/machinery/light/rogue/torchholder
	name = "sconce"
	icon_state = "torchwall1"
	base_state = "torchwall"
	brightness = 5
	density = FALSE
	var/obj/item/flashlight/flare/torch/torchy
	fueluse = 0 //we use the torch's fuel
	soundloop = null
	crossfire = FALSE
	plane = GAME_PLANE_UPPER
	cookonme = FALSE
	metalizer_result = /obj/machinery/light/roguestreet/orange/walllamp

/obj/machinery/light/rogue/torchholder/c
	pixel_y = 32

/obj/machinery/light/rogue/torchholder/r
	dir = WEST

/obj/machinery/light/rogue/torchholder/l
	dir = EAST

/obj/machinery/light/rogue/torchholder/fire_act(added, maxstacks)
	if(torchy)
		if(!on)
			if(torchy.fuel > 0)
				torchy.spark_act()
				playsound(src.loc, 'sound/items/firelight.ogg', 100)
				on = TRUE
				update()
				update_icon()
				if(soundloop)
					soundloop.start()
				addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
				return TRUE

/obj/machinery/light/rogue/torchholder/Initialize()
	torchy = new /obj/item/flashlight/flare/torch(src)
	torchy.spark_act()
	. = ..()

/obj/machinery/light/rogue/torchholder/OnCrafted(dirin, user)
	if(dirin == NORTH)
		pixel_y = 32
	dirin = turn(dirin, 180)
	QDEL_NULL(torchy)
	on = FALSE
	set_light(0)
	update_icon()
	. = ..(dirin)

/obj/machinery/light/rogue/torchholder/process()
	if(on)
		if(torchy)
			if(torchy.fuel <= 0)
				burn_out()
			if(!torchy.on)
				burn_out()
		else
			return PROCESS_KILL

/obj/machinery/light/rogue/torchholder/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(torchy)
		if(!istype(user) || !Adjacent(user) || !user.put_in_active_hand(torchy))
			torchy.forceMove(loc)
		torchy = null
		on = FALSE
		set_light(0)
		update_icon()
		playsound(src.loc, 'sound/foley/torchfixturetake.ogg', 100)

/obj/machinery/light/rogue/torchholder/update_icon()
	if(torchy)
		if(on)
			icon_state = "[base_state]1"
		else
			icon_state = "[base_state]0"
	else
		icon_state = "torchwall"

/obj/machinery/light/rogue/torchholder/burn_out()
	if(torchy && torchy.on)
		torchy.turn_off()
	..()

/obj/machinery/light/rogue/torchholder/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/flashlight/flare/torch))
		var/obj/item/flashlight/flare/torch/LR = W
		if(torchy)
			if(LR.on && !on)
				if(torchy.fuel <= 0)
					to_chat(user, span_warning("The mounted torch is burned out."))
					return
				else
					torchy.spark_act()
					user.visible_message(span_info("[user] lights [src]."))
					playsound(src.loc, 'sound/items/firelight.ogg', 100)
					on = TRUE
					update()
					update_icon()
					addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
					return
			if(!LR.on && on)
				if(LR.fuel > 0)
					LR.spark_act()
					user.visible_message(span_info("[user] lights [LR] in [src]."))
					user.update_inv_hands()
		else
			if(LR.on)
				if(!user.transferItemToLoc(LR, src))
					return
				torchy = LR
				on = TRUE
				update()
				update_icon()
				addtimer(CALLBACK(src, PROC_REF(trigger_weather)), rand(5,20))
			else
				if(!user.transferItemToLoc(LR, src))
					return
				torchy = LR
				update_icon()
			playsound(src.loc, 'sound/foley/torchfixtureput.ogg', 100)
		return
	. = ..()

/obj/machinery/light/rogue/chand
	name = "chandelier"
	icon_state = "chand1"
	base_state = "chand"
	icon = 'icons/roguetown/misc/tallwide.dmi'
	density = FALSE
	brightness = 10
	pixel_x = -10
	pixel_y = -10
	layer = 2.0
	fueluse = 0
	soundloop = null
	crossfire = FALSE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
	resistance_flags = INDESTRUCTIBLE // This item is not craftable yet, setting for anti-grief

/obj/machinery/light/rogue/chand/attack_hand(mob/user)
	if(isliving(user) && on)
		user.visible_message(span_warning("[user] snuffs [src]."))
		burn_out()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch
	. = ..()


/obj/machinery/light/rogue/hearth
	name = "hearth"
	icon_state = "hearth1"
	base_state = "hearth"
	density = FALSE
	anchored = TRUE
	layer = 2.8
	var/obj/item/attachment = null
	var/obj/item/reagent_containers/food/snacks/food = null
	cookonme = TRUE


/obj/machinery/light/rogue/hearth/Initialize()
	. = ..()

/obj/machinery/light/rogue/hearth/attackby(obj/item/W, mob/living/user, params)
	if(!attachment)
		if(istype(W, /obj/item/cooking/pan) || istype(W, /obj/item/reagent_containers/glass/bucket/pot))
			playsound(get_turf(user), 'sound/foley/dropsound/shovel_drop.ogg', 40, TRUE, -1)
			attachment = W
			W.forceMove(src)
			update_icon()
			return
	else
		if(istype(W, /obj/item/reagent_containers/glass/bowl))
			to_chat(user, "<span class='notice'>Remove the pot from the hearth first.</span>")
			return
		if(istype(attachment, /obj/item/cooking/pan))
			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/S = W
				if(istype(W, /obj/item/reagent_containers/food/snacks/egg)) // added
					if(W.icon_state != "rawegg")
						playsound(get_turf(user), 'modular/Neu_Food/sound/eggbreak.ogg', 100, TRUE, -1)
						sleep(25) // to get egg crack before frying hiss
						W.icon_state = "rawegg" // added
				if(!food)
					S.forceMove(src)
					food = S
					update_icon()
					playsound(src.loc, 'sound/misc/frying.ogg', 80, FALSE, extrarange = 5)
					return
		else if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/obj/item/reagent_containers/glass/bucket/pot/P = attachment
			P.attackby(W, user, params)

	. = ..()

//If you know what I have to do to make this work let me know!!

/obj/machinery/light/rogue/hearth/MouseDrop(mob/over)
	if(attachment)
		if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/obj/item/reagent_containers/glass/bucket/pot/P = attachment
			var/datum/component/storage/STR = P.GetComponent(/datum/component/storage)
			if(STR)
				STR.mousedrop_onto(STR, over, over)
			return
	. = ..()

	

/* This is the blackstone version, not compatible but retained so it can be injected into say stews if the new system ends up too shallow.

			if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks) || W.type == /obj/item/reagent_containers/powder/flour)
				if(pot.reagents.chem_temp < 374)
					to_chat(user, span_warning("[pot] isn't boiling!"))
					return
				var/nutrimentamount = W.reagents.get_reagent_amount(/datum/reagent/consumable/nutriment)
				if(W.type in subtypesof(/obj/item/reagent_containers/food/snacks))
					var/obj/item/reagent_containers/food/snacks/snack = W
					if(snack.type in subtypesof(/obj/item/reagent_containers/food/snacks/grown) || snack.eat_effect == /datum/status_effect/debuff/uncookedfood)
						nutrimentamount += 5 //fuck it extra yield so soups are worth a shit.
						nutrimentamount *= 1.25 //Boiling food makes more nutrients digestable.
				if(istype(W, /obj/item/reagent_containers/food/snacks/grown/wheat) || istype(W, /obj/item/reagent_containers/food/snacks/grown/oat) || istype(W, /obj/item/reagent_containers/powder/flour))
					nutrimentamount += 2 //Boiling is a way of cooking grain without baking
				if(nutrimentamount > 0)
					if(nutrimentamount + pot.reagents.total_volume > pot.volume)
						to_chat(user, span_warning("[attachment] is full!"))
						return
					user.visible_message(span_info("[user] places [W] into the pot."))
					pot.reagents.add_reagent(/datum/reagent/consumable/nutriment, nutrimentamount)
					qdel(W)
				return
	*/


/obj/machinery/light/rogue/hearth/update_icon()
	cut_overlays()
	icon_state = "[base_state][on]"
	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan) || istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			var/obj/item/I = attachment
			I.pixel_x = 0
			I.pixel_y = 0
			add_overlay(new /mutable_appearance(I))
			if(food)
				I = food
				I.pixel_x = 0
				I.pixel_y = 0
				add_overlay(new /mutable_appearance(I))

/obj/machinery/light/rogue/hearth/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(attachment)
		if(istype(attachment, /obj/item/cooking/pan))
			if(food)
				if(!user.put_in_active_hand(food))
					food.forceMove(user.loc)
				food = null
				update_icon()
			else
				if(!user.put_in_active_hand(attachment))
					attachment.forceMove(user.loc)
				attachment = null
				update_icon()
		if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
			if(!user.put_in_active_hand(attachment))
				attachment.forceMove(user.loc)
			attachment = null
			update_icon()
	else
		if(on)
			var/mob/living/carbon/human/H = user
			if(istype(H))
				H.visible_message(span_info("[H] warms \his hand over the embers."))
				if(do_after(H, 50, target = src))
					var/obj/item/bodypart/affecting = H.get_bodypart((user.active_hand_index % 2 == 0) ? BODY_ZONE_R_ARM : BODY_ZONE_L_ARM)
					to_chat(H, span_warning("HOT!"))
					if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
						H.update_damage_overlays()
			return TRUE

/obj/machinery/light/rogue/hearth/process()
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()
	if(on)
		if(initial(fueluse) > 0)
			if(fueluse > 0)
				fueluse = max(fueluse - 10, 0)
			if(fueluse == 0)
				burn_out()
		if(attachment)
			if(istype(attachment, /obj/item/cooking/pan))
				if(food)
					var/obj/item/C = food.cooking(20, src)
					if(C)
						qdel(food)
						food = C
			if(istype(attachment, /obj/item/reagent_containers/glass/bucket/pot))
				var/obj/item/reagent_containers/glass/bucket/pot/P = attachment
				if(P.reagents)
					P.reagents.expose_temperature(400, 0.033)
					if(P.reagents.chem_temp >= T100C)
						if(!P.active)
							P.start_boiling()
		update_icon()


/obj/machinery/light/rogue/hearth/onkick(mob/user)
	if(isliving(user) && on)
		user.visible_message(span_warning("[user] snuffs [src]."))
		burn_out()

/obj/machinery/light/rogue/hearth/Destroy()
	. = ..()

/obj/machinery/light/rogue/campfire
	name = "campfire"
	icon_state = "badfire1"
	base_state = "badfire"
	density = FALSE
	layer = 2.8
	brightness = 5
	fueluse = 10 MINUTES
	bulb_colour = "#da5e21"
	cookonme = TRUE
	max_integrity = 30

/obj/machinery/light/rogue/campfire/process()
	..()
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()

/obj/machinery/light/rogue/campfire/onkick(mob/user)
	if(isliving(user) && on)
		var/mob/living/L = user
		L.visible_message(span_info("[L] snuffs [src]."))
		burn_out()

/obj/machinery/light/rogue/campfire/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(on)
		var/mob/living/carbon/human/H = user

		if(istype(H))
			H.visible_message(span_info("[H] warms \his hand near the fire."))

			if(do_after(H, 100, target = src))
				var/obj/item/bodypart/affecting = H.get_bodypart((user.active_hand_index % 2 == 0) ? BODY_ZONE_R_ARM : BODY_ZONE_L_ARM)
				to_chat(H, span_warning("HOT!"))
				if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
					H.update_damage_overlays()
		return TRUE //fires that are on always have this interaction with lmb unless its a torch

/obj/machinery/light/rogue/campfire/densefire
	icon_state = "densefire1"
	base_state = "densefire"
	density = TRUE
	layer = 2.8
	climbable = TRUE
	on = FALSE
	fueluse = 20 MINUTES
	pass_flags = LETPASSTHROW
	bulb_colour = "#eea96a"
	max_integrity = 60

/obj/machinery/light/rogue/campfire/densefire/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	if(mover.throwing)
		return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	if(locate(/obj/machinery/light/rogue/firebowl) in get_turf(mover))
		return 1
	return !density

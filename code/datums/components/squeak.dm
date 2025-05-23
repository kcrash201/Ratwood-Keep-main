/datum/component/squeak
	var/static/list/default_squeak_sounds = list('sound/blank.ogg'=1)
	var/list/override_squeak_sounds

	var/squeak_chance = 100
	var/volume = 30

	// This is so shoes don't squeak every step
	var/steps = 1
	var/step_delay = 0

	// This is to stop squeak spam from inhand usage
	var/last_use = 0
	var/use_delay = 20

/datum/component/squeak/Initialize(custom_sounds, volume_override, chance_override, step_delay_override, use_delay_override)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_BLOB_ACT, COMSIG_PARENT_ATTACKBY), PROC_REF(play_squeak))
	if(ismovableatom(parent))
		RegisterSignal(parent, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_IMPACT), PROC_REF(play_squeak))
		RegisterSignal(parent, COMSIG_MOVABLE_CROSSED, PROC_REF(play_squeak_crossed))
		RegisterSignal(parent, COMSIG_ITEM_WEARERCROSSED, PROC_REF(play_squeak_crossed))
		if(isitem(parent))
			RegisterSignal(parent, list(COMSIG_ITEM_ATTACK, COMSIG_ITEM_ATTACK_OBJ, COMSIG_ITEM_HIT_REACT), PROC_REF(play_squeak))
			RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(use_squeak))
			if(istype(parent, /obj/item/clothing))
				RegisterSignal(parent, COMSIG_CLOTHING_STEP_ACTION, PROC_REF(step_squeak))

	override_squeak_sounds = custom_sounds
	if(chance_override)
		squeak_chance = chance_override
	if(volume_override)
		volume = volume_override
	if(isnum(step_delay_override))
		step_delay = step_delay_override
	if(isnum(use_delay_override))
		use_delay = use_delay_override

/datum/component/squeak/proc/play_squeak()
	if(HAS_TRAIT(parent,TRAIT_LIGHT_STEP)) //Light Step now removes all armor sounds. This may need balancing.
		return FALSE
	if(prob(squeak_chance))
		if(!override_squeak_sounds)
			playsound(parent, pickweight(default_squeak_sounds), volume, FALSE, -1)
		else
			playsound(parent, pickweight(override_squeak_sounds), volume, FALSE, -1)

/datum/component/squeak/proc/step_squeak()
	if(steps > step_delay)
		play_squeak()
		steps = 0
	else
		steps++

/datum/component/squeak/proc/play_squeak_crossed(datum/source, atom/movable/AM)
	if(isitem(AM))
		var/obj/item/I = AM
		if(I.item_flags & ABSTRACT)
			return
		else if(istype(AM, /obj/projectile))
			var/obj/projectile/P = AM
			if(P.original != parent)
				return
	if(istype(AM, /obj/effect/dummy/phased_mob)) //don't squeek if they're in a phased/jaunting container.
		return
	if(ismob(AM))
		var/mob/M = AM
		if(M.is_floor_hazard_immune())
			return
	var/atom/current_parent = parent
	if(isturf(current_parent.loc))
		play_squeak()

/datum/component/squeak/proc/use_squeak()
	if(last_use + use_delay < world.time)
		last_use = world.time
		play_squeak()


/datum/component/squeak/proc/holder_dir_change(datum/source, old_dir, new_dir)
	//If the dir changes it means we're going through a bend in the pipes, let's pretend we bumped the wall
	if(old_dir != new_dir)
		play_squeak()

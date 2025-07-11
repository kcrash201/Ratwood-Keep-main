// simple is_type and similar inline helpers


#define in_range(source, user) (get_dist(source, user) <= 1 && (get_step(source, 0)?:z) == (get_step(user, 0)?:z))

#define ismovableatom(A) ismovable(A)


#define isatom(A) (isloc(A))

#define isweakref(D) (istype(D, /datum/weakref))

#define isdatum(D) (istype(D, /datum))
//Turfs
//#define isturf(A) (istype(A, /turf)) This is actually a byond built-in. Added here for completeness sake.

GLOBAL_LIST_INIT(turfs_without_ground, typecacheof(list(
	/turf/open/lava,
	/turf/open/water,
	/turf/open/transparent/openspace
	)))

GLOBAL_LIST_INIT(our_forest_sex, typecacheof(list(
	/area/rogue/outdoors/woods,
	/area/rogue/indoors/shelter/woods,
	/area/rogue/outdoors/river,
	/area/rogue/outdoors/bog,
	/area/rogue/indoors/shelter/bog,
	/area/rogue/outdoors/rtfield,
	/area/rogue/indoors/shelter/rtfield
	)))

GLOBAL_LIST_INIT(areas_in_town, typecacheof(list(
	/area/rogue/outdoors/town, 
	/area/rogue/indoors/town, 
	/area/rogue/indoors/shelter/town
	)))

#define isintown(A) (is_type_in_typecache(A, GLOB.areas_in_town))

#define isclient(A) istype(A, /client)

#define isforestsex(A) (is_type_in_typecache(A, GLOB.our_forest_sex))

#define isgroundlessturf(A) (is_type_in_typecache(A, GLOB.turfs_without_ground))

#define isopenturf(A) (istype(A, /turf/open))

#define isindestructiblefloor(A) (istype(A, /turf/open/indestructible))

#define isfloorturf(A) (istype(A, /turf/open/floor))

#define isclosedturf(A) (istype(A, /turf/closed))

#define isindestructiblewall(A) (istype(A, /turf/closed/indestructible))

#define iswallturf(A) (istype(A, /turf/closed/wall))

#define ismineralturf(A) (istype(A, /turf/closed/mineral))

#define islava(A) (istype(A, /turf/open/lava))

#define ischasm(A) (istype(A, /turf/open/chasm))

#define isplatingturf(A) (istype(A, /turf/open/floor/plating))

#define istransparentturf(A) (istype(A, /turf/open/transparent) || istype(A, /turf/closed/transparent))

//Mobs
#define isliving(A) (istype(A, /mob/living))

#define isbrain(A) (istype(A, /mob/living/brain))

//Carbon mobs
#define iscarbon(A) (istype(A, /mob/living/carbon))

#define ishuman(A) (istype(A, /mob/living/carbon/human))

#define iswerewolf(A) (istype(A, /mob/living/carbon/human/species/werewolf))

//Human sub-species
#define ishumanbasic(A) (is_species(A, /datum/species/human))
#define isvampire(A) (is_species(A,/datum/species/vampire))

//RT species
#define ishumannorthern(A) (is_species(A, /datum/species/human/northern))
#define isdwarf(A) (is_species(A, /datum/species/dwarf))
#define isdwarfmountain(A) (is_species(A, /datum/species/dwarf/mountain))
#define iself(A) (is_species(A, /datum/species/elf))
#define isdarkelf(A) (is_species(A, /datum/species/elf/dark))
#define iswoodelf(A) (is_species(A, /datum/species/elf/wood))
#define ishalfelf(A) (is_species(A, /datum/species/human/halfelf))
#define istiefling(A) (is_species(A, /datum/species/tieberian))
#define ishalforc(A) (is_species(A, /datum/species/halforc))
#define isgoblinp(A) (is_species(A, /datum/species/goblinp))
#define isseelie(A) (is_species(A, /datum/species/seelie))

//furry species
#define isaxian(A) (is_species(A, /datum/species/axian))
#define isanthromorph(A) (is_species(A, /datum/species/anthromorph))
#define isanthromorphsmall(A) (is_species(A, /datum/species/anthromorphsmall))
#define isdemihuman(A) (is_species(A, /datum/species/demihuman))
#define isdracon(A) (is_species(A, /datum/species/dracon))
#define iskobold(A) (is_species(A, /datum/species/kobold))
#define islizardfolk(A) (is_species(A, /datum/species/lizardfolk))
#define islupian(A) (is_species(A, /datum/species/lupian))
#define istabaxi(A) (is_species(A, /datum/species/tabaxi))
#define isvulpkanin(A) (is_species(A, /datum/species/vulpkanin))
#define ismoth(A) (is_species(A, /datum/species/moth))

//more carbon mobs
#define ismonkey(A) (istype(A, /mob/living/carbon/monkey))

#define istruedevil(A) (istype(A, /mob/living/carbon/true_devil))

//Simple animals
#define isanimal(A) (istype(A, /mob/living/simple_animal))

#define isshade(A) (istype(A, /mob/living/simple_animal/shade))

#define ismouse(A) (istype(A, /mob/living/simple_animal/mouse))

#define iscow(A) (istype(A, /mob/living/simple_animal/cow))

#define iscat(A) (istype(A, /mob/living/simple_animal/pet/cat))

#define isdog(A) (istype(A, /mob/living/simple_animal/pet/dog))

#define iscorgi(A) (istype(A, /mob/living/simple_animal/pet/dog/corgi))

#define ishostile(A) (istype(A, /mob/living/simple_animal/hostile))

#define isclown(A) (istype(A, /mob/living/simple_animal/hostile/retaliate/clown))


//Misc mobs
#define isobserver(A) (istype(A, /mob/dead/observer))

#define isrogueobserver(A) (istype(A, /mob/dead/observer/rogue))

#define isadminobserver(A) (istype(A, /mob/dead/observer/admin))

#define isroguespirit(A) (istype(A, /mob/living/carbon/spirit)) //underworld spirit 

#define isdead(A) (istype(A, /mob/dead))

#define isnewplayer(A) (istype(A, /mob/dead/new_player))

#define isovermind(A) (istype(A, /mob/camera/blob))

#define iscameramob(A) (istype(A, /mob/camera))

#define isaicamera(A) (istype(A, /mob/camera/aiEye))

//Objects
#define isobj(A) istype(A, /obj) //override the byond proc because it returns true on children of /atom/movable that aren't objs

#define isitem(A) (istype(A, /obj/item))

#define isidcard(I) (istype(I, /obj/item/card/id))

#define isstructure(A) (istype(A, /obj/structure))

#define ismachinery(A) (istype(A, /obj/machinery))

#define is_cleanable(A) (istype(A, /obj/effect/decal/cleanable)) //if something is cleanable

#define isorgan(A) (istype(A, /obj/item/organ))

#define isclothing(A) (istype(A, /obj/item/clothing))

#define iscash(A) (istype(A, /obj/item/stack/spacecash) || istype(A, /obj/item/holochip))

GLOBAL_LIST_INIT(pointed_types, typecacheof(list(
	/obj/item/kitchen/fork)))

#define is_pointed(W) (is_type_in_typecache(W, GLOB.pointed_types))

#define isbodypart(A) (istype(A, /obj/item/bodypart))

#define isprojectile(A) (istype(A, /obj/projectile))

#define isgun(A) (istype(A, /obj/item/gun))


#define iseffect(O) (istype(O, /obj/effect))

#define isblobmonster(O) (istype(O, /mob/living/simple_animal/hostile/blob))


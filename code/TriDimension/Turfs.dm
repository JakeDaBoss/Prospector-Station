/turf/simulated/floor/open
	name = "open space"
	intact = 0
	density = 0
	icon_state = "black"
	pathweight = 100000 //Seriously, don't try and path over this one numbnuts
	var/icon/darkoverlays = null
	var/turf/floorbelow
	var/list/overlay_references

	New()
		..()
		getbelow()
		return

	Enter(var/atom/movable/AM)
		if (..()) //TODO make this check if gravity is active (future use) - Sukasa
			spawn(1)
				// only fall down in defined areas (read: areas with artificial gravitiy)
				if(!floorbelow) //make sure that there is actually something below
					if(!getbelow())
						return
				if(AM)
					var/area/areacheck = get_area(src)
					var/blocked = 0
					var/soft = 0
					for(var/atom/A in floorbelow.contents)
						if(A.density)
							if(istype(A, /obj/structure/window))
								var/obj/structure/window/W = A
								blocked = W.is_fulltile()
								if(blocked)
									break
							else
								blocked = 1
								break
						if(istype(A, /obj/machinery/atmospherics/pipe/zpipe/up) && istype(AM,/obj/item/pipe))
							blocked = 1
							break
						if(istype(A, /obj/structure/disposalpipe/up) && istype(AM,/obj/item/pipe))
							blocked = 1
							break
						if(istype(A, /obj/multiz/stairs))
							soft = 1
							//dont break here, since we still need to be sure that it isnt blocked


					if (soft || (!blocked && !(areacheck.name == "Space")))
						var/mob/living/carbon/C = null
						if(iscarbon(AM))
							C = AM
						var/obj/P = null//pulled object
						var/mob/PM = null//pulled mob
						var/PO = 0 //pulling object?
						var/obj/item/weapon/grab/grab = null //for grabbed mobs
						var/GM = 0 // grabed mob check
						if (C && C.back && istype(C.back, /obj/item/weapon/tank/jetpack))
							var/obj/item/weapon/tank/jetpack/J = C.back
							if (J.on == 1)
								return
						if(C && C.pulling) //check if they are pulling something
							if(istype(C.pulling, /obj))
								P = C.pulling
								PO = 1
							if(istype(C.pulling, /mob))
								PM = C.pulling
								PO = 1
						if(C)
							for(var/obj/item/weapon/W in C.contents)
								if(istype(W,/obj/item/weapon/grab))
									GM = 1
									grab = W
						AM.Move(floorbelow)
						if(PO == 1) //pulling something? make sure to move it down and reset the pulled/pulling vars of both
									//a little hackish but it will work
							if(P)
								P.loc = C.loc
								C.start_pulling(P)
							if(PM)
								PM.loc = C.loc
								C.start_pulling(PM)
						if(GM == 1)
							grab.affecting.loc = C.loc
						if (!soft && istype(AM, /mob/living/carbon/human))
							dofalldamage(AM)
						if(!soft && PM) //applies damage to pulling mobs(humans only) that fall down
							if(istype(PM, /mob/living/carbon/human))
								dofalldamage(PM)
						if(!soft && GM) //applies damage to grabbed mobs(humans only) that fall down
							if(istype(grab.affecting, /mob/living/carbon/human))
								dofalldamage(grab.affecting)


		return ..()

/turf/proc/dofalldamage(var/AM)
	var/mob/living/carbon/human/H = AM
	var/damage = 5
	if(H.species.falldmg == 1)
		damage = 3
		H.apply_damage((6), BRUTE, "l_leg")
		H.apply_damage((6), BRUTE, "r_leg")
	if(H.species.name == "Machine")
		for(var/datum/organ/external/O in H.organs)
			if(istype(O ,/datum/organ/external/r_leg)||istype(O,/datum/organ/external/l_leg))
				O.droplimb(1)
	else
		H.apply_damage((10), BRUTE, "l_leg")
		H.apply_damage((10), BRUTE, "r_leg")

	H.apply_damage((damage), BRUTE, "head")
	H.apply_damage((damage), BRUTE, "chest")
	H.apply_damage((damage), BRUTE, "l_arm")
	H.apply_damage((damage), BRUTE, "r_arm")
	H:weakened = max(H:weakened,2)
	H:updatehealth()


/turf/proc/hasbelow()
	var/turf/controllerlocation = locate(1, 1, z)
	for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
		if(controller.down)
			return 1
	return 0

/turf/simulated/floor/open/proc/getbelow()
	var/turf/controllerlocation = locate(1, 1, z)
	for(var/obj/effect/landmark/zcontroller/controller in controllerlocation)
		// check if there is something to draw below
		if(!controller.down)
			src.ChangeTurf(/turf/space)
			return 0
		else
			floorbelow = locate(src.x, src.y, controller.down_target)
			return 1
	return 1

// override to make sure nothing is hidden
/turf/simulated/floor/open/levelupdate()
	for(var/obj/O in src)
		if(O.level == 1)
			O.hide(0)

//overwrite the attackby of space to transform it to openspace if necessary
/turf/space/attackby(obj/item/C as obj, mob/user as mob)
	if (istype(C, /obj/item/stack/cable_coil) && src.hasbelow())
		var/turf/simulated/floor/open/W = src.ChangeTurf(/turf/simulated/floor/open)
		W.attackby(C, user)
		return
	..()

/turf/simulated/floor/open/ex_act(severity)
	// cant destroy empty space with an ordinary bomb
	return

/turf/simulated/floor/open/attackby(obj/item/C as obj, mob/user as mob)
	(..)
	if (istype(C, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/cable = C
		cable.turf_place(src, user)
		return

	if (istype(C, /obj/item/stack/rods))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			return
		var/obj/item/stack/rods/R = C
		if (R.use(1))
			user << "\blue Constructing support lattice ..."
			playsound(src.loc, 'sound/weapons/Genhit.ogg', 50, 1)
			ReplaceWithLattice()
		return

	if (istype(C, /obj/item/stack/tile/plasteel))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			if (S.get_amount() < 1)
				return
			del(L)
			playsound(src.loc, 'sound/weapons/Genhit.ogg', 50, 1)
			S.build(src)
			S.use(1)
			return
		else
			user << "\red The plating is going to need some support."
	return

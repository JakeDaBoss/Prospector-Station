/obj/item/clothing/glasses
	name = "glasses"
	icon = 'icons/obj/clothing/glasses.dmi'
	//w_class = 2.0
	//flags = GLASSESCOVERSEYES
	//slot_flags = SLOT_EYES
	//var/vision_flags = 0
	//var/darkness_view = 0//Base human is 2
	//var/invisa_view = 0
	var/prescription = 0
	var/prescription_upgradable = 0
	var/toggleable = 0
	var/active = 1
	var/obj/screen/overlay = null
	body_parts_covered = EYES

/obj/item/clothing/glasses/New()
	. = ..()
	if(prescription_upgradable && prescription)
		// Pre-upgraded upgradable glasses
		name = "prescription [name]"

/obj/item/clothing/glasses/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if (user.stat || user.restrained() || !ishuman(user))
		return ..()
	var/mob/living/carbon/human/H = user
	if(prescription_upgradable)
		if(istype(O, /obj/item/clothing/glasses/regular))
			if(prescription)
				H << "You can't possibly imagine how adding more lenses would improve \the [name]."
				return
			H.unEquip(O)
			O.loc = src // Store the glasses for later removal
			H << "You fit \the [name] with lenses from \the [O]."
			prescription = 1
			name = "prescription [name]"
			return
		if(prescription && istype(O, /obj/item/weapon/screwdriver))
			var/obj/item/clothing/glasses/regular/G = locate() in src
			if(!G)
				G = new(get_turf(H))
			H << "You salvage the prescription lenses from \the [name]."
			prescription = 0
			name = initial(name)
			H.put_in_hands(G)
			return
	return ..()

/obj/item/clothing/glasses/attack_self(mob/user)
	if(toggleable)
		if(active)
			active = 0
			icon_state = "degoggles"
			user.update_inv_glasses()
			usr << "You deactivate the optical matrix on the [src]."
		else
			active = 1
			icon_state = initial(icon_state)
			user.update_inv_glasses()
			usr << "You activate the optical matrix on the [src]."

/obj/item/clothing/glasses/meson
	name = "Optical Meson Scanner"
	desc = "Used for seeing walls, floors, and stuff through anything."
	icon_state = "meson"
	item_state = "glasses"
	icon_action_button = "action_meson" //This doesn't actually matter, the action button is generated from the current icon_state. But, this is the only way to get it to show up.
	origin_tech = "magnets=2;engineering=2"
	toggleable = 1
	prescription_upgradable = 1
	vision_flags = SEE_TURFS

/obj/item/clothing/glasses/meson/New()
	..()
	overlay = global_hud.meson

/obj/item/clothing/glasses/meson/prescription
	prescription = 1

/obj/item/clothing/glasses/meson/cyber
	name = "Eye Replacement Implant"
	desc = "An implanted replacement for a left eye with meson vision capabilities."
	icon_state = "cybereye-green"
	item_state = "eyepatch"
	canremove = 0
	prescription_upgradable = 0

/obj/item/clothing/glasses/science
	name = "Science Goggles"
	desc = "The goggles do nothing!"
	icon_state = "purple"
	item_state = "glasses"

/obj/item/clothing/glasses/science/prescription
	prescription = 1

/obj/item/clothing/glasses/science/New()
	..()
	overlay = global_hud.science

/obj/item/clothing/glasses/night
	name = "Night Vision Goggles"
	desc = "You can totally see in the dark now!"
	icon_state = "night"
	item_state = "glasses"
	origin_tech = "magnets=2"
	prescription_upgradable = 0
	darkness_view = 7

/obj/item/clothing/glasses/night
	prescription = 1

/obj/item/clothing/glasses/night/New()
	..()
	overlay = global_hud.nvg

/obj/item/clothing/glasses/night/alien
	name = "Alien thermal lenses"
	desc = "Weird alien lenses"
	icon_state = ""
	vision_flags = SEE_MOBS
	invisa_view = 2
	species_restricted = list("Xenomorph Drone","Xenomorph Hunter","Xenomorph Sentinel","Xenomorph Queen")

/obj/item/clothing/glasses/night/alien/New()
	..()
	overlay = global_hud.thermal


/obj/item/clothing/glasses/eyepatch
	name = "eyepatch"
	desc = "Yarr."
	icon_state = "eyepatch"
	item_state = "eyepatch"
	body_parts_covered = 0

/obj/item/clothing/glasses/monocle
	name = "monocle"
	desc = "Such a dapper eyepiece!"
	icon_state = "monocle"
	item_state = "headset" // lol
	body_parts_covered = 0

/obj/item/clothing/glasses/material
	name = "Optical Material Scanner"
	desc = "Very confusing glasses."
	icon_state = "material"
	item_state = "glasses"
	icon_action_button = "action_material"
	origin_tech = "magnets=3;engineering=3"
	toggleable = 1
	vision_flags = SEE_OBJS

/obj/item/clothing/glasses/material/cyber
	name = "Eye Replacement Implant"
	desc = "An implanted replacement for a left eye with material vision capabilities."
	icon_state = "cybereye-blue"
	item_state = "eyepatch"
	canremove = 0

/obj/item/clothing/glasses/regular
	name = "Prescription Glasses"
	desc = "Made by Nerd. Co."
	icon_state = "glasses"
	item_state = "glasses"
	prescription = 1
	body_parts_covered = 0

/obj/item/clothing/glasses/regular/hipster
	name = "Prescription Glasses"
	desc = "Made by Uncool. Co."
	icon_state = "hipster_glasses"
	item_state = "hipster_glasses"

/obj/item/clothing/glasses/threedglasses
	desc = "A long time ago, people used these glasses to makes images from screens threedimensional."
	name = "3D glasses"
	icon_state = "3d"
	item_state = "3d"
	body_parts_covered = 0

/obj/item/clothing/glasses/gglasses
	name = "Green Glasses"
	desc = "Forest green glasses, like the kind you'd wear when hatching a nasty scheme."
	icon_state = "gglasses"
	item_state = "gglasses"
	body_parts_covered = 0

/obj/item/clothing/glasses/sunglasses
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks many flashes."
	name = "sunglasses"
	icon_state = "sun"
	item_state = "sunglasses"
	prescription_upgradable = 1
	darkness_view = -1

/obj/item/clothing/glasses/welding
	name = "welding goggles"
	desc = "Protects the eyes from welders, approved by the mad scientist association."
	icon_state = "welding-g"
	item_state = "welding-g"
	icon_action_button = "action_welding_g"
	var/up = 0

/obj/item/clothing/glasses/welding/attack_self()
	toggle()


/obj/item/clothing/glasses/welding/verb/toggle()
	set category = "Object"
	set name = "Adjust welding goggles"
	set src in usr

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(src.up)
			src.up = !src.up
			src.flags |= GLASSESCOVERSEYES
			flags_inv |= HIDEEYES
			body_parts_covered |= EYES
			icon_state = initial(icon_state)
			usr << "You flip \the [src] down to protect your eyes."
		else
			src.up = !src.up
			src.flags &= ~HEADCOVERSEYES
			flags_inv &= ~HIDEEYES
			body_parts_covered &= ~EYES
			icon_state = "[initial(icon_state)]up"
			usr << "You push \the [src] up out of your face."

		update_clothing_icon()

/obj/item/clothing/glasses/welding/superior
	name = "superior welding goggles"
	desc = "Welding goggles made from more expensive materials, strangely smells like potatoes."
	icon_state = "rwelding-g"
	item_state = "rwelding-g"
	icon_action_button = "action_welding_g"

/obj/item/clothing/glasses/sunglasses/blindfold
	name = "blindfold"
	desc = "Covers the eyes, preventing sight."
	icon_state = "blindfold"
	item_state = "blindfold"
	prescription_upgradable = 0
	//vision_flags = BLIND  	// This flag is only supposed to be used if it causes permanent blindness, not temporary because of glasses

/obj/item/clothing/glasses/sunglasses/prescription
	prescription = 1

/obj/item/clothing/glasses/sunglasses/big
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Larger than average enhanced shielding blocks many flashes."
	icon_state = "bigsunglasses"
	item_state = "bigsunglasses"

/obj/item/clothing/glasses/sunglasses/sechud
	name = "HUDSunglasses"
	desc = "Sunglasses with a HUD."
	icon_state = "sunhud"
	prescription_upgradable = 0
	var/obj/item/clothing/glasses/hud/security/hud = null

	New()
		..()
		src.hud = new/obj/item/clothing/glasses/hud/security(src)
		return

/obj/item/clothing/glasses/sunglasses/sechud/prescription
	prescription = 1

	New()
		..()
		src.hud = new/obj/item/clothing/glasses/hud/security(src)
		return

/obj/item/clothing/glasses/sunglasses/sechud/tactical
	name = "tactical HUD"
	desc = "Flash-resistant goggles with inbuilt combat and security information."
	icon_state = "swatgoggles"

/obj/item/clothing/glasses/thermal
	name = "Optical Thermal Scanner"
	desc = "Thermals in the shape of glasses."
	icon_state = "thermal"
	item_state = "glasses"
	origin_tech = "magnets=3"
	toggleable = 1
	vision_flags = SEE_MOBS
	invisa_view = 2

	emp_act(severity)
		if(istype(src.loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/M = src.loc
			M << "\red The Optical Thermal Scanner overloads and blinds you!"
			if(M.glasses == src)
				M.eye_blind = 3
				M.eye_blurry = 5
				M.disabilities |= NEARSIGHTED
				spawn(100)
					M.disabilities &= ~NEARSIGHTED
		..()

/obj/item/clothing/glasses/thermal/New()
	..()
	overlay = global_hud.thermal

/obj/item/clothing/glasses/thermal/syndi	//These are now a traitor item, concealed as mesons.	-Pete
	name = "Optical Meson Scanner"
	desc = "Used for seeing walls, floors, and stuff through anything."
	icon_state = "meson"
	icon_action_button = "action_meson"
	origin_tech = "magnets=3;syndicate=4"

/obj/item/clothing/glasses/thermal/monocle
	name = "Thermoncle"
	desc = "A monocle thermal."
	icon_state = "thermoncle"
	flags = null //doesn't protect eyes because it's a monocle, duh
	toggleable = 0
	body_parts_covered = 0

/obj/item/clothing/glasses/thermal/eyepatch
	name = "Optical Thermal Eyepatch"
	desc = "An eyepatch with built-in thermal optics"
	icon_state = "eyepatch"
	item_state = "eyepatch"
	toggleable = 0
	body_parts_covered = 0

/obj/item/clothing/glasses/thermal/jensen
	name = "Optical Thermal Implants"
	desc = "A set of implantable lenses designed to augment your vision"
	icon_state = "thermalimplants"
	item_state = "syringe_kit"
	toggleable = 0

/obj/item/clothing/glasses/thermal/cyber
	name = "Eye Replacement Implant"
	desc = "An implanted replacement for a left eye with thermal vision capabilities."
	icon_state = "cybereye-red"
	item_state = "eyepatch"
	canremove = 0
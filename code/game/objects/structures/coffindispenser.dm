/obj/structure/Coffin_Dispenser
	name = "Coffin Dispenser"
	icon = 'icons/obj/coffindispenser.dmi'
	desc = "A Coffin despenser it can be refilled by adding wood!"
	icon_state = "cd0"
	anchored = 1
	density = 0
	var/numofcoffins = 0


/obj/structure/Coffin_Dispenser/New()
	numofcoffins = 6
	icon_state = "cdf"
	update_icon()



/obj/structure/Coffin_Dispenser/attack_hand(mob/user as mob)
	dispensecoffin()
/obj/structure/Coffin_Dispenser/attack_robot(mob/user as mob)
	if(Adjacent(user))
		return src.attack_hand(user)
	else
		user << "<span class = \"warning\">You attempt to interface with the control circuits but find they are not connected to your network.  Maybe in a future firmware update.</span>"
	return



/obj/structure/Coffin_Dispenser/proc/dispensecoffin()
	for(var/obj/structure/closet/coffin/C in src.loc.contents)
		usr << "\red Cannot dispense due to a coffin in dispensing area."
		return
	if(numofcoffins == 0)
		usr << "\red Out of Coffins please refill dispenser with wood."
		return
	if(numofcoffins >= 1)
		var/obj/structure/closet/coffin/D = new /obj/structure/closet/coffin(src.loc)
		D.opened = 1
		D.density = 0
		D.update_icon()
		numofcoffins--
		update_icon()
		return

/obj/structure/Coffin_Dispenser/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/stack/sheet/wood))
		var/obj/item/stack/sheet/wood/D = W
		if(src.numofcoffins >=6)
			user << "\red The [src] is full."
			return
		if(D.amount >=5)
			D.use(5)
			numofcoffins++
			update_icon()
			user << "\blue You add enough wood for one coffin to the dispenser."
		else
			user << "\red not enough Wood you need 5 sheets per coffin."
			return

/obj/structure/Coffin_Dispenser/update_icon()
	icon_state ="cd[numofcoffins]"



/obj/structure/Rollerbed_Dispenser
	name = "Rollerbed Dispenser"
	icon = 'icons/obj/coffindispenser.dmi'
	desc = "A rollerbed dispenser!"
	icon_state = "rbd0"
	anchored = 1
	density = 0
	var/numofRB = 0


/obj/structure/Rollerbed_Dispenser/New()
	numofRB = 8
	icon_state = "rbd8"
	update_icon()



/obj/structure/Rollerbed_Dispenser/attack_hand(mob/user as mob)
	dispenseRB()

/obj/structure/Rollerbed_Despenser/attack_robot(mob/user as mob)
	if(Adjacent(user))
		return src.attack_hand(user)
	else
		user << "<span class = \"warning\">You attempt to interface with the control circuits but find they are not connected to your network.  Maybe in a future firmware update.</span>"
	return

/obj/structure/Rollerbed_Dispenser/proc/dispenseRB()
	for(var/obj/structure/bed/roller/C in src.loc.contents)
		usr << "\red Cannot dispense due to a rollerbed in dispensing area."
		return
	if(numofRB == 0)
		usr << "\red Out of Rollerbeds please refill."
		return
	if(numofRB >= 1)
		new /obj/structure/bed/roller(src.loc)
		numofRB--
		update_icon()
		return

/obj/structure/Rollerbed_Dispenser/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/roller))
		var/obj/item/roller/D = W
		if(src.numofRB >=8)
			user << "\red The [src] is full."
			return
		else
			del(D)
			numofRB++
			update_icon()
			user << "\blue You add a rollerbed to the dispenser."

/obj/structure/Rollerbed_Dispenser/update_icon()
	icon_state ="rbd[numofRB]"


/obj/structure/Wheelchair_Dispenser
	name = "Wheelchair Dispenser"
	icon = 'icons/obj/coffindispenser.dmi'
	desc = "A wheelchair dispenser!"
	icon_state = "wcd0"
	anchored = 1
	density = 0
	var/numofWC = 0


/obj/structure/Wheelchair_Dispenser/New()
	numofWC = 6
	icon_state = "wcd6"
	update_icon()



/obj/structure/Wheelchair_Dispenser/attack_hand(mob/user as mob)
	dispenseWC()

/obj/structure/Wheelchair_Dispenser/attack_robot(mob/user as mob)
	if(Adjacent(user))
		return src.attack_hand(user)
	else
		user << "<span class = \"warning\">You attempt to interface with the control circuits but find they are not connected to your network.  Maybe in a future firmware update.</span>"
	return

/obj/structure/Wheelchair_Dispenser/proc/dispenseWC()
	for(var/obj/structure/bed/chair/wheelchair/C in src.loc.contents)
		usr << "\red Cannot despense due to a Wheelchair in dispensing area."
		return
	if(numofWC == 0)
		usr << "\red Out of Wheelchairs please refill."
		return
	if(numofWC >= 1)
		new /obj/structure/bed/chair/wheelchair(src.loc)
		numofWC--
		update_icon()
		return

/obj/structure/Wheelchair_Dispenser/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/structure/bed/chair/wheelchair))
		var/obj/structure/bed/chair/wheelchair/D = W
		if(src.numofWC >=6)
			user << "\red The [src] is full."
			return
		else
			del(D)
			numofWC++
			update_icon()
			user << "\blue You add a wheelchair to the dispenser."

/obj/structure/Wheelchair_Dispenser/update_icon()
	icon_state ="wcd[numofWC]"



/obj/structure/Bodybag_Dispenser
	name = "Bodybag Dispenser"
	icon = 'icons/obj/coffindispenser.dmi'
	desc = "A bodybag dispenser!"
	icon_state = "bbd0"
	anchored = 1
	density = 0
	var/numofBB = 0


/obj/structure/Bodybag_Dispenser/New()
	numofBB = 8
	icon_state = "bbd8"
	update_icon()



/obj/structure/Bodybag_Dispenser/attack_hand(mob/user as mob)
	dispenseBB()



/obj/structure/Bodybag_Dispenser/proc/dispenseBB()
	if(numofBB == 0)
		usr << "\red Out of Bodybags please refill."
		return
	if(numofBB >= 1)
		new /obj/item/bodybag(src.loc)
		numofBB--
		update_icon()
		return

/obj/structure/Bodybag_Dispenser/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/bodybag))
		var/obj/item/bodybag/D = W
		if(src.numofBB >=8)
			user << "\red The [src] is full."
			return
		else
			del(D)
			numofBB++
			update_icon()
			user << "\blue You add a bodybag to the dispenser."

/obj/structure/Bodybag_Dispenser/update_icon()
	icon_state ="bbd[numofBB]"
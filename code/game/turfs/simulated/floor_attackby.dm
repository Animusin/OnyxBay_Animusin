/turf/simulated/floor/attackby(obj/item/C as obj, mob/user as mob)
	if(atom_flags & ATOM_FLAG_NO_DECONSTRUCTION)
		return

	if(!C || !user)
		return 0

	if(isCoil(C) || (flooring && istype(C, /obj/item/stack/rods)))
		return ..(C, user)

	if(user.a_intent != I_HELP)
		return 0

	if(flooring)
		if(isCrowbar(C))
			if(broken || burnt)
				to_chat(user, "<span class='notice'>You remove the broken [flooring.descriptor].</span>")
				make_plating()
			else if(flooring.flags & TURF_IS_FRAGILE)
				to_chat(user, "<span class='danger'>You forcefully pry off the [flooring.descriptor], destroying them in the process.</span>")
				make_plating()
			else if(flooring.flags & TURF_REMOVE_CROWBAR)
				to_chat(user, "<span class='notice'>You lever off the [flooring.descriptor].</span>")
				make_plating(1)
			else
				return
			playsound(src, 'sound/items/Crowbar.ogg', 80, 1)
			color = null
			return
		else if(isScrewdriver(C) && (flooring.flags & TURF_REMOVE_SCREWDRIVER))
			if(broken || burnt)
				return
			to_chat(user, "<span class='notice'>You unscrew and remove the [flooring.descriptor].</span>")
			make_plating(1)
			color = null
			playsound(src, 'sound/items/Screwdriver.ogg', 80, 1)
			return
		else if(isWrench(C) && (flooring.flags & TURF_REMOVE_WRENCH))
			to_chat(user, "<span class='notice'>You unwrench and remove the [flooring.descriptor].</span>")
			make_plating(1)
			color = null
			playsound(src, 'sound/items/Ratchet.ogg', 80, 1)
			return
		else if(istype(C, /obj/item/shovel) && (flooring.flags & TURF_REMOVE_SHOVEL))
			to_chat(user, "<span class='notice'>You shovel off the [flooring.descriptor].</span>")
			make_plating(1)
			color = null
			playsound(src, 'sound/items/Deconstruct.ogg', 80, 1)
			return
		else if(isCoil(C))
			to_chat(user, "<span class='warning'>You must remove the [flooring.descriptor] first.</span>")
			return
	else

		if(istype(C, /obj/item/stack))
			if(broken || burnt)
				to_chat(user, "<span class='warning'>This section is too damaged to support anything. Use a welder to fix the damage.</span>")
				return
			//first check, catwalk? Else let flooring do its thing
			if(locate(/obj/structure/catwalk, src))
				return
			if (istype(C, /obj/item/stack/rods))
				var/obj/item/stack/rods/R = C
				if (R.use(2))
					playsound(src, 'sound/effects/fighting/Genhit.ogg', 50, 1)
					new /obj/structure/catwalk(src)
				return
			var/obj/item/stack/S = C
			var/decl/flooring/use_flooring
			for(var/flooring_type in flooring_types)
				var/decl/flooring/F = flooring_types[flooring_type]
				if(!F.build_type)
					continue
				if(ispath(S.type, F.build_type) || ispath(S.build_type, F.build_type))
					use_flooring = F
					break
			if(!use_flooring)
				return
			// Do we have enough?
			if(use_flooring.build_cost && S.get_amount() < use_flooring.build_cost)
				to_chat(user, "<span class='warning'>You require at least [use_flooring.build_cost] [S.name] to complete the [use_flooring.descriptor].</span>")
				return
			// Stay still and focus...
			if(use_flooring.build_time && !do_after(user, use_flooring.build_time, src))
				return
			if(flooring || !S || !user || !use_flooring)
				return

			if(S.use(use_flooring.build_cost))
				set_flooring(use_flooring)
				if (S.color)
					src.color = S.color
				var/obj/item/stack/tile/F = null
				if (istype(S,/obj/item/stack/tile))
					F = S
					if(F.stored_decals)
						src.decals = F.stored_decals
				src.update_icon()
				playsound(src, 'sound/items/Deconstruct.ogg', 80, 1)
				return

		// Repairs and Deconstruction.
		else if(isCrowbar(C))
			if(broken || burnt)
				var/turf/T = GetBelow(src)
				if(T)
					if(T.density)
						to_chat(user, SPAN("notice", "It looks like there's a solid wall underneath the plating!"))
						return
					T.visible_message(SPAN("warning", "The ceiling above looks as if it's being pried off."))
				playsound(src, 'sound/items/Crowbar.ogg', 80, 1)
				visible_message(SPAN("notice", "[user] has begun prying off the damaged plating."))
				if(do_after(user, 10 SECONDS, luck_check_type = LUCK_CHECK_ENG))
					if(!istype(src, /turf/simulated/floor))
						return
					if(!broken && !burnt || !is_plating())
						return
					visible_message(SPAN("warning", "[user] has pried off the damaged plating."))
					if(istype(src, /turf/simulated/floor/plating))
						var/turf/simulated/floor/plating/P = src
						new P.tile_type(src)
					else
						new /obj/item/stack/tile/floor(src)
					color = null
					ReplaceWithLattice()
					playsound(src, 'sound/items/Deconstruct.ogg', 80, 1)
					if(T)
						T.visible_message(SPAN("danger", "The ceiling above has been pried off!"))
			return

		else if(isWelder(C))
			var/obj/item/weldingtool/welder = C
			if((is_plating()))
				if(broken || burnt)
					if(welder.use_tool(src, user, amount = 1))
						to_chat(user, "<span class='notice'>You fix some dents on the broken plating.</span>")
						playsound(src, 'sound/items/Welder.ogg', 80, 1)
						icon_state = base_icon_state
						burnt = null
						broken = null
				else
					visible_message("<span class='notice'>[user] has started melting the plating's reinforcements!</span>")
					if(!welder.use_tool(src, user, delay = 5 SECONDS, amount = 5))
						return

					if(QDELETED(src) || !user)
						return

					visible_message("<span class='warning'>[user] has melted the plating's reinforcements! It should be possible to pry it off.</span>")
					burnt = 1
					remove_decals()
					update_icon()

	return ..()

/turf/simulated/floor/acid_melt()
	. = FALSE
	var/turf/T = GetBelow(src)

	if(flooring)
		visible_message("<span class='alium'>The acid dissolves the [flooring.descriptor]!</span>")
		make_plating()

	else if(is_plating() && !(broken || burnt))
		playsound(src, 'sound/items/Welder.ogg', 80, 1)
		visible_message("<span class='alium'>The acid has started melting \the [name]'s reinforcements!</span>")
		if(T)
			T.audible_message("<span class='warning'>A strange sizzling noise eminates from the ceiling.</span>", splash_override = "*sizzle*")
		burnt = 1
		remove_decals()
		update_icon()

	else if(broken || burnt)
		if(acid_melted == 0)
			visible_message("<span class='alium'>The acid has melted the plating's reinforcements! It's about to break through!.</span>")
			playsound(src, 'sound/items/Welder.ogg', 80, 1)

			if(T)
				T.visible_message("<span class='warning'>A strange substance drips from the ceiling, dropping below with a sizzle.</span>")
			acid_melted++
		else
			visible_message("<span class='danger'>The acid melts the plating away into nothing!</span>")
			new /obj/item/stack/tile/floor(src)
			src.ReplaceWithLattice()
			playsound(src, 'sound/items/Deconstruct.ogg', 80, 1)
			if(T)
				T.visible_message("<span class='danger'>The ceiling above melts away!</span>")
			. = TRUE
			qdel(src)
	else
		return TRUE

/turf/simulated/floor/can_build_cable(mob/user)
	if(!is_plating() || flooring)
		to_chat(user, "<span class='warning'>Removing the tiling first.</span>")
		return 0
	if(broken || burnt)
		to_chat(user, "<span class='warning'>This section is too damaged to support anything. Use a welder to fix the damage.</span>")
		return 0
	return 1

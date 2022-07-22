// Make a vampire, add initial powers.
/mob/proc/make_vampire()
	if (!mind)
		return
	if (!mind.vampire)
		mind.vampire = new /datum/vampire()
	// No powers to thralls. Ew.
	if (mind.vampire.status & VAMP_ISTHRALL)
		return

	if(!vampirepowers.len)
		for(var/P in vampirepower_types)
			vampirepowers += new P()

	if (ishuman(src))
		var/mob/living/carbon/human/H = src
		H.reagents.add_reagent(/datum/reagent/vampiric_blood, 30)
		mind.vampire.blood_usable = H.reagents.get_reagent_amount(/datum/reagent/vampiric_blood)
		
	
	verbs += /datum/game_mode/vampire/verb/vampire_help

	for(var/datum/power/vampire/P in vampirepowers)
		if(!(P in mind.vampire.purchased_powers))
			if(!P.blood_cost)
				mind.vampire.add_power(mind, P, 0)
		else if(P.is_active && P.verbpath)
			verbs += P.verbpath
	vampire_dying(src)		
	return TRUE

/mob/proc/vampire_dying()
	if (ishuman(src))
		var/mob/living/carbon/human/H = src
		for(var/obj/item/organ/org in H.internal_organs)
			if(!(org.organ_tag == BP_BRAIN || org.organ_tag == BP_EYES))
				org.vital = 0
				org.die() //organ murder
		H.remove_blood(H.vessel.get_reagent_amount(/datum/reagent/blood))   //blood delete
		H.does_not_breathe = TRUE
	return TRUE

// Checks the vampire's bloodlevel and unlocks new powers based on that.
/mob/proc/check_vampire_upgrade()
	if (!mind.vampire)
		return

	var/datum/vampire/vampire = mind.vampire

	for (var/datum/power/vampire/P in vampirepowers)
		if (P.blood_cost <= vampire.blood_total)
			if (!(P in vampire.purchased_powers))
				vampire.add_power(mind, P, 1)

	if (!(vampire.status & VAMP_FULLPOWER) && vampire.blood_total >= 650)
		vampire.status |= VAMP_FULLPOWER
		to_chat(src, SPAN_NOTICE("You've gained full power. Some abilities now have bonus functionality, or work faster."))

// Runs the checks for whether or not we can use a power.
/mob/proc/vampire_power(required_blood = 0, max_stat = 0, ignore_holder = 0, disrupt_healing = 1,required_vampire_blood = 0)
	if (!mind)
		return
	if (!ishuman(src))
		return

	var/datum/vampire/vampire = mind.vampire
	if (!vampire)
		log_debug("[src] has a vampire power but is not a vampire.")
		return
	if (vampire.holder && !ignore_holder)
		to_chat(src, SPAN_WARNING("You cannot use this power while walking through the Veil."))
		return
	if (stat > max_stat)
		to_chat(src, SPAN_WARNING("You are incapacitated."))
		return
	if (required_blood > src.reagents.get_reagent_amount(/datum/reagent/vampiric_blood))
		to_chat(src, SPAN_WARNING("You do not have enough usable blood. [required_blood] needed."))
		return

	if ((vampire.status & VAMP_HEALING) && disrupt_healing)
		vampire.status &= ~VAMP_HEALING

	return vampire

// Checks whether or not the target can be affected by a vampire's abilities.
/mob/proc/vampire_can_affect_target(mob/living/carbon/human/T, notify = 1, account_loyalty_implant = 0, ignore_thrall = FALSE)
	if (!T || !istype(T))
		return FALSE
	// How did you even get here?
	if (!mind.vampire)
		return FALSE
	if ((mind.vampire.status & VAMP_FULLPOWER) && !(T.mind && T.mind.vampire && (T.mind.vampire.status & VAMP_FULLPOWER)))
		return TRUE
	if (T.mind)
		if (T.mind.assigned_role == "Chaplain")
			if (notify)
				to_chat(src, SPAN_WARNING("Your connection with the Veil is not strong enough to affect a man as devout as them."))
			return FALSE
		else if (T.mind.vampire && (!(T.mind.vampire.status & VAMP_ISTHRALL) || ((T.mind.vampire.status & VAMP_ISTHRALL) && !ignore_thrall)))
			if (notify)
				to_chat(src, SPAN_WARNING("You lack the power required to affect another creature of the Veil."))
			return FALSE

	if (T.isSynthetic())
		if (notify)
			to_chat(src, SPAN_WARNING("You lack the power interact with mechanical constructs."))
		return FALSE
	if(is_special_character(T) && (!(T.mind.vampire.status & VAMP_ISTHRALL)))
		if (notify)
			to_chat(src, SPAN_WARNING("\The [T]'s mind is too strong to be affected by our powers!"))
		return FALSE
	if (account_loyalty_implant)
		for (var/obj/item/implant/loyalty/I in T)
			if (I.implanted)
				if (notify)
					to_chat(src, SPAN_WARNING("You feel that [T]'s mind is protected from our powers."))
				return FALSE

	return TRUE

// Plays the vampire phase in animation.
/mob/proc/vampire_phase_in(turf/T)
	if (!T)
		return
	anim(T,src,'icons/mob/mob.dmi',null,"bloodify_in", null,dir)

// Plays the vampire phase out animation.
/mob/proc/vampire_phase_out(turf/T)
	if (!T)
		return
	anim(T,src,'icons/mob/mob.dmi',null,"bloodify_out", null,dir)

// Make a vampire thrall
/mob/proc/vampire_make_thrall()
	if (!mind)
		return

	var/datum/vampire/thrall/thrall = new()
	mind.vampire = thrall

/mob/proc/vampire_check_frenzy(force_frenzy = 0)
	if (!mind || !mind.vampire)
		return

	var/datum/vampire/vampire = mind.vampire
	// Thralls don't frenzy.
	if (vampire.status & VAMP_ISTHRALL)
		return

/*
 * Misc info:
 * 100 points ~= 3.5 minutes.
 * Average duration should be around 4 minutes of frenzy.
 * Trigger at 120 points or higher.
 */

	if (vampire.status & VAMP_FRENZIED)
		if (vampire.frenzy < 10)
			vampire_stop_frenzy()
	else
		var/next_alert = 0
		var/message = ""

		switch (vampire.frenzy)
			if (0)
				return
			if (1 to 20)
				// Pass function would be amazing here.
				next_alert = 0
				message = ""
			if (21 to 40)
				next_alert = 600
				message = SPAN_WARNING("You feel the power of the Veil bubbling in your veins.")
			if (41 to 60)
				next_alert = 500
				message = SPAN_WARNING("The corruption within your blood is seeking to take over, you can feel it.")
			if (61 to 80)
				next_alert = 400
				message = SPAN_DANGER("Your rage is growing ever greater. You are having to actively resist it.")
			if (81 to 120)
				next_alert = 300
				message = SPAN_DANGER("The corruption of the Veil is about to take over. You have little time left.")
			else
				vampire_start_frenzy(force_frenzy)

		if (next_alert && message)
			if (!vampire.last_frenzy_message || vampire.last_frenzy_message + next_alert < world.time)
				to_chat(src, message)
				vampire.last_frenzy_message = world.time

/mob/proc/vampire_start_frenzy(force_frenzy = 0)
	var/datum/vampire/vampire = mind.vampire

	if (vampire.status & VAMP_FRENZIED)
		return

	var/probablity = force_frenzy ? 100 : vampire.frenzy * 0.5

	if (prob(probablity))
		vampire.status |= VAMP_FRENZIED
		visible_message(SPAN_DANGER("A dark aura manifests itself around [src.name], their eyes turning red and their composure changing to be more beast-like."), SPAN_DANGER("You can resist no longer. The power of the Veil takes control over your mind: you are unable to speak or think. In people, you see nothing but prey to be feasted upon. You are reduced to an animal."))

		mutations.Add(MUTATION_HULK)
		update_mutations()

		sight |= SEE_MOBS

		verbs += /mob/living/carbon/human/proc/grapple

/mob/proc/vampire_stop_frenzy(force_stop = 0)
	var/datum/vampire/vampire = mind.vampire

	if (!(vampire.status & VAMP_FRENZIED))
		return

	if (prob(force_stop ? 100 : vampire.blood_usable))
		vampire.status &= ~VAMP_FRENZIED

		mutations.Remove(MUTATION_HULK)
		update_mutations()

		sight &= ~SEE_MOBS

		visible_message(SPAN_DANGER("[src.name]'s eyes no longer glow with violent rage, their form reverting to resemble that of a normal person's."), SPAN_DANGER("The beast within you retreats. You gain control over your body once more."))

		verbs -= /mob/living/carbon/human/proc/grapple
		regenerate_icons()

// Removes all vampire powers.
/mob/proc/remove_vampire_powers()
	if (!mind || !mind.vampire)
		return

	for (var/datum/power/vampire/P in mind.vampire.purchased_powers)
		if (P.is_active)
			verbs -= P.verbpath

	if (mind.vampire.status & VAMP_FRENZIED)
		vampire_stop_frenzy(1)

/mob/proc/handle_vampire()
	// Apply frenzy while in the chapel.
	if (istype(get_area(loc), /area/chapel))
		mind.vampire.frenzy += 3

	if (src.reagents.get_reagent_amount(/datum/reagent/vampiric_blood) < 10)
		mind.vampire.frenzy += 2
	else if (mind.vampire.frenzy > 0)
		mind.vampire.frenzy = max(0, mind.vampire.frenzy - Clamp(src.reagents.get_reagent_amount(/datum/reagent/vampiric_blood) * 0.1, 1, 10))

	mind.vampire.frenzy = min(mind.vampire.frenzy, 450)

	vampire_check_frenzy()

	return

/mob/living/carbon/human/proc/finish_vamp_timeout(vamp_flags = 0)
	if (!mind || !mind.vampire)
		return FALSE
	if (vamp_flags && !(mind.vampire.status & vamp_flags))
		return FALSE
	return TRUE

/mob/proc/use_blood(blood_to_use)
	if (!blood_to_use || blood_to_use <= 0)
		return
	src.reagents.remove_reagent(/datum/reagent/vampiric_blood, max(0, src.reagents.get_reagent_amount(/datum/reagent/vampiric_blood) - blood_to_use))
	mind.vampire.blood_usable = src.reagents.get_reagent_amount(/datum/reagent/vampiric_blood)
	//blood_usable = max(0, blood_usable - blood_to_use)

/mob/proc/add_vampiric_blood(blood_to_add)
	if (!blood_to_add || blood_to_add <= 0)
		return
	src.reagents.add_reagent(/datum/reagent/vampiric_blood, blood_to_add)

/mob/proc/get_blood_usable()
	var/blood_amount = src.reagents.get_reagent_amount(/datum/reagent/vampiric_blood)
	mind.vampire.blood_usable = blood_amount
	return blood_amount

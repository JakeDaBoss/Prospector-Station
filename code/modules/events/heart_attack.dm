/* /datum/event/heart_attack/start()
    var/list/candidates = list()
    for(var/mob/living/carbon/human/G in player_list)
        if(G.client && G.stat != DEAD)
            candidates += G
    if(!candidates.len) return
    var/mob/living/carbon/human/H = pick(candidates)
    H.give_heart_attack()
    
    //credit to codingale
*/

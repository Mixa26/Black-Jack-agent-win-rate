#* 10s are also cards with pictures
#* 11s are 1s who are considered 11s unless the players bust, 
#then they're considered 1s
cards <- c(11,2,3,4,5,6,7,8,9,10)
original_prob <- c(4/52,4/52,4/52,4/52,4/52,4/52,4/52,4/52,4/52,16/52)
cards_amount_original <- c(4,4,4,4,4,4,4,4,4,16)

play_a_game <- function()
{
  #copy of the probability
  copy_prob <- original_prob
  cards_amount <- cards_amount_original
  #dealing cards to players
  player_sum <- 0
  house_sum <- 0
  stand <- TRUE
  
  cards_dealt <- sample(cards,4,replace=FALSE,original_prob)
  house_hand = cards_dealt[1:2]
  player_hand = cards_dealt[3:4]
  
  player_sum = player_sum + player_hand[1]
  player_sum = player_sum + player_hand[2]
  
  house_sum = house_sum + house_hand[1]
  house_sum = house_sum + house_hand[2]
  
  for (i in 1:length(cards_dealt))
  {
    if (cards_dealt[i] != 11)
    {
      cards_amount[cards_dealt[i]] = cards_amount[cards_dealt[i]]-1
      copy_prob[cards_dealt[i]] = cards_amount[cards_dealt[i]] / 52
    }
    else
    {
      cards_amount[1] = cards_amount[1]-1
      copy_prob[1] = cards_amount[1] / 52
    }
  }
  
  #our player hitting or standing
  while(player_sum < 19 & stand)
  {
    if(player_sum <= 15)
    {
      card_dealt = sample(cards,1,replace=FALSE,copy_prob)
      if (11 %in% player_hand)
      {
        if (player_sum + card_dealt > 21)
        {
          player_hand[which(player_hand == 11)] = player_hand[which(player_hand == 11)] - 10
          player_sum = player_sum - 10
        }
      }
      if (card_dealt != 11)
      {
        cards_amount[card_dealt] = cards_amount[card_dealt]-1
        copy_prob[card_dealt] = cards_amount[card_dealt] / 52
        player_hand = append(player_hand,card_dealt)
        player_sum = player_sum + card_dealt
      }
      else
      {
        if (player_sum + card_dealt > 21)
        {
          player_sum = player_sum + 1
          player_hand = append(player_hand,1)
        }
        else
        {
          player_sum = player_sum + card_dealt
          player_hand = append(player_hand,11)
        }
        
        cards_amount[1] = cards_amount[1]-1
        copy_prob[1] = cards_amount[1] / 52
      }
      next
    }
    else
    {
      card_dealt = sample(cards,1,replace=FALSE,copy_prob)
      if (11 %in% player_hand)
      {
        if (player_sum + card_dealt > 21)
        {
          player_hand[which(player_hand == 11)] = player_hand[which(player_hand == 11)] - 10
          player_sum = player_sum - 10
        }
      }
      
      if (house_hand[1] < player_sum - 10)
      {
        stand = FALSE
        next
      }
      
      if (card_dealt != 11)
      {
        cards_amount[card_dealt] = cards_amount[card_dealt]-1
        copy_prob[card_dealt] = cards_amount[card_dealt] / 52
        player_hand = append(player_hand,card_dealt)
        player_sum = player_sum + card_dealt
      }
      else
      {
        if (player_sum + card_dealt > 21)
        {
          player_sum = player_sum + 1
          player_hand = append(player_hand,1)
        }
        else
        {
          player_sum = player_sum + card_dealt
          player_hand = append(player_hand,11)
        }
        
        cards_amount[1] = cards_amount[1]-1
        copy_prob[1] = cards_amount[1] / 52
      }
      next
    }
  }
  
  if (player_sum > 21)
  {
    return(0)
  }
  
  while (house_sum < player_sum)
  {
    card_dealt = sample(cards,1,replace=FALSE,copy_prob)
    if (11 %in% house_hand)
    {
      if (house_sum + card_dealt > 21)
      {
        house_hand[which(house_hand == 11)] = house_hand[which(house_hand == 11)] - 10
        house_sum = house_sum - 10
      } 
    }
    
    if (card_dealt != 11)
    {
      cards_amount[card_dealt] = cards_amount[card_dealt]-1
      copy_prob[card_dealt] = cards_amount[card_dealt] / 52
      house_hand = append(house_hand,card_dealt)
      house_sum = house_sum + card_dealt
    }
    else
    {
      if (house_sum + card_dealt > 21)
      {
        house_sum = house_sum + 1
        house_hand = append(house_hand,1)
      }
      else
      {
        houser_sum = house_sum + card_dealt
        house_hand = append(house_hand,11)
      }
      
      cards_amount[1] = cards_amount[1]-1
      copy_prob[1] = cards_amount[1] / 52
    }
    next
  }
  
  if (house_sum > 21)
  {
    return(1)
  }
  else if (player_sum > house_sum)
  {
    return(1)
  }
  else
  {
    return(0)
  }
}

print(mean(replicate(1000,play_a_game())))
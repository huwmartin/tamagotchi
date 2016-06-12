-module(tamagotchi).
-export([get_pet/0, feed_pet/1, play_with_pet/1, pet_poop/1, pet_sleep/1, time_passes/1]).

-record(pet, {hungriness=50 :: integer(),
  fullness=50 :: integer(),
  tiredness=50 :: integer(),
  happiness=50 :: integer()}).

get_pet() ->
  #pet{}.

feed_pet(#pet{hungriness=Hungriness, fullness=Fullness} = Pet)
  when Hungriness == 0, Fullness == 100 ->
    Pet;
feed_pet(#pet{hungriness=Hungriness, fullness=Fullness} = Pet) ->
  Pet#pet{hungriness=add_unless_maxed(Hungriness, decrement, 10),
    fullness=add_unless_maxed(Fullness, increment, 10)}.

play_with_pet(#pet{tiredness=Tiredness, happiness=Happiness} = Pet)
  when Tiredness == 100, Happiness == 100 ->
    Pet;
play_with_pet(#pet{tiredness=Tiredness, happiness=Happiness} = Pet) ->
  Pet#pet{tiredness=add_unless_maxed(Tiredness, increment, 10),
    happiness=add_unless_maxed(Happiness, increment, 10)}.

pet_poop(#pet{fullness=Fullness} = Pet)
  when Fullness == 0 ->
    Pet;
pet_poop(Pet) ->
  Pet#pet{fullness=Pet#pet.fullness-10}.

pet_sleep(#pet{tiredness=Tiredness} = Pet)
  when Tiredness == 0 ->
    Pet;
pet_sleep(Pet) ->
  Pet#pet{tiredness=Pet#pet.tiredness-10}.

time_passes(#pet{hungriness=Hungriness, tiredness=Tiredness, happiness=Happiness} = Pet)
  when Hungriness == 100, Tiredness == 100, Happiness == 0 ->
    Pet;
time_passes(#pet{hungriness=Hungriness, tiredness=Tiredness, happiness=Happiness} = Pet) ->
  Pet#pet{hungriness=add_unless_maxed(Hungriness, increment, 10),
    tiredness=add_unless_maxed(Tiredness, increment, 10),
    happiness=add_unless_maxed(Happiness, decrement, 10)}.

add_unless_maxed(Number, Action, 0)
  when Action == increment, Action == decrement ->
    Number;
add_unless_maxed(Number, Action, Amount)
  when Action == increment ->
    if Number == 100 -> Number;
       true -> Number+Amount
    end;
add_unless_maxed(Number, Action, Amount)
  when Action == decrement ->
    if Number == 0 -> Number;
       true -> Number-Amount
    end;
add_unless_maxed(Number, _, _) ->
  Number.

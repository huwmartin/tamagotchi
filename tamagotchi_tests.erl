% to run tests:
% erl -make
% erl -noshell -eval "eunit:test(tamagotchi, [verbose])" -s init stop

-module(tamagotchi_tests).
-import(tamagotchi, [get_pet/0, feed_pet/1, play_with_pet/1, pet_poop/1, pet_sleep/1, time_passes/1]).
-include_lib("eunit/include/eunit.hrl").

get_pet_test() ->
  ?assertEqual({pet,50,50,50,50}, get_pet()).

feed_pet_test() ->
  ?assertEqual({pet,40,60,50,50}, feed_pet({pet,50,50,50,50})).

feed_pet_hungriness_zero_test() ->
  ?assertEqual({pet,0,60,50,50}, feed_pet({pet,0,50,50,50})).

feed_pet_hungriness_hundred_test() ->
  ?assertEqual({pet,90,60,50,50}, feed_pet({pet,100,50,50,50})).

feed_pet_fullness_zero_test() ->
  ?assertEqual({pet,40,10,50,50}, feed_pet({pet,50,0,50,50})).

feed_pet_fullness_hundred_test() ->
  ?assertEqual({pet,40,100,50,50}, feed_pet({pet,50,100,50,50})).

feed_pet_maxed_test() ->
  ?assertEqual({pet,0,100,50,50}, feed_pet({pet,0,100,50,50})).

play_with_pet_test() ->
  ?assertEqual({pet,50,50,60,60}, play_with_pet({pet,50,50,50,50})).

play_with_pet_tiredness_zero_test() ->
  ?assertEqual({pet,50,50,10,60}, play_with_pet({pet,50,50,0,50})).

play_with_pet_tiredness_hundred_test() ->
  ?assertEqual({pet,50,50,100,60}, play_with_pet({pet,50,50,100,50})).

play_with_pet_happiness_zero_test() ->
  ?assertEqual({pet,50,50,60,10}, play_with_pet({pet,50,50,50,0})).

play_with_pet_happiness_hundred_test() ->
  ?assertEqual({pet,50,50,60,100}, play_with_pet({pet,50,50,50,100})).

play_with_pet_maxed_test() ->
  ?assertEqual({pet,50,50,100,100}, play_with_pet({pet,50,50,100,100})).

pet_poop_test() ->
  ?assertEqual({pet,50,40,50,50}, pet_poop({pet,50,50,50,50})).

pet_poop_zero_test() ->
  ?assertEqual({pet,50,0,50,50}, pet_poop({pet,50,0,50,50})).

pet_poop_hundred_test() ->
  ?assertEqual({pet,50,90,50,50}, pet_poop({pet,50,100,50,50})).

pet_sleep_test() ->
  ?assertEqual({pet,50,50,40,50}, pet_sleep({pet,50,50,50,50})).

pet_sleep_zero_test() ->
  ?assertEqual({pet,50,50,0,50}, pet_sleep({pet,50,50,0,50})).

pet_sleep_hundred_test() ->
  ?assertEqual({pet,50,50,90,50}, pet_sleep({pet,50,50,100,50})).

time_passes_test() ->
  ?assertEqual({pet,60,50,60,40}, time_passes({pet,50,50,50,50})).

time_passes_hungriness_zero_test() ->
  ?assertEqual({pet,10,50,60,40}, time_passes({pet,0,50,50,50})).

time_passes_hungriness_hundred_test() ->
  ?assertEqual({pet,100,50,60,40}, time_passes({pet,100,50,50,50})).

time_passes_tiredness_zero_test() ->
  ?assertEqual({pet,60,50,10,40}, time_passes({pet,50,50,0,50})).

time_passes_tiredness_hundred_test() ->
  ?assertEqual({pet,60,50,100,40}, time_passes({pet,50,50,100,50})).

time_passes_happiness_zero_test() ->
  ?assertEqual({pet,60,50,60,0}, time_passes({pet,50,50,50,0})).

time_passes_happiness_hundred_test() ->
  ?assertEqual({pet,60,50,60,90}, time_passes({pet,50,50,50,100})).

time_passes_maxed_test() ->
  ?assertEqual({pet,100,50,100,0}, time_passes({pet,100,50,100,0})).

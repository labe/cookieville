### DONE ###

1. baker can make cookies, cookie batch is added to cookies table and assigned that baker's id
2. baker can put cookies in the oven
3. baker can remove cookies from the oven
4. oven class (read: kitchen) can bake cookies
5. cookie batch status updates based on how long it has been in the oven
6. an oven knows when it is full or not
7. cookies cannot be put into a full oven
8. cookies cannot be put into an oven if they are already in an oven
9. cookies cannot be baked if they are not in an oven
10. cookies cannot be removed from an oven if they are not in an oven
11. cookies cannot be put into an oven unless that oven is set to the correct temperature for that recipe
12. cookie status is determined by individual recipe's baking time
13. oven temp can be set
14. recipes can be printed out in a viewer-friendly format

### NEW ###

- player "sign-in/setup" flow created
- can create player/baker-assigned batches of cookies
- made join table of oven models and bakeries ("ovens")

through viewer, player can:

-view recipes/directions
-make cookie batches

### TO DO NEXT ###

-menu header displaying bakery name?

through viewer, player can:


-view all cookie batches and status (cooked, in oven, etc)
-put cookies in oven
-bake cookies
-take cookies out of oven
-check bakery stats
-update player settings (bakery name, baker name, add player email, add player name?)
-read "help" file


### LONG TERM ###

- refactor for MVC >>>>> (CLEAN UP CODE VOMIT) <<<<<<



- track time (every action = time spent, game/level = set time limit)

- ability to store dough in fridge/freezer (<- limited capacity, $$) ?
- assign ingredients to cookie recipes
- create kitchen pantry (database)
- cannot make cookies unless pantry contains enough of each required ingredient
- assign baker skill level based on # of successful cookie batches made?


- bakery can have more than just a kitchen / kitchen owns the ovens (create kitchens table)
- bakery can sell cookies to earn money to buy [ingredients to make more cookies, more ovens, etc.]
- bakery can make more than just cookies (rename cookies table to 'foods' or something, keep schema)




### ETC ###


controller = players (create players table)

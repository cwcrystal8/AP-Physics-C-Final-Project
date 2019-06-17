# AP-Physics-C-Final-Project
Crystal Wang and Joshua Weiner

## What It Does
Our project allows the user to build their own rollercoaster using horizontal tracks, curved tracks, loop-de-loops, and springs (to change the direction on the x-axis), then watch a small cart as it goes through the rollercoaster. The user can also view  a graph of the kinetic energy versus time as the cart moves.

## Instructions
0. Download this repository and run `Rollercoaster.pde`. Press the "Play" button (triangle) in the upper-left of the window that opens.
1. Press "Start Drawing."
2. Double-click the track you would like to draw, and follow the instructions in the text box.
  * Note: You MUST start each new track at the end of the previous track.
3. Click "Clear" if you would like to start over.
4. Click "Done" if you're done designing and you want to see the simulation.
5. Click "Back" if you want to modify your design.

## Known Bugs and Discrepancies
* The approximation of circular movement in the simulation means that the cart may shift on or off the track, but it will generally stay near it.
* Friction is not accounted for in our simulation, and total mechanical energy is otherwise conserved.
* If you try to draw a path that would be physically impossible for a real cart to follow, the cart may not cooperate (e.g. a sharp pivot with no spring or an angle that is too steep, aka past vertical).
* Springs will extend past their base (aka flip in the opposite direction) if the cart has enough energy to do so, so springs closer to the bottom must also be longer to prevent this from happening.

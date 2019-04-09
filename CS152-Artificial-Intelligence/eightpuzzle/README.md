# Eight Puzzle
Eight-puzzle is a game in which the player tries to rearrange tiles in a given order. See an example [here](https://murhafsousli.github.io/8puzzle/#/).

The eightpuzzle.py file solves for three different arrangements (see test_lists below) to get re-arranged to [[0, 1, 2], [3, 4, 5], [6, 7, 7]]].

test_lists = [[[5, 7, 6], [2, 4, 3], [8, 1, 0]],
             [[7, 0, 8], [4, 6, 1], [5, 3, 2]],
             [[2, 3, 7], [1, 8, 0], [6, 5, 4]]]
             
It returns the performance of three different heuristics (hamming distance, manhattan distance, and manhattan distance with child nodes) and their performance with regards to steps, frontier size, and whether an error occurred. 

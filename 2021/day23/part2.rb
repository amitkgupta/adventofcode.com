#############
#...........#
###C#A#B#D###
  #D#C#B#A#
  #D#B#A#C#
  #C#A#D#B#
  #########

#############
#..........C#
###.#A#B#D###
  #D#C#B#A#     100 * (1+8)
  #D#B#A#C#
  #C#A#D#B#
  #########

#############
#D.........C#
###.#A#B#D###
  #.#C#B#A#     1000 * (2+2)
  #D#B#A#C#
  #C#A#D#B#
  #########

#############
#DD........C#
###.#A#B#D###
  #.#C#B#A#     1000 * (3+1)
  #.#B#A#C#
  #C#A#D#B#
  #########

#############
#DD.......CC#
###.#A#B#D###
  #.#C#B#A#     100 * (4+7)
  #.#B#A#C#
  #.#A#D#B#
  #########

#############
#DD.......CC#
###.#.#B#D###
  #.#C#B#A#     1 * (1+2+4)
  #.#B#A#C#
  #A#A#D#B#
  #########

#############
#DD.....C.CC#
###.#.#B#D###
  #.#.#B#A#     100 * (2+3)
  #.#B#A#C#
  #A#A#D#B#
  #########

#############
#DD...B.C.CC#
###.#.#B#D###
  #.#.#B#A#     10 * (3+1)
  #.#.#A#C#
  #A#A#D#B#
  #########

#############
#DD...B.C.CC#
###.#.#B#D###
  #.#.#B#A#     1 * (4+2+3)
  #A#.#A#C#
  #A#.#D#B#
  #########

#############
#DD.....C.CC#
###.#.#B#D###
  #.#.#B#A#     10 * (4+1)
  #A#.#A#C#
  #A#B#D#B#
  #########

#############
#DD.....C.CC#
###.#.#.#D###
  #.#.#B#A#     10 * (1+2+3)
  #A#B#A#C#
  #A#B#D#B#
  #########

#############
#DD.....C.CC#
###.#.#.#D###
  #.#B#.#A#     10 * (2+2+2)
  #A#B#A#C#
  #A#B#D#B#
  #########

#############
#DD.....C.CC#
###.#.#.#D###
  #A#B#.#A#     1 * (3+4+2)
  #A#B#.#C#
  #A#B#D#B#
  #########

#############
#DD.D...C.CC#
###.#.#.#D###
  #A#B#.#A#     1000 * (4+3)
  #A#B#.#C#
  #A#B#.#B#
  #########

#############
#DD.D.....CC#
###.#.#.#D###
  #A#B#.#A#     100 * (1+4)
  #A#B#.#C#
  #A#B#C#B#
  #########

#############
#DD.D......C#
###.#.#.#D###
  #A#B#.#A#     100 * (3+3)
  #A#B#C#C#
  #A#B#C#B#
  #########

#############
#DD.D.......#
###.#.#.#D###
  #A#B#C#A#     100 * (4+2)
  #A#B#C#C#
  #A#B#C#B#
  #########

#############
#DD.D......D#
###.#.#.#.###
  #A#B#C#A#     1000 * (1+2)
  #A#B#C#C#
  #A#B#C#B#
  #########

#############
#DD.D.....AD#
###.#.#.#.###
  #A#B#C#.#     1 * (2+1)
  #A#B#C#C#
  #A#B#C#B#
  #########

#############
#DD.D.....AD#
###.#.#C#.###
  #A#B#C#.#     100 * (3+2+1)
  #A#B#C#.#
  #A#B#C#B#
  #########

#############
#DD.D.....AD#
###.#B#C#.###
  #A#B#C#.#     10 * (4+4+1)
  #A#B#C#.#
  #A#B#C#.#
  #########

#############
#DD.......AD#
###.#B#C#.###
  #A#B#C#.#     1000 * (5+4)
  #A#B#C#.#
  #A#B#C#D#
  #########

#############
#D........AD#
###.#B#C#.###
  #A#B#C#.#     1000 * (7+3)
  #A#B#C#D#
  #A#B#C#D#
  #########

#############
#.........AD#
###.#B#C#.###
  #A#B#C#D#     1000 * (8+2)
  #A#B#C#D#
  #A#B#C#D#
  #########

#############
#..........D#
###A#B#C#.###
  #A#B#C#D#     1 * (7+1)
  #A#B#C#D#
  #A#B#C#D#
  #########

#############
#...........#
###A#B#C#D###
  #A#B#C#D#     1000 * (2+1)
  #A#B#C#D#
  #A#B#C#D#
  #########

ans = 100 * (1+8)   + \
     1000 * (2+2)   + \
     1000 * (3+1)   + \
      100 * (4+7)   + \
        1 * (1+2+4) + \
      100 * (2+3)   + \
       10 * (3+1)   + \
        1 * (4+2+3) + \
       10 * (4+1)   + \
       10 * (1+2+3) + \
       10 * (2+2+2) + \
        1 * (3+4+2) + \
     1000 * (4+3)   + \
      100 * (1+4)   + \
      100 * (3+3)   + \
      100 * (4+2)   + \
     1000 * (1+2)   + \
        1 * (2+1)   + \
      100 * (3+2+1) + \
       10 * (4+4+1) + \
     1000 * (5+4)   + \
     1000 * (7+3)   + \
     1000 * (8+2)   + \
        1 * (7+1)   + \
     1000 * (2+1)

puts ans

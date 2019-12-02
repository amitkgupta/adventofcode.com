package main

import (
	"math"
	"os"
)

type position struct {
	x, y int
}

type equipment int

type state struct {
	position
	equipment
}

type geoData struct {
	geologicIndex, erosionLevel int
}

const (
	modulus = 20183
	xFactor = 16807
	yFactor = 48271

	depth          = 11109
	torch        equipment = iota
	climbingGear equipment = iota
	neither      equipment = iota
)

var (
	geoDataMemo = map[position]geoData{}

	startPosition  = position{0, 0}
	targetPosition = position{9, 731}

	startState = state{
		position:  startPosition,
		equipment: torch,
	}
	targetState = state{
		position:  targetPosition,
		equipment: torch,
	}
)

func mod(a, b int) int { return int(math.Mod(float64(a), float64(b))) }

func erosionLevel(geologicIndex int) int { return mod(geologicIndex+depth, modulus) }

func geoDataAt(p position) geoData {
	if gd, ok := geoDataMemo[p]; ok {
		return gd
	}

	var geologicIndex int
	switch {
	case p == startPosition || p == targetPosition:
		geologicIndex = 0
	case p.y == 0:
		geologicIndex = mod(p.x*xFactor, modulus)
	case p.x == 0:
		geologicIndex = mod(p.y*yFactor, modulus)
	default:
		el1 := geoDataAt(position{p.x - 1, p.y}).erosionLevel
		el2 := geoDataAt(position{p.x, p.y - 1}).erosionLevel
		geologicIndex = mod(el1 * el2, modulus)
	}

	geoDataMemo[p] = geoData{
		geologicIndex: geologicIndex,
		erosionLevel:  erosionLevel(geologicIndex),
	}
	return geoDataMemo[p]
}

func valid(s state) bool {
	switch mod(geoDataAt(s.position).erosionLevel, 3) {
	case 0:
		return s.equipment != neither
	case 1:
		return s.equipment != torch
	case 2:
		return s.equipment != climbingGear
	default:
		panic("should not reach here")
	}
}

func main() {
	distances := map[state]int{startState: 0}
	unvisited := map[state]struct{}{startState: {}}
	visited := map[state]struct{}{}

	for len(unvisited) > 0 {
		minUnvisitedDistance := math.MaxInt64
		var visitee state
		for s, _ := range unvisited {
			if distance, ok := distances[s]; ok {
				if distance < minUnvisitedDistance {
					minUnvisitedDistance = distance
					visitee = s
				}
			} else {
				distances[s] = math.MaxInt64
			}
		}

		if visitee == targetState {
			println(minUnvisitedDistance)
			os.Exit(0)
		}

		delete(unvisited, visitee)
		visited[visitee] = struct{}{}

		x := visitee.x
		y := visitee.y
		equipment := visitee.equipment
		for i := x - 1; i <= x+1; i++ {
			for j := y - 1; j <= y+1; j++ {
				for e := torch; e <= neither; e++ {
					s := state{
						position: position{x: i, y: j},
						equipment: e,
					}

					if i < 0 {
						continue
					}
					if j < 0 {
						continue
					}
					if !valid(s) {
						continue
					}
					if x != i && y != j {
						continue
					}
					if equipment != e && (x != i || y != j) {
						continue
					}

					if _, ok := visited[s]; !ok {
						unvisited[s] = struct{}{}
					}
					if _, ok := distances[s]; !ok {
						distances[s] = math.MaxInt64
					}

					if _, ok := unvisited[s]; ok {
						var extraDistance int
						if e == equipment {
							extraDistance = 1
						} else {
							extraDistance = 7
						}
						if candidateDistance := distances[visitee] + extraDistance; candidateDistance < distances[s] {
							distances[s] = candidateDistance
						}
					}
				}
			}
		}
	}
}

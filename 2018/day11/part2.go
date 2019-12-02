package main

import "math"
import "fmt"

const serialNumber = 6878

func mod(a, b int) int {
	return int(math.Mod(float64(a), float64(b)))
}

func powerLevel(i, j int) int {
	id := i+10
	return mod((id*j + serialNumber)*id/100, 10) - 5
}

type candidate struct {
	x, y, s, t int
}

func main() {
	powerLevels := [300][300]int{}
	for i, row := range powerLevels {
		for j, _ := range row {
			powerLevels[i][j] = powerLevel(i+1, j+1)
		}
	}

	numCandidates := 0
	for i := 1; i <= 300; i++ {
		for j := 1; j <= 300; j++ {
			ms := 301-i
			if j > i { ms = 301 - j }
			numCandidates = numCandidates + ms
		}
	}
	x, y, m, s, candidates := -1, -1, math.MinInt64, -1, make(chan candidate, numCandidates)

	for i := 1; i <= 300; i++ {
		for j := 1; j <= 300; j++ {
			go func(ii, jj int) {
				c := 0
				ms := 301-ii
				if jj > ii { ms = 301 - jj }
				for ss := 1; ss <= ms; ss++ {
					c += powerLevels[ii+ss-2][jj+ss-2]
					for iii := 0; iii < ss-1; iii++ { c += powerLevels[ii+iii-1][jj+ss-2] }
					for jjj := 0; jjj < ss-1; jjj++ { c += powerLevels[ii+ss-2][jj+jjj-1] }
					candidates <- candidate{ii, jj, ss, c}
				}
			}(i, j)
		}
	}
	for idx := 0; idx < numCandidates; idx++ {
		c := <-candidates
		if c.t > m {
			m = c.t
			x = c.x
			y = c.y
			s = c.s
		}
	}
	fmt.Printf("%d,%d,%d", x,y,s)
}	
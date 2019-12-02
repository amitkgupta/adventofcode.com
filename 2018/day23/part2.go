package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io/ioutil"
	. "math"
	"regexp"
	"strconv"
)

type point struct {
	x, y, z float64
}

func norm(p point) float64 {
	return Abs(p.x) + Abs(p.y) + Abs(p.z)
}

func distance(p, q point) float64 {
	return norm(point{p.x - q.x, p.y - q.y, p.z - q.z})
}

type nanobot struct {
	point
	rng float64
}

type bounds struct {
	lower, upper int
}

func inRangeBounds(nanobots []nanobot, center point, step float64) map[point]bounds {
	boundsMap := map[point]bounds{}

	for i := -1; i <= 1; i++ {
		for j := -1; j <= 1; j++ {
			for k := -1; k <= 1; k++ {
				p := point{
					x: center.x + float64(i)*step,
					y: center.y + float64(j)*step,
					z: center.z + float64(k)*step,
				}
				b := bounds{}

				for _, nb := range nanobots {
					d := distance(p, nb.point)
					if d <= nb.rng - 3*Floor(step/2) { b.lower++ }
					if d <= nb.rng + 3*Floor(step/2) { b.upper++ }
				}
				boundsMap[p] = b
			}
		}
	}

	return boundsMap
}

func smallestNormInBox(p point, sideHalf float64) float64 {
	smallestNorm := MaxFloat64

	for i := -1; i <= 1; i++ {
		for j := -1; j <= 1; j++ {
			for k := -1; k <= 1; k++ {
				q := point{
					x: p.x + float64(i)*sideHalf,
					y: p.y + float64(j)*sideHalf,
					z: p.z + float64(k)*sideHalf,
				}

				if n := norm(q); n < smallestNorm { smallestNorm = n }
			}
		}
	}

	return smallestNorm
}

func main() {
	nanobots := []nanobot{}

	input, err := ioutil.ReadFile("input.txt")
	if err != nil { panic(err) }

	pattern, err := regexp.Compile(`-?\d+`)
	if err != nil { panic(err) }

	scanner := bufio.NewScanner(bytes.NewReader(input))
	for scanner.Scan() {
		matches := pattern.FindAllString(scanner.Text(), 4)
		
		x, err := strconv.ParseFloat(matches[0], 64)
		if err != nil { panic(err) }

		y, err := strconv.ParseFloat(matches[1], 64)
		if err != nil { panic(err) }

		z, err := strconv.ParseFloat(matches[2], 64)
		if err != nil { panic(err) }

		rng, err := strconv.ParseFloat(matches[3], 64)
		if err != nil { panic(err) }

		nanobots = append(nanobots, nanobot{point{x, y, z}, rng})
	}

	maxCoord := 0.0
	for _, nb := range nanobots {
		p := nb.point
		if Abs(p.x) > maxCoord { maxCoord = Abs(p.x) }
		if Abs(p.y) > maxCoord { maxCoord = Abs(p.y) }
		if Abs(p.z) > maxCoord { maxCoord = Abs(p.z) }
	}

	centers := []point{{0, 0, 0}}
	candidateNorm := MaxFloat64
	prevMaxLowerBound := 0
	for step := Pow(2, Ceil(Log2(maxCoord/1.5))); step >= 1; step /= 2 {
		upperBounds := map[point]int{}
		maxLowerBound := 0
		boundsMapChan := make(chan map[point]bounds, len(centers))

		for _, c := range centers { boundsMapChan <- inRangeBounds(nanobots, c, step) }

		mm := 0
		for range centers {
			boundsMap := <-boundsMapChan
			for c, b := range boundsMap {
				upperBounds[c] = b.upper
				if b.upper > mm { mm = b.upper }
				if b.lower > maxLowerBound { maxLowerBound = b.lower }
			}
		}
		println(mm)

		if maxLowerBound > prevMaxLowerBound { candidateNorm = MaxFloat64 }
		prevMaxLowerBound = maxLowerBound

		centers = []point{}
		for c, ub := range upperBounds {
			if ub > maxLowerBound { centers = append(centers, c) }
			if ub == maxLowerBound { 
				if n := smallestNormInBox(c, step/2); n < candidateNorm {
					candidateNorm = n
				}
			}
		}

		foo := 0
		for _, nb := range nanobots {
			if distance(centers[15], nb.point) <= nb.rng { foo++ }
		}
		println(foo, centers[15].x, centers[15].y, centers[15].z)

		fmt.Printf("%d centers, foo: %d, current guess: %f, step: %f\n", len(centers), maxLowerBound, candidateNorm, step)
	}

	for _, c := range centers {
		n := norm(c)
		if n < candidateNorm { candidateNorm = n }
	}

	fmt.Printf("final answer: %f", candidateNorm)
}
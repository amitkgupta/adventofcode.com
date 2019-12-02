package main

import "math"

const (
	numPlayers = 459
	lastMarbleValue = 7179000
)

type node struct {
	value int
	prv *node
	nxt *node
}

type circularLinkedList struct {
	head *node
}

func (c *circularLinkedList) insert(value int) {
	n := new(node)
	n.value = value
	n.prv = c.head.prv
	n.nxt = c.head
	n.nxt.prv = n
	n.prv.nxt = n
	c.head = n
}

func (c *circularLinkedList) delete() int {
	c.head.prv.nxt = c.head.nxt
	c.head.nxt.prv = c.head.prv
	value := c.head.value
	c.head = c.head.nxt
	return value
}

func (c *circularLinkedList) forward2() {
	c.head = c.head.nxt.nxt
}

func (c *circularLinkedList) back7() {
	c.head = c.head.prv.prv.prv.prv.prv.prv.prv
}

func newCircle() *circularLinkedList {
	n := new(node)
	n.value = 0
	n.prv = n
	n.nxt = n
	circle := new(circularLinkedList)
	circle.head = n
	return circle
}

func main() {
	scores := make([]int, numPlayers)
	
	circle := newCircle()

	for v := 1; v <= lastMarbleValue; v++ {
		if mod(v, 23) != 0 {
			circle.forward2()
			circle.insert(v)
			continue
		}

		circle.back7()
		scores[mod(v, numPlayers)] += v + circle.delete()
	}

	max_score := 0
	for _, s := range scores {
		if s > max_score {
			max_score = s
		}
	}
	println(max_score)
}

func mod(a, b int) int {
	return int(math.Mod(float64(a), float64(b)))
}
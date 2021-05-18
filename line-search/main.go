package main

import (
	"fmt"
	"math"
)

func main() {
	x := LineSearch(f, -5, 10, 0.0001)
	fmt.Println(x, f(x))
}

func f(x float64) float64 {
	return x * x
}

func LineSearch(f func(x float64) float64, a float64, b float64, acc float64) float64 {
	q := 3.0/2.0 - math.Sqrt(5.0)/2.0
	c := a + (b-a)*q
	d := b - (b-a)*q
	for math.Abs(b-a) > acc {
		if f(c) < f(d) {
			b = d
			d = c
			c = a + (b-a)*q
		} else {
			a = c
			c = d
			d = b - (b-a)*q
		}
	}
	return a
}

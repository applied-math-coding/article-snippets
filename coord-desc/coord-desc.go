package main

import (
	"fmt"
	"math"

	"gonum.org/v1/gonum/diff/fd"
)

func main() {
	x := CoordDesc(bealFunction, []float64{1.0, 1.0}, []float64{-10.0, -10.0}, []float64{10.0, 10.0}, 0.1)
	fmt.Println(x, bealFunction(x))
}

func CoordDesc(f func([]float64) float64, x0 []float64, a []float64, b []float64, acc float64) []float64 {
	x := make([]float64, len(x0))
	copy(x, x0)
	for l2Norm(fd.Gradient(nil, f, x, nil)) > acc {
		for j := 0; j < len(x0); j++ {
			tauOpt := lineSearch(func(tau float64) float64 {
				z := make([]float64, len(x))
				copy(z, x)
				z[j] = z[j] + tau
				return f(z)
			}, a[j], b[j], 0.01)
			x[j] = x[j] + tauOpt
		}
	}
	return x
}

func bealFunction(x []float64) float64 {
	return math.Pow(1.5-x[0]+x[0]*x[1], 2.0) +
		math.Pow(2.25-x[0]+x[0]*x[1]*x[1], 2.0) +
		math.Pow(2.625-x[0]+x[0]*x[1]*x[1]*x[1], 2.0)
}

func l2Norm(x []float64) float64 {
	res := 0.0
	for _, e := range x {
		res += e * e
	}
	return math.Sqrt(res)
}

func lineSearch(f func(x float64) float64, a float64, b float64, acc float64) float64 {
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

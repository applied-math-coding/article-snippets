package main

import (
	"fmt"
	"math"

	"gonum.org/v1/gonum/mat"
)

func main() {
	x := GradDesc(mat.NewVecDense(2, []float64{10.0, 10.0}), 0.001, grad, 0.001)
	fmt.Println(x, f(x))
}

func GradDesc(x_0 mat.Vector, tau float64, grad func(mat.Vector) mat.Vector, acc float64) mat.Vector {
	n := x_0.Len()
	x := mat.NewVecDense(n, nil)
	x.CopyVec(x_0)
	for mat.Norm(grad(x), 2) > acc {
		x.AddScaledVec(x, -tau, grad(x))
	}
	return x
}

func f(x mat.Vector) float64 {
	x0 := x.AtVec(0)
	x1 := x.AtVec(1)
	return math.Pow(x0*x0+x1-11.0, 2.0) +
		math.Pow(x0+x1*x1-7.0, 2.0)
}

func grad(x mat.Vector) mat.Vector {
	x0 := x.AtVec(0)
	x1 := x.AtVec(1)
	return mat.NewVecDense(2, []float64{
		4.0*x0*(x0*x0+x1-11.0) + 2.0*(x0+x1*x1-7.0),
		2.0*(x0*x0+x1-11.0) + 4.0*x1*(x0+x1*x1-7.0)})
}

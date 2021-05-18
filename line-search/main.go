package main

import (
	"fmt"

	lineSearch "github.com/applied-math-coding/article-snippets/tree/main/line-search/linesearch"
)

func main() {
	x := lineSearch.LineSearch(f, -5, 10, 0.0001)
	fmt.Println(x, f(x))
}

func f(x float64) float64 {
	return x * x
}

import Pkg
Pkg.add("Plots")
Pkg.add("PyPlot")
import Plots as plt
plt.pyplot()

include("./solver/src/solver.jl")
import .solver as sol


function f(t::Float64, y::AbstractVector{Float64})::AbstractVector{Float64}
    return y
end

a = 0.0
b = 1.0
h = 0.01
y_euler = sol.euler([1.0; 1.0], f, a, b, h)

k = ceil(Integer, (b - a) / h)
t_range = range(a, stop=b, length=k)
y_true = exp.(t_range)

plt.plot(rand(10))

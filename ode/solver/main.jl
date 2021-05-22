import Pkg
Pkg.add("Plots")
Pkg.add("PyPlot")
import Plots as plt
plt.pyplot()

include("./solver.jl")
import .solver as sol
import LinearAlgebra as lina


# function f(t::Float64, y::AbstractVector{Float64})::AbstractVector{Float64}
#     return y
# end

# a = 0.0
# b = 10.0
# h = 0.1
# y_euler = sol.euler([1.0], f, a, b, h)
# y_midpoint = sol.midpoint([1.0], f, a, b, h)

# k = ceil(Integer, (b - a) / h)
# t_range = range(a, stop=b, length=k)
# y_true = exp.(t_range)
# p = plt.plot(t_range, y_true, label="true")
# plt.plot!(t_range, lina.transpose(y_euler), label="Euler")
# plt.plot!(t_range, lina.transpose(y_midpoint), label="midpoint")
# plt.png(p, "solver/exp_plot.png")

function f_lorenz(t::Float64, y::AbstractVector{Float64})::AbstractVector{Float64}
    return [
   -y[2] - y[3]
   y[1] + 0.2 * y[2]
   0.2 + y[1] * y[3] - 5.7 * y[3]
 ]
end

a = 0.0
b = 200.0
h = 0.01
println("starting")
y_midpoint = sol.midpoint([-1.0; 0; 0], f_lorenz, a, b, h)
println("finished")
y_trans = lina.transpose(y_midpoint)
p = plt.plot(y_trans[:,1], y_trans[:,2], y_trans[:,3], label="")
plt.png(p, "solver/lorenz.png")
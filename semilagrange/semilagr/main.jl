# using Pkg
# Pkg.add("Plots")
# Pkg.add("PyPlot")
import Plots as plt
plt.pyplot()

function F(v::AbstractArray)::AbstractArray
    f = 0.01
    return f * [
    v[2]
    -v[1]
  ]
end

function interpolate(v::AbstractArray, x_D::AbstractArray, x_A::AbstractArray, dx::Float64, I::Int)::AbstractArray
    v_inter = fill([0.0;0.0], (I, I))
    for i_D in 1:I, j_D in 1:I
        x = x_D[i_D, j_D]
        (i0, j0) = floor.(Integer, x / dx)
        (i0, j0) = (i0 + 1, j0 + 1)  # since index not zero based
        (i1, j1) = (i0 + 1, j0)
        (i2, j2) = (i0, j0 + 1)
        if x[2] - j0 * dx > 0.5  # interpolation from upper triangle
            (i0, j0) = (i0 + 1, j0 + 1)
        end
        # open boundaries: shift back to the nearest at boundary
        di = min(i0, i1, i2)
        if di < 1
            i0 += -di + 1
            i1 += -di + 1
            i2 += -di + 1
        end
        di = max(i0 - I, i1 - I, i2 - I)
        if di > 0
            i0 += -di
            i1 += -di
            i2 += -di
        end
        dj = min(j0, j1, j2)
        if dj < 1
            j0 += -dj + 1
            j1 += -dj + 1
            j2 += -dj + 1
        end
        dj = max(j0 - I, j1 - I, j2 - I)
        if dj > 0
            j0 += -dj
            j1 += -dj
            j2 += -dj
        end
        t =  [x_A[i1,j1] - x_A[i0,j0] x_A[i2,j2] - x_A[i0,j0]] \ (x - x_A[i0,j0])
        t0 = 1.0 - t[1] - t[2]
        v_inter[i_D,j_D] = t0 * v[i0,j0] + t[1] * v[i1,j1] + t[2] * v[i2,j2]
    end
    return v_inter
end

function plotField(x_A, v::AbstractArray)
    (x1, x2) = extractCoords(x_A)
    (v1, v2) = extractCoords(v)
    plot = plt.quiver(x1, x2, quiver=(v1, v2))
    display(plot)
end

# extracts field as x and y coordinate vectors
# field: number[2,][n,n]
function extractCoords(field::AbstractArray)
    field = reshape(deepcopy(field), (1, :))
    field = [field[1] field[2:end]...]
    x1 = vec(field[1,begin:end])
    x2 = vec(field[2,begin:end])
    return (x1, x2)
end

function plotParticles(x_P::AbstractArray, v_P::AbstractArray, dt::Float64, I::Int)
    x_P = x_P + dt * v_P
    (x1, x2) = extractCoords(x_P)
    center = floor(Integer, (I/2)^2) # only plot the center particle
    display(plt.scatter!(x1[center:center], x2[center:center], xlims=(0, 6), ylims=(0, 6), label=""))
end

(function main()
    L =  10.0 # 100.0
    dx = 1.0
    dt = 0.1
    T = 600.0
    I = ceil(Integer, L / dx)
    v = fill([10.0; 0.0], (I, I))
    x_A = [dx * [i - 1; j - 1] for i = 1:I, j = 1:I]

    x_D = deepcopy(x_A)
    x_P = deepcopy(x_A)
    lastPlot = 0.0
    for t = 0.0:dt:T
        for n = 1:5
            x_D = x_A - dt * interpolate(v, x_D, x_A, dx, I)
        end
        v_D = interpolate(v, x_D, x_A, dx, I)
        v = v_D + dt * F.(v_D)
        if t - lastPlot > 5.0
            # plotField(x_A, v)
            v_P = interpolate(v, x_P, x_A, dx, I)
            plotParticles(x_P, v_P, dt, I)
            lastPlot = t
            sleep(1) # TODO
        end
    end
end)()


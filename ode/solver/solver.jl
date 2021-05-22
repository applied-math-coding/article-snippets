module solver

function euler(y0::AbstractArray{Float64}, f, a::Float64, b::Float64, h::Float64)::AbstractArray{Float64}
    k = ceil(Integer, (b - a) / h)
    t_range = range(a, stop=b, length=k)
    y = y0
    for t_n = t_range
        if t_n == a
            continue
        end
        y_n = y[:,end]
        y_next = y_n + h * f(t_n, y_n)
        y = [y y_next]
    end
    return y
end

function midpoint(y0::AbstractArray{Float64}, f, a::Float64, b::Float64, h::Float64)::AbstractArray{Float64}
    k = ceil(Integer, (b - a) / h)
    t_range = range(a, stop=b, length=k)
    y = y0
    for t_n = t_range
        if t_n == a
            continue
        end
        y_n = y[:,end]
        y_next = y_n + h * f(t_n + h / 2.0, y_n + h / 2.0 * f(t_n, y_n))
        y = [y y_next]
    end
    return y
end



end # module

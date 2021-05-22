module solver

function euler(y0::AbstractArray{Float64}, f, a::Float64, b::Float64, h::Float64)::AbstractArray{Float64}
    k = ceil(Integer, (b - a) / h)
    t_range = range(a, stop=b, length=k)
    y = y0
    for t = t_range
        y_n = y[:,end]
        y_next = y_n + h * f(t, y_n)
        y = [y y_next]
    end
    return y
end



end # module

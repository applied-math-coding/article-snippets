module plotter

import Plots as plt
plt.pyplot()

function f(x, y)
    return (x^2+y-11)^2+(x+y^2-7)^2
end

const plot = function ()
    x = -5.0:0.1:5.0
    y = -5.0:0.1:5.0
    plt.heatmap(x, y, f)
    plt.png("plots/heat.png")
    # plt.plot(x, y, f, st=:wireframe)
    # plt.png("plots/wireframe.png")
end

end # module

module MyPlots

import Plots as plt
plt.pyplot()

function f(x, y)
    return (1.5-x+x*y)^2+(2.25-x+x*y^2)^2+(2.625-x+x*y^3)^2
end

const plot = function ()
    x = -5.0:0.1:5.0
    y = -5.0:0.1:5.0
    # plt.heatmap(x, y, f)
    # plt.png("MyPlots/heat.png")
    plt.plot(x, y, f, st=:wireframe)
    plt.png("MyPlots/wireframe.png")
end

end # module

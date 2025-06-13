module Equation_of_motion

function solve_x(v, x, h)
    x1 = x
    x2 = x1 + h * v
    return x2
end

function solve_v(v, x, t, h, F::Function)
   v1 = v
   next_vt(h,x) = v1 + h * F(x,t)
   v2 = next_vt(h,x)
   return v2
end

function solve_system(v, x, tmax, numtimes, F::Function)
    h = tmax/numtimes
    x1 = x
    v1 = v
    for i in 1:numtimes
        x2 = solve_x(v1, x1, h)
        v2 = solve_v(v1, x2, t, h, F)
        x1 = x2
        v1 = v2
        t += h
    end
    return (x1, v1)
end





end # module Equation_of_motion

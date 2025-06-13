using Equation_of_motion

import Equation_of_motion: solve_x, solve_y, solve_system
using Test

@testset "Equation_of_motion.jl" begin
    @testset "solve_x_test" begin
        v = 1.0
        x = 0.0
        tmax = 10.0
        numtimes = 1000
        @test solve_x(v, x, h) ≈ 0.01 atol=1e-5
    end

    @testset "solve_v_test" begin
        v = 1.0
        x = 1.0
        t = 0.01
        h = 0.01
        F(x, t) = 2.0   # Example function for F
        @test solve_v(v, x, t, h, F) == 1.02  
    end

    @testset "位置と時間に依存しない場合" begin
        F(x, t) = 2.0
        x0, v0 = 0.0, 0.0
        tmax, numtimes = 10.0, 10000
        expected_x = x0 + v0 * tmax + 0.5 * 2.0 * tmax^2
        expected_v = v0 + 2.0 * tmax

        x, v = solve_system(v0, x0, tmax, numtimes, F)
        @test x ≈ expected_x atol=1e-2
        @test v ≈ expected_v atol=1e-3
    end

    @testset "位置に依存する場合(単振動)" begin
    k = 1.0
    ω = 1.0
    F(x, t) = - k * x
    x0, v0 = 1.0, 1.0
    tmax, numtimes = 2π, 10000
    expected_x = 1.0 * cos(ω * tmax) + 1.0 * sin(ω * tmax)
    expected_v = -1.0 * ω * sin(ω * tmax) + 1.0 * ω * cos(ω * tmax)
    x, v = solve_system(v0, x0, tmax, numtimes, F)
    @test x ≈ expected_x atol=1e-2
    @test v ≈ expected_v atol=1e-3
    end

    #@test "位置と時間に依存するばあい"
    #工事中..

end

module TestValidate

using Test, OptimizationModels


@testset "Validation Functionality" begin

    # Test for supertype 
    let 
        struct TestProblem1 end
        @test_throws ArgumentError OptimizationModels.validate_supertype(
            TestProblem1)
        @test_throws ArgumentError validate(TestProblem1)
    end

    # Test for field names 
    let
        struct TestProblem2 <: OptimizationProblem end

        @test_throws ErrorException OptimizationModels.validate_fields(
            TestProblem2)
        @test_throws ErrorException validate(TestProblem2)
    end

    # Test for field type 
    let
        struct TestProblem3 <: OptimizationProblem
            name::Int64
        end

        @test_throws ErrorException OptimizationModels.validate_fields(
            TestProblem3)
        @test_throws ErrorException validate(TestProblem3)
    end

    # Correct Output 
    let
        struct TestProblem4 <: OptimizationProblem
            name::String
            counters::Dict{Symbol, Counter}
            num_param::Int64
            num_obs::Int64
        end

        @test isnothing(validate(TestProblem4))
    end

end

end
module TestValidateCounters

using Test, OptimizationModels

# Test Parameters: Valid Counter 
counters_valid = Dict{Symbol, Counter}(
    :obj => Counter(),
    :grad => Counter(),
    :hess => Counter(),
    :residual => Counter(),
    :jacobian => Counter()
)

# Test Parameters: Invalid Counter 
counters_invalid = Dict{Symbol, Counter}(
    :obj => Counter(),
    :grad => Counter(),
    :hess => Counter(),
    :residual => Counter(),
    :constraint => Counter(),
    :jacobian => Counter()
)

@testset "Counter Validation Functionality" begin

    # Valid Counter 
    @test isnothing(validate_counters(counters_valid))

    # Invalid Counter 
    @test_throws ArgumentError validate_counters(counters_invalid)
    
end

end
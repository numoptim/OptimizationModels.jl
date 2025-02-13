module OptimizationModels

import Base: println, print

#################################
# Counters
#################################
const COUNTER_NAMES = [
    :obj, 
    :grad, 
    :hess, 
    :residual,
    :jacobian,
]
include("counters/counters.jl")
include("counters/print_counters.jl")
include("counters/validate_counters.jl")

export Counter
export reset_block!, reset_batch!, reset! 
export increment_block!, increment_batch!, increment! 
export validate_counters

##################################
# Optimizaiton Problems 
##################################
"""
    abstract type OptimizationProblem end

An abstract type for optimization problems.
"""
abstract type OptimizationProblem end 
const FIELD_NAMESTYPES = [
    :name => String,
    :counters => Dict{Symbol, Counter},
    :num_param => Int64,
    :num_obs => Int64
]
include("validate.jl")

export OptimizationProblem
export validate


end # module OptimizationModels

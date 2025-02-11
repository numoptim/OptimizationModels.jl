"""
    Counter 

A counter for partial evaluations of typical quantities used in solving 
    optimization problems. These counters can be used in a 
    number of contexts:

- Block Selection: For evaluations of objective information 
    (e.g., objective functions, gradient functions, etc.) that only make use 
    of a subset of the parameters.  
- Batch Selection: For evaluations of objective information
    (e.g., objective fucntions, gradient functions, etc.) that is written 
    as the sum of multiple components, but only a subset of the components 
    are used. 
- Block and Batch Selection: Simultaneously doing both of the above situations.


# Fields
- `block_total::Int64`, the number of parameters
- `batch_total::Int64`, the number of additive terms in the objective function 
- `block_equivalent::Float64`, the equivalent number of `batch_total` evaluations 
    given a certain number of coordinate evaluations  
- `batch_equivalent::Float64`, the equivalent number of `block_total` evaluations 
    given evaluations of objective information using only a subset of the
    additive terms.  

# Constructor(s)

    Counter(;block_total::Int64=1, batch_total::Int64=1)

Creates a `Counter` object with `block_equivalent` and `batch_equivalent` 
    set to zero. The optional `block_total` and `batch_total` are set to `1`.
"""
mutable struct Counter 
    batch_total::Int64
    block_total::Int64
    batch_equivalent::Float64
    block_equivalent::Float64
    Counter(batch_total::Int64, block_total::Int64,
        batch_equivalent::Float64, block_equivalent::Float64
    ) = begin

        #Totals must be >= 1
        min(block_total, batch_total) < 1 && throw(
            ArgumentError("Totals cannot be less than 1.")
        )

        # Equivalents must be >= 0
        min(block_equivalent, batch_equivalent) < 0 && throw(
            ArgumentError("Equivalents must be non-negative")
        )

        new(batch_total, block_total, batch_equivalent, block_equivalent)
    end
end
function Counter(;batch_total::Int64=1, block_total::Int64=1)
    return Counter(batch_total, block_total, 0.0, 0.0)
end

"""
    reset_block!(counter::Counter)

Resets the `counter.block_equivalent` to `0.0`.
"""
function reset_block!(counter::Counter)
    counter.block_equivalent = 0.0 
    return
end

"""
    reset_batch!(counter::Counter)

Resets the `counter.batch_equivalent` to `0.0`.
"""
function reset_batch!(counter::Counter)
    counter.batch_equivalent = 0.0 
    return
end

"""
    reset!(counter::Counter)

Resets the `counter.block_equivalent` and `counter.batch_equivalent` to `0`.
"""
function reset!(counter::Counter)
    reset_block!(counter)
    reset_batch!(counter)
    return 
end

"""
    increment_batch!(counter::Counter; size::Int64=1)

Increments the `counter.batch_equivalent` by `size/counter.batch_equivalent`.
"""
function increment_batch!(counter::Counter; size::Int64=1)
    counter.batch_equivalent += size / counter.batch_total 
    return 
end

"""
    increment_block!(counter::Counter; size::Int64=1)

Increments the `counter.block_equivalent` by `size/counter.block_equivalent`.
"""
function increment_block!(counter::Counter; size::Int64=1)
    counter.block_equivalent += size / counter.block_total 
    return 
end

"""
    increment!(counter::Counter; batch_size::Int64=0, block_size::Int64=0)

Increments the `counter.block_equivalent` and `counter.batch_equivalent` by 
    `block_size/counter.block_total` and `batch_size/counter.batch_total`.
"""
function increment!(counter::Counter; batch_size::Int64=0, block_size::Int64=0)
    increment_batch!(counter, size=batch_size)
    increment_block!(counter, size=block_size)
    return 
end
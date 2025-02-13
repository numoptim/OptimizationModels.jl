"""
    validate_counters(counters::Dict{Symbol, Counter})

Validates that counter names are in the allowable list. Throws an error if
    the list is invalid. Returns `nothing` if valid. 
"""
function validate_counters(counters::Dict{Symbol, Counter})
    invalid_names = Symbol[]
    for (name, counter) in counters 
        !(name in COUNTER_NAMES) && push!(invalid_names, name)
    end

    length(invalid_names) > 0 && throw(ArgumentError("The following symbols \
    are not a valid counter name: $invalid_names"))
    
    return
end 
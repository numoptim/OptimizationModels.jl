"""
    validate_supertype(type)

Throws an error if supertype of `type` is not `OptimizationProblem`.
    Otherwise, returns `nothing`.
"""
function validate_supertype(type)
    supertype(type) != OptimizationProblem &&
        throw(ArgumentError("$type is must be a child of abstract type \
        OptimizationProblem."))

    return 
end 

"""
    validate_fields(type)

Checks if the minimum field requirements of `type` and their types are 
    correctly specified. If not, then an `ErrorException` is thrown. 
    Otherwise, returns `nothing`.
"""
function validate_fields(type)
    for nametype in FIELD_NAMESTYPES
        !(nametype[1] in fieldnames(type)) &&
            throw(ErrorException("$(nametype[1]) is not found."))
        
        fieldtype(type, nametype[1]) != nametype[2] &&
            throw(ErrorException("Field $(nametype[1]) must be of type \
            $(nametype[1])."))
    end

    return 
end

"""
    validate(type)

Checks if the supertype of `type` and fields of `type` are in accordance with
    the requirements of the model interface needed by `OptimizationProblem`.
"""
function validate(type)
    validate_supertype(type)
    validate_fields(type)
    return nothing 
end
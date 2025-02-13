# Validation

Minimum required field names and types are

```
[
    :name => String,
    :counters => Dict{Symbol, Counter},
    :num_param => Int64,
    :num_obs => Int64
]
```

The following utilities are exported.

```@docs
validate 
```

Additional utilities are available within the scope of the module.

```@docs
OptimizationModels.validate_supertype

OptimizationModels.validate_fields
```
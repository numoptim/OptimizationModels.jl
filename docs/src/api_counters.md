# Counters

```@docs
Counter
```

## Incrementing Counters

```@docs
increment_block!

increment_batch!

increment!
```

## Resetting Counters

```@docs
reset_block!

reset_batch!

reset!
```

## Validating Counters

Allowed counters are defined within the module as an element of 
```
[
    :obj, 
    :grad, 
    :hess, 
    :residual,
    :jacobian,
]
```

The following function can be used to validate a dictionary of counters.
```@docs 
validate_counters
```

## Printing 

Counters and dictionaries of counters can be printed using the `print` 
or `println` functions. 
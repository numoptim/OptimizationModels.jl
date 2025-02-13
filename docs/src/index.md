# Overview

`OptimizationModels.jl` is a research-tier software package for the Julia
language that provides a uniform interface for modeling optimization problems
arising in data science.
`OptimizationModels.jl` is heavily influenced by the design of
[`NLPModels.jl`](https://github.com/JuliaSmoothOptimizers/NLPModels.jl),
which may be more appropriate for traditional optimization problems,
especially those with constraints. 


## Types of Problems 
The library focuses on objective functions of the form

```math
F(x) = \sum_{i=1}^n f_i(x),
```

where $F:\mathbb{R}^p \to \mathbb{R}$ is the objective function;
$f_i:\mathbb{R}^p \to \mathbb{R}$ are component functions for $i=1,\ldots,n$.
This formulation requires accounting for optimization methods that
solve 
```math
\min_{x} F(x)
```
- Use a subset of the component functions (which we call a batch).
- Use a subset of the coordinates (which we call a block).
- Use both a subset of the component functions and coordinates.

## Encapsulating Problems

An optimization problem must be a `struct` whose parent is of type
`OptimizationProblem`, which is an abstract type provided by this package.

```@docs
OptimizationProblem
```

Any child of `OptimizationProblem` are required to have four fields
(see Validation Utilities section).

- `name::String`, which provides a name to identify the problem.
- `counters::Dict{Symbol, Counter}`, which contains the counters for tracking 
    objective information evaluations (see the Counters section).
- `num_params::Int64`, the number of parameters to be optimized over.
- `num_obs::Int64`, the number of component functions.

Other fields that are specific to the problem are allowed, and, in total,
these fields, when instantiated, must identify a unique optimization problem. 

Let `ExampleProblem` be a child of `OptimizationProblem` with the appropriate
fields. 

Then `ExampleProblem` should implement the following methods with the 
given arguments.

- `obj(x::Vector; problem::ExampleProblem, store::Dict{Symbol, Array},
    batch::AbstractVector{Int64})`, which evaluates the objective function at `x`. The pairs in `store` are used to reduce memory overhead. The elements
    of `batch` specify the indices of the component function used in calculating
    the objective function.
- `grad!(x::Vector; problem::ExampleProblem, store::Dict{Symbol, Array},
    batch::AbstractVector{Int64}, block::AbstractVector{Int64})`, 
    which evaluates the gradient function at `x` at the coordinates specified 
    by the indices in `block`, and using the component functions whose indices
    are specified in `batch`. The pairs in `store` must have one that
    corresponds to `:grad`, where the result of the calculation will be stored.
    The function should return `nothing`. 

If needed, the functions `hess!`, `jacobian!` and `residual!` should be
implemented in a fashion similar to `grad!`. 


## Counters 

A counter tracks the number of evaluations of a specific type of objective
information.
Possible objective information includes 
objective function evaluations, gradient function evaluations, 
Hessian evaluations, residual evaluations (for generalizations of least squares
problems), and Jacobian evaluations (for generalized of least squares problems).

To account for the possibility of using batches and/or blocks, a counter for 
keeps track of the equivalent number of full evaluations for both batches 
and blocks. 

For instance, if the batch $f_{i_{1}},\ldots,f_{i_{j}}$ is used for evaluating 
the objective function, then the objective evaluation batch counter will be 
incremented by $j/n$.
As another example, if only $x_{k_1},\ldots,x_{k_{\ell}}$ are evaluated for 
the gradient function, then the gradient evaluation block counter will be
incremented by $\ell/p$. 

Counters must be stored in a dictionary, `Dict{Symbol, Counter}`, where the 
first argument of a dictionary entry corresponds to the objective information
being tracked. Allowed values are 
`:obj`, `:grad`, `:hess`, `:residual`, and `:jacobian`.

The functions `print` and `println` are extended for `Counter` objects and 
for `Dict{Symbol, Counter}`. 

A function, `validate_counters(counters::Dict{Symbol, Counter})` is provided 
to enforce that only above allowed values are used in specifying the dictionary.
If `nothing` is returned, then the counters are valid.

## Validation Utility

A function `validate` is provided to ensure that a `struct` whose parent is 
`OptimizationProblem` has the appropriate super type, minimum field names, and 
corresponding types for these fields.
If `nothing` is returned, then the `struct` is valid. 


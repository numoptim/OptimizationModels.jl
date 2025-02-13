# Overview

[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://numoptim.github.io/OptimizationModels.jl/dev/)
[![Runtests](https://github.com/numoptim/OptimizationModels.jl/actions/workflows/runtests.yml/badge.svg)](https://github.com/numoptim/OptimizationModels.jl/actions/workflows/runtests.yml)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)



`OptimizationModels.jl` is a research-tier software package for the Julia
language that provides a uniform interface for modeling optimization problems
arising in data science.
`OptimizationModels.jl` is heavily influenced by the design of
[`NLPModels.jl`](https://github.com/JuliaSmoothOptimizers/NLPModels.jl),
which may be more appropriate for traditional optimization problems,
especially those with constraints. 


## Installation

This package is not yet registered in Julia's package official registry.

To install it, you can write in the REPL:

```
] add https://github.com/numoptim/OptimizationModels.jl
```

It is also possible to clone the repository into a local directory. 
In that case, refer to [Julia Pkg instructions](
    https://pkgdocs.julialang.org/v1/environments/#Using-someone-else's-project
).

## License

MIT License
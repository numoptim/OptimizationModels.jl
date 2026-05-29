# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Run all tests:**
```julia
julia --project=test test/runtests.jl
```

**Run a single test file:**
```julia
julia --project=test -e 'include("test/counters/counters.jl")'
```

**Build docs locally:**
```julia
julia --project=docs docs/make.jl
```

## Architecture

`OptimizationModels.jl` provides a uniform interface for optimization problems of the form `F(x) = Σ fᵢ(x)`, targeting methods that use subsets of component functions (batches) and/or subsets of coordinates (blocks).

### Two-layer design

**Layer 1 — Interface definition (`src/OptimizationModels.jl`):**
- `OptimizationProblem`: abstract supertype all problem structs must extend.
- `FIELD_NAMESTYPES`: constant list of the four required fields every `OptimizationProblem` subtype must have (`name::String`, `counters::Dict{Symbol,Counter}`, `num_param::Int64`, `num_obs::Int64`).
- `COUNTER_NAMES`: constant list of allowed counter keys (`:obj`, `:grad`, `:hess`, `:residual`, `:jacobian`).

**Layer 2 — Counters (`src/counters/`):**
- `Counter` (`counters.jl`): mutable struct tracking `batch_equivalent` and `block_equivalent` as normalized floats (incremented by `size/total`), plus the fixed `batch_total` and `block_total` denominators.
- `print_counters.jl`: extends `Base.print`/`Base.println` for `Counter` and `Dict{Symbol, Counter}`.
- `validate_counters.jl`: `validate_counters` checks dict keys against `COUNTER_NAMES`.

**Validation (`src/validate.jl`):**
- `validate(type)`: call at problem-definition time to check supertype and required fields/types. This is a design-time guard, not a runtime one.

### Test organization

`test/runtests.jl` reads `test/test.txt` and `include`s each listed path in order. Each test file defines its own module (e.g., `module TestCounters`). To add a new test file, create it and add its relative path to `test/test.txt`.

### Implementing a new optimization problem

A concrete problem struct must:
1. Subtype `OptimizationProblem`
2. Include the four required fields from `FIELD_NAMESTYPES`
3. Populate `counters` with keys from `COUNTER_NAMES` only
4. Call `validate(MyProblem)` to confirm correctness
5. Implement `obj`, `grad!`, and any needed `hess!`, `residual!`, `jacobian!` with the prescribed signatures (see `docs/src/index.md`)

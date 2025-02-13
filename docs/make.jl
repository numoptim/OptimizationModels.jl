using Documenter 
using OptimizationModels

makedocs(
    sitename="OptimizationModels Documentation",
    pages = [
        "Overview" => "index.md",
        "API" => [
            "Counters" => "api_counters.md",
            "Validation" => "api_validation.md",
        ]
    ]
)

deploydocs(
    repo = "github.com/numoptim/OptimizationModels.jl",
)
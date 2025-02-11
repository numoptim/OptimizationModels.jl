function println(name::Symbol, counter::Counter)
    println(
    """$name:
    \tBlock: $(counter.block_equivalent) (total: $(counter.block_total))
    \tBatch: $(counter.batch_equivalent) (total: $(counter.batch_total))"""
    )
    return
end
function print(name::Symbol, counter::Counter)
    println(name, counter)
    return
end

function println(counters::Dict{Symbol, Counter})
    for (name, cntr) in counters
        println(name, cntr)
    end
    return 
end
function print(counters::Dict{Symbol, Counter})
    println(counters)
    return 
end
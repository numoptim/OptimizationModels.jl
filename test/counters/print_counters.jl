module TestPrintCounters

using Test, OptimizationModels 

# Testing Parameters Single Counter 
cntr = Counter() 
name = :Test

single_comparison_string = """Test:
\tBlock: 0.0 (total: 1)
\tBatch: 0.0 (total: 1)
"""

# Test Parameters Multiple Counters 
counters = Dict{Symbol, Counter}(
    :Test1 => Counter(),
    :Test2 => Counter()
)

multi_comparison_string = """Test1:
\tBlock: 0.0 (total: 1)
\tBatch: 0.0 (total: 1)
Test2:
\tBlock: 0.0 (total: 1)
\tBatch: 0.0 (total: 1)
"""

@testset "Counter Printing Functionality" begin

    # Test println for single counter
    let 
        original_stdout = stdout;
        (read_pipe, write_pipe) = redirect_stdout();
        
        println(name, cntr)

        redirect_stdout(original_stdout);
        close(write_pipe)
        @test read(read_pipe, String) == single_comparison_string 
    end 

    # Test print for single counter
    let 
        original_stdout = stdout;
        (read_pipe, write_pipe) = redirect_stdout();
        
        print(name, cntr)

        redirect_stdout(original_stdout);
        close(write_pipe)
        @test read(read_pipe, String) == single_comparison_string 
    end 

    # Test println for counter dictionary
    let 
        original_stdout = stdout;
        (read_pipe, write_pipe) = redirect_stdout();
        
        println(counters)

        redirect_stdout(original_stdout);
        close(write_pipe)
        @test read(read_pipe, String) == multi_comparison_string
    end

    # Test println for counter dictionary
    let 
        original_stdout = stdout;
        (read_pipe, write_pipe) = redirect_stdout();
        
        print(counters)

        redirect_stdout(original_stdout);
        close(write_pipe)
        @test read(read_pipe, String) == multi_comparison_string
    end

end

end



module TestCounters 

using Test, OptimizationModels

@testset "Counter Core Functionality" begin 

    # Constructor errors 
    @test_throws ArgumentError Counter(0, 1, 0.0, 0.0)
    @test_throws ArgumentError Counter(1, 0, 0.0, 0.0)
    @test_throws ArgumentError Counter(1, 1, -0.1, 0.0)
    @test_throws ArgumentError Counter(1, 1, 0.0, -0.1)

    # Constructor resets
    let cntr = Counter(10, 5, 0.5, 2.0)
        # Verify start values
        @test cntr.batch_equivalent == 0.5 
        @test cntr.block_equivalent == 2.0
        
        # Reset batch 
        reset_batch!(cntr)
        @test cntr.batch_equivalent == 0.0
        @test cntr.block_equivalent == 2.0

        # Reset block 
        reset_block!(cntr)
        @test cntr.block_equivalent == 0.0 
    end

    let cntr = Counter(10, 5, 0.5, 2.0)
        
        # Verify start values
        @test cntr.batch_equivalent == 0.5 
        @test cntr.block_equivalent == 2.0
        
        # Reset batch 
        reset!(cntr)
        @test cntr.batch_equivalent == 0.0
        @test cntr.block_equivalent == 0.0
    end

    # Test Increments 
    let cntr = Counter(10, 5, 0.5, 2.0)
        # Verify start values
        @test cntr.batch_equivalent == 0.5 
        @test cntr.block_equivalent == 2.0

        # Increment batch by default 
        increment_batch!(cntr) #size default is 1 
        @test cntr.batch_equivalent == 0.5 + 0.1 

        # Increment batch by non-default value 
        increment_batch!(cntr, size=5)
        @test cntr.batch_equivalent == 0.5 + 0.1 + 0.5

        # Increment block by default 
        increment_block!(cntr) 
        @test cntr.block_equivalent == 2.0 + 0.2

        # Increment block by non-default 
        increment_block!(cntr, size=8)
        @test cntr.block_equivalent == 2.0 + 0.2 + 1.6

        # Increment both block and batch simultaneously
        increment!(cntr, batch_size=3, block_size=2)
        @test cntr.batch_equivalent == 0.5 + 0.1 + 0.5 + 0.3
        @test cntr.block_equivalent == 2.0 + 0.2 + 1.6 + 0.4
    end

end


end
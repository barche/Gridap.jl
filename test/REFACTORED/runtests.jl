module GridapTests

using Test

@time @testset "Utils" begin include("UtilsTests/files.jl") end

@time @testset "CellValues" begin include("CellValuesTests/files.jl") end

end # module

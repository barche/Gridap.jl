module FESpacesTests2

using Test

@testset "FESpacesWithConstantFixed" begin include("FESpacesWithConstantFixedTests.jl") end

@testset "ZeroMeanFESpaces" begin include("ZeroMeanFESpacesTests.jl") end

@testset "CLagrangianFESpaces" begin include("CLagrangianFESpacesTests.jl") end

@testset "DirichletFESpaces" begin include("DirichletFESpacesTests.jl") end

@testset "ExtendedFESpaces" begin include("ExtendedFESpacesTests.jl") end

@testset "FESpacesWithLinearConstraints" begin include("FESpacesWithLinearConstraintsTests.jl") end

@testset "FEAutodiff" begin include("FEAutodiffTests.jl") end

@testset "FETermsWithAutodiff" begin include("FETermsWithAutodiffTests.jl") end

@testset "CellDofBases" begin include("CellDofBasesTests.jl") end

@testset "Law" begin include("LawTests.jl") end

@testset "CDLagrangianFESpaces" begin include("CDLagrangianFESpacesTests.jl") end

@testset "PhysicalBasesTests" begin include("PhysicalBasesTests.jl") end

@testset "PhysicalFESpaces" begin include("PhysicalFESpacesTests.jl") end

@testset "FESpaceFactories" begin include("FESpaceFactoriesTests.jl") end

@testset "AppendedTriangulations" begin include("AppendedTriangulationsTests.jl") end

end # module

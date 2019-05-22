
include("FESpaces.jl")

include("Assemblers.jl")

module AssemblersTests

using Test
using Gridap
using Gridap.Geometry
using Gridap.CellMaps
using Gridap.Geometry.Cartesian
using Gridap.CellQuadratures
using Gridap.CellIntegration

using ..FESpaces
using ..Assemblers

model = CartesianDiscreteModel(domain=(0.0,1.0,0.0,1.0), partition=(2,2))

tags = [1,2,3,4,6,5]

order = 1
fespace = ConformingFESpace(Float64,model,order,tags)

assem = SparseMatrixAssembler(fespace,fespace)

trian = triangulation(model)

quad = quadrature(trian,order=2)

basis = CellBasis(fespace)

a(v,u) = varinner(∇(v), ∇(u))

bfun(x) = x[2] 

b(v) = varinner(v,cellfield(trian,bfun))

mmat = integrate(a(basis,basis),trian,quad)

bvec = integrate(b(basis),trian,quad)

vec = assemble(assem, bvec)

mat = assemble(assem, mmat)

x = mat \ vec

@show vec
@show mat
@show x


end # module AssemblersTests
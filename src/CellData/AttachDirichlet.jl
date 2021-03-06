
function attach_dirichlet(cellmatvec,cellvals,cellmask=Fill(true,length(cellvals)))
  k = AttachDirichletKernel()
  apply(k,cellmatvec,cellvals,cellmask)
end

struct AttachDirichletKernel <: Kernel
  muladd::MulAddKernel{Int}
  AttachDirichletKernel() = new(MulAddKernel(-1,1))
end

function Arrays.kernel_cache(k::AttachDirichletKernel,matvec::Tuple,vals,mask)
  mat, vec = matvec
  kernel_cache(k.muladd,mat,vals,vec)
end

@inline function Arrays.apply_kernel!(cache,k::AttachDirichletKernel,matvec::Tuple,vals,mask)
  if mask
    mat, vec = matvec
    vec_with_bcs = apply_kernel!(cache,k.muladd,mat,vals,vec)
    (mat, vec_with_bcs)
  else
    matvec
  end
end

function Arrays.kernel_cache(k::AttachDirichletKernel,mat::AbstractMatrix,vals,mask)
  cm = kernel_cache(MulKernel(),mat,vals)
  cv = CachedArray(mat*vals)
  fill!(cv.array,zero(eltype(cv)))
  (cm,cv)
end

@inline function Arrays.apply_kernel!(cache,k::AttachDirichletKernel,mat::AbstractMatrix,vals,mask)
  cm, cv = cache
  if mask
    vec_with_bcs = apply_kernel!(cm,MulKernel(),mat,vals)
    scale_entries!(vec_with_bcs,-1)
    (mat, vec_with_bcs)
  else
    if size(mat,1) != size(cv,1)
      m = axes(mat,1)
      setaxes!(cv,(m,))
      fill!(cv.array,zero(eltype(cv)))
    end
    (mat, cv.array)
  end
end

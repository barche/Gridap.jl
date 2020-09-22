# Number differentiation

function gradient(f::T) where T <: Number
  @inline function grad_f(x::P) where P <: Point
    zero(return_type(outer,T,P))
  end
end

function hessian(f::T) where T <: Number
@inline function hess_f(x::P) where P <: Point
  zero(return_type(outer,return_type(outer,T,P),P))
end
end

# Automatic differentiation of functions

function gradient(f::Function)
  function grad_f(x)
    _grad_f(f,x,zero(return_type(f,typeof(x))))
  end
end

function _grad_f(f,x,fx)
  VectorValue(ForwardDiff.gradient(f,get_array(x)))
end

function _grad_f(f,x,fx::VectorValue)
  TensorValue(transpose(ForwardDiff.jacobian(y->get_array(f(y)),get_array(x))))
end

function _grad_f(f,x,fx::MultiValue)
  @notimplemented
end

function divergence(f::Function)
  x -> tr(ForwardDiff.jacobian(y->get_array(f(y)),get_array(x)))
end

function curl(f::Function)
  x -> grad2curl(TensorValue(transpose(ForwardDiff.jacobian(y->get_array(f(y)),get_array(x)))))
end

function laplacian(f::Function)
  function lapl_f(x)
    _lapl_f(f,x,zero(return_type(f,typeof(x))))
  end
end

function _lapl_f(f,x,fx)
  tr(ForwardDiff.jacobian(y->ForwardDiff.gradient(f,y), get_array(x)))
end

function _lapl_f(f,x,fx::VectorValue)
  A = length(x)
  B = length(fx)
  a = ForwardDiff.jacobian(y->transpose(ForwardDiff.jacobian(z->get_array(f(z)),y)), get_array(x))
  tr(ThirdOrderTensorValue{A,A,B}(Tuple(transpose(a))))
end

function _lapl_f(f,x,fx::MultiValue)
  @notimplemented
end

function symmetric_gradient(f::Function)
    x -> symmetric_part(_grad_f(f,x,zero(return_type(f,typeof(x)))))
end
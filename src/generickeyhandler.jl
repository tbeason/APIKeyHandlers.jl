

mutable struct GenericKeyHandler <: AbstractKeyHandler
    name::AbstractString
    api_url::AbstractString
    key::AbstractString
end


function GenericKeyHandler(nm,url;kwargs...)
    kh = GenericKeyHandler(nm,url,"")
    key = load_key!(kh;kwargs...)
    return kh
end





    
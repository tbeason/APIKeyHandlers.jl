module APIKeyHandlers

using ConfParser
using Printf

export AbstractKeyHandler
export get_name, get_key, get_api_url
export set_name!, set_key!, set_api_url!
export load_key!, load!, save!

export GenericKeyHandler

include("abstractkeyhandler.jl")
include("generickeyhandler.jl")



end # module

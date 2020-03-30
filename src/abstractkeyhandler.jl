abstract type AbstractKeyHandler end
# required get methods: get_name, get_key, get_api_url
# required set methods: set_name!, set_key!, set_api_url!, load_key!



"""
`get_name(kh::AbstractKeyHandler)`

Returns the `name` property of the key handler.
"""
get_name(kh::AbstractKeyHandler) = getproperty(kh,:name)

"""
`get_api_url(kh::AbstractKeyHandler)`

Returns the `api_url` property of the key handler.
"""
get_api_url(kh::AbstractKeyHandler) = getproperty(kh,:api_url)


"""
`get_key(kh::AbstractKeyHandler)`

Returns the `key` property of the key handler.
"""
get_key(kh::AbstractKeyHandler) = getproperty(kh,:key)


"""
`set_name!(kh::AbstractKeyHandler)`

Returns the `name` property of the key handler.
"""
set_name!(kh::AbstractKeyHandler,newname::AbstractString) = setproperty!(kh,:name,newname)

"""
`set_api_url!(kh::AbstractKeyHandler)`

Returns the `api_url` property of the key handler.
"""
set_api_url!(kh::AbstractKeyHandler,newurl::AbstractString) = setproperty!(kh,:api_url,newurl)

"""
`set_key!(kh::AbstractKeyHandler)`

Returns the `key` property of the key handler.
"""
set_key!(kh::AbstractKeyHandler,newkey::AbstractString) = setproperty!(kh,:key,newkey)



function Base.show(io::IO, kh::AbstractKeyHandler)
    @printf io "API Key Handler\n"
    @printf io "\tname: %s\n" get_name(kh)
    @printf io "\turl: %s\n" get_api_url(kh)
    @printf io "\tkey: %s\n" get_key(kh)
end


"""
`load_key!(kh::AbstractKeyHandler; KEY_ENV_NAME="", KEY_FILE_NAME="", verbose=false)`

Attempts to load the `key` from one of two stored locations. It first looks in `ENV[KEY_ENV_NAME]`
and then looks the file `KEY_FILE_NAME`, which should be a path to the file.

`KEY_FILE_NAME` can take the form of any of configurations available in `ConfParser.jl` provided that
 1. For `syntax=keyonly": the key by itself on a single line, with nothing else in the file.
 2. For all others: your key is indexed by the word "key", outside of a named block.

If found, the key is set using `set_key!(kh,key)`.
"""
function load_key!(kh::AbstractKeyHandler;KEY_ENV_NAME::AbstractString="", KEY_FILE_NAME::AbstractString="", verbose::Bool=false)
    key = ""
    if !isempty(KEY_ENV_NAME) & haskey(ENV,KEY_ENV_NAME)
        verbose && println("Key loaded from ENV variable $(KEY_ENV_NAME)")
        key = ENV[KEY_ENV_NAME]
        set_key!(kh,key)
    elseif !isempty(KEY_FILE_NAME) & isfile(KEY_FILE_NAME)
        conf = ConfParse(KEY_FILE_NAME)
        parse_conf!(conf)
        key = retrieve(conf,"key")
        set_key!(kh,key)
        verbose && println("Key loaded from file $(KEY_FILE_NAME)")
    else
        error("Key not detected.")
    end
    isempty(key) && error("Key not detected.")
    nothing
end


"""
`load!(kh::AbstractKeyHandler,filename::AbstractString;verbose::Bool=false)`

Load the key handler data from a configuration file. `filename` can take the form of any of configurations available in `ConfParser.jl` provided that
 1. The information sits in the first block of the file.
 2. The information is indexed by `name`, `api_url`, and `key`.
"""
function load!(kh::AbstractKeyHandler,filename::AbstractString;verbose::Bool=false)
    isempty(filename) && error("Invalid filename: $(filename)")
    !isfile(filename) && error("Invalid filename (does not exist): $(filename)")
    
    conf = ConfParse(filename)
    parse_conf!(conf)
    verbose && println("Configuration file found with syntax $(conf._syntax).")
    if !isequal(conf._syntax,"ini")
        nm = retrieve(conf,"name")
        url = retrieve(conf,"api_url")
        key = retrieve(conf,"key")
    else
        blockname = first(keys(conf._data))
        nm = retrieve(conf,blockname,"name")
        url = retrieve(conf,blockname,"api_url")
        key = retrieve(conf,blockname,"key")
    end


    set_name!(kh,nm)
    set_api_url!(kh,url)
    set_key!(kh,key)

    nothing
end
    


"""
`save!(kh::AbstractKeyHandler,filename::AbstractString;verbose::Bool=false)`

Save the key handler data to a configuration file. `filename` can take the form of any of configurations available in `ConfParser.jl`. If `filename` exists, the same configuration is used but the data overwritten. If it does not exist, `defaultsyntax` is used.
"""
function ConfParser.save!(kh::AbstractKeyHandler,filename::AbstractString;defaultsyntax::AbstractString="ini")
    isempty(filename) && error("Invalid filename: $(filename)")
    if isfile(filename)
        conf = ConfParse(filename)
        parse_conf!(conf)
        if !isequal(conf._syntax,"ini")
            commit!(conf,"name",get_name(kh))
            commit!(conf,"api_url",get_api_url(kh))
            commit!(conf,"key",get_key(kh))
        else
            blockname = first(keys(conf._data))
            commit!(conf,blockname,"name",get_name(kh))
            commit!(conf,blockname,"api_url",get_api_url(kh))
            commit!(conf,blockname,"key",get_key(kh))
            
        end
        

        save!(conf,filename)
    else
        fh = open(filename,"w")
        if isequal(defaultsyntax,"keyonly")
            print(fh,get_key(kh))
            close(fh)
        else
            sep = ""
            if isequal(defaultsyntax,"ini")
                sep = "="
            elseif isequal(defaultsyntax,"http")
                sep = ":"
            elseif isequal(defaultsyntax,"simple")
                sep = " "
            else
                error("Syntax $(defaultsyntax) not found.")
            end
            println(fh,"name",sep,get_name(kh))
            println(fh,"api_url",sep,get_api_url(kh))
            print(fh,"key",sep,get_key(kh))
            close(fh)
        end
    end
end


        










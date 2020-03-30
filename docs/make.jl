using Documenter, APIKeyHandlers

makedocs(
    modules = [APIKeyHandlers],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Tyler Beason",
    sitename = "APIKeyHandlers.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/tbeason/APIKeyHandlers.jl.git",
    push_preview = true
)

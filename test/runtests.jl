using APIKeyHandlers
using Test

const servicename = "APIAPI"
const serviceurl = "https://api.api.com"
const servicekey = "mykeyiscool123"

g = GenericKeyHandler(servicename,serviceurl,servicekey)

@testset "Getting" begin
    @test get_name(g) == servicename
    @test get_api_url(g) == serviceurl
    @test get_key(g) == servicekey
end

@testset "Setting" begin
    set_name!(g,"API1")
    set_api_url!(g,"https://api2.api.com")
    set_key!(g,"coolerkey2")
    @test get_name(g) == "API1"
    @test get_api_url(g) == "https://api2.api.com"
    @test get_key(g) == "coolerkey2"
end

@testset "IO" begin
    g = GenericKeyHandler(servicename,serviceurl,servicekey)
    save!(g,abspath(joinpath(@__DIR__, "..", "test", "config.ini")))

    g2 = GenericKeyHandler("name","url","key")

    load!(g2,abspath(joinpath(@__DIR__, "..", "test", "config.ini")))
    @test get_name(g2) == servicename
    @test get_api_url(g2) == serviceurl
    @test get_key(g2) == servicekey

    rm(abspath(joinpath(@__DIR__, "..", "test", "config.ini")))
end




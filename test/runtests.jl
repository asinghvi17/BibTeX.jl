using Test
using BibTeX

@testset "Parsing invalid specs" begin
    
    @test_throws ErrorException parse_bibtex("@book")
    
    @test_throws ErrorException parse_bibtex("@book@")
    
    
end

@testset "Parsing a file" begin
    
    preamble, result = joinpath((@__FILE__) |> dirname |> dirname, "example", "examples.bib") |> f -> read(f, String) |> parse_bibtex
    
    @test preamble == "some instructions"
    
    @test result["b"]["type"] == "a"
    
    @test result["b"]["c"] == "{ c } c"
    
    @test result["b"]["d"] == "d d"
    
    @test result["b"]["e"] == "f short"
    
end

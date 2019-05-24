using Test
using BibTeX

@testset "Parsing invalid specs" begin
    
    @test_throws ErrorException parse_bibtex("@book")
    
    @test_throws ErrorException parse_bibtex("@book@")
    
    
end

@testset "Minimal functionality test" begin
    
    preamble, result = parse_bibtex(""\"
            @preamble{some instructions}
            @comment blah blah
            @string{short = long}
            @a{b,
              c = { {c} c},
              d = "d d",
              e = f # short
            }
            ""\");
    
    @test preamble == ""
    
    @test result["b"]["type"] == "a"
    
    @test result["b"]["c"] == "{ c } c"
    
    @test result["b"]["d"] == "d d"
    
    @test result["b"]["e"] == "f short"
    
end

# APIKeyHandlers.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.com/tbeason/APIKeyHandlers.jl.svg?branch=master)](https://travis-ci.com/tbeason/APIKeyHandlers.jl)
[![codecov.io](http://codecov.io/github/tbeason/APIKeyHandlers.jl/coverage.svg?branch=master)](http://codecov.io/github/tbeason/APIKeyHandlers.jl?branch=master)
<!--
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://tbeason.github.io/APIKeyHandlers.jl/stable)
[![Documentation](https://img.shields.io/badge/docs-master-blue.svg)](https://tbeason.github.io/APIKeyHandlers.jl/dev)
-->


Many services with online APIs require user authentication via API keys or Generic Access Tokens. This package implements the primitive functionality of loading these keys for use, allowing package developers to focus on implementing the rest of the API.

It is a lightweight package that relies only on `ConfParser.jl` and the Julia standard library.

# IMPORTANT

This package is very fresh. Too fresh. Use at your own risk.

## Implementations
For examples of packages that have implemented this functionality, see
 - [Bitly.jl]()
 - ...


## Should Implement

For examples of packages that **should** (:smile:) implement this functionality, see
 - [FredData.jl]()
 - [BeaData.jl]()
 - [BlsData.jl]()
 - [Quandl.jl]()
 - [AlphaVantage.jl]()
 - [NewsAPI.jl]()

and many more. This is a very common authentication technique!

## Details

Most packages using a single API key can probably directly use the `GenericKeyHandler` type (or subtype it). See the online documentation or `? GenericKeyHandler` in the REPL for help.

The package defines an `AbstractKeyHandler` type, which can be extended if needed. 




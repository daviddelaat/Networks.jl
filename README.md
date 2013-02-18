Networks.jl
===========

# Introduction

The Networks package is a library for working with Graphs in Julia. A Networks.jl `Graph` is a datastructure where the nodes and edges can be arbitrary Julia types, with the only restriction that nodes should be hashable. This allows the user to use meaningful types as nodes and edges. The design is borrowed from the Python NetworkX package 

# The `Graph` type

The `Graph` type is used to represent undirected graphs. It has one field, named `adj`, which is of type `Dict{Any, Dict{Any, Any}}`. The keys of `adj` correspond to the nodes of the graph (this is why node objects should be hashable), and the values consist of other dictionaries containing the incident node objects (as keys) and edge objects (as values). If `g` is a graph containing both nodes `u` and `v`, then we always have that `g[u][v]` is equal to `g[v][u]`.

# Example

		using Networks

		g = Graph()

		addnode!(g, 1)
		
		# Here we use an ASCIIString object as node
		addnode!(g, "test")
		
		addedge!(g, 1, "test")
		
		# Nonexistend nodes will be added automatically
		addedge!(g, 'a', 'b')
		
		addcycle!(g, 5:10)

		# Show the graph g
		show(g)

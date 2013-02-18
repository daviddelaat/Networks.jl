module Networks

import 
    Base.show,
    Base.copy,
    Base.isequal,
    Base.ref

export 
    Graph,
    
    adj,
    nodes, 
    edges, 
    addnode!,
    deletenode!,
    order,
    neighbors,
    nonneighbors,
    degree,
    addedge!,
    deleteedge!,
    subgraph,
    complement,
    size,
    
    addpath!,
    addpath,
    addcycle!,
    addcycle,
    addcompletegraph!,
    addcompletegraph,
    addstargraph!,
    addstargraph,
    
    adjacency_matrix,
    
    intersecting_permutations_graph,
    
    is_independent_set,
    greedy_maximal_independent_set,
    is_maximal_independent_set,
    approx_max_independent_set,

    is_clique,
    greede_maximal_clique,
    approx_max_clique

include("graph.jl")
include("graph_construction.jl")
include("matrix_representations.jl")
include("heuristics_for_maximum_independent_sets_and_cliques.jl")
include("intersecting_permutations.jl")
include("independent_sets.jl")
include("cliques.jl")

end

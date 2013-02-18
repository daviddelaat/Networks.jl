type Graph
    adj::Dict{Any, Dict{Any, Any}}   
end

Graph() = Graph(Dict{Any, Dict{Any, Any}}())

adj(g::Graph) = g.adj

nodes(g::Graph) = Set(keys(adj(g))...)

neighbors(g::Graph, u) = Set(keys(adj(g)[u])...)

hasnode(g::Graph, u) = has(adj(g), u)

function hasedge(g::Graph, u, v)
    t = get(adj(g), u, nothing)
    if t != nothing
        return has(t, v)
    end
    false
end

order(g::Graph) = length(adj(g))

function show(io::IO, g::Graph)
    n = order(g)
    print(io, "$n-node Graph:")
    for (u, el) in adj(g)
        println(io)
        print(io, u)
        print(io, ':')
        for v in keys(el)
            print(io, ' ')
            print(io, v)
        end
    end
end

function isequal(g1::Graph, g2::Graph)
    if nodes(g1) != nodes(g2)
        return false
    end
    
    for u in nodes(g1)
        if neighbors(g1, u) != neighbors(g2, u)
            return false
        end
    end
    
    true
end

function addnode!(g::Graph, u)
    if !hasnode(g, u)
        adj(g)[u] = Dict()
    end
    nothing
end

function addnodes!(g::Graph, nodes)
    for u in nodes
        addnode!(g, u)
    end
end

function deletenode!(g::Graph, u)
    for v in keys(adj(g)[u])
        delete!(adj(g)[v], u)
    end
    delete!(adj(g), u)
end

function deletenodes!(g::Graph, nodes)
    for u in nodes
        deletenode!(g, u)
    end
end

numedges(g::Graph) = sum([length(u) for u in adj(g)]) // 2

function addedge!(g::Graph, u, v, edgeobj)
    addnode!(g, u)
    addnode!(g, v)
    adj(g)[u][v] = edgeobj
    adj(g)[v][u] = edgeobj
end
addedge!(g::Graph, u, v) = addedge!(g, u, v, nothing)

function deleteedge!(g::Graph, u, v)
    delete!(adj(g)[u], v)
    delete!(adj(g)[v], u)
end

degree(g::Graph, u) = length(adj(g)[u])

nonneighbors(g::Graph, u) = nodes(g) - (neighbors(g, u) | Set(u))

clear!(g::Graph) = adj(g) = Dict()

function subgraph(g::Graph, nodeset::Set)
    sg = Graph()
    
    for u in nodeset
        addnode!(sg, u)
    end
    
    for (u, el) in adj(g)
        for (v, edgeobj) in el
            if has(nodeset, u) && has(nodeset, v)
                addedge!(sg, u, v, edgeobj)
            end
        end
    end
            
    sg
end

copy(g::Graph) = subgraph(g, nodes(g))

function complement(g::Graph)
    cg = Graph()
    
    for (u, _) in adj(g)
        addnode!(cg, u)
    end
    
    for (u, el) in adj(g)
        for (v, _) in adj(g)
            if !has(el, v) && u != v
                addedge!(cg, u, v)
            end
        end
    end
    
    cg
end

adjacent(g::Graph, u, v) = has(neighbors(g, u), v)
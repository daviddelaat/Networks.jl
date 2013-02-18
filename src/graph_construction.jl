function addpath!(g::Graph, nodes)
    prev = nothing
    for u in nodes
        if prev != nothing
            addedge!(g, u, prev)
        end
        prev = u
    end 
end
addpath(g::Graph, nodes) = addpath!(copy(g), nodes)

function addcycle!(g::Graph, nodes)
    addpath!(g, nodes)
    addedge!(g, nodes[1], nodes[end])
end
addcycle(g::Graph, nodes) = addcycle!(copy(g), nodes)

function addcompletegraph!(g::Graph, nodes)
    for u in nodes
        for v in nodes
            if u != v
                addedge!(g, u, v)
            end
        end
    end
end
addcompletegraph(g::Graph, nodes) = addcompletegraph!(copy(g), nodes)

function addstargraph!(g::Graph, centernode, othernodes)
    for u in othernodes
        addedge!(g, centernode, u)
    end
end
addstargraph(g::Graph, centernode, othernodes) = addcompletegraph!(copy(g), centernode, othernodes)
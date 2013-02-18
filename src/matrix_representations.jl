function adjacency_matrix(g::Graph, nodevec::Vector)
    n = length(nodevec)

    m = BitArray(n, n)
    
    for i = 1:n
        u = nodevec[i]
        for v in neighbors(g, u)
            j = findfirst(nodevec, v)
            if j != 0
                m[i, j] = true
            end
        end
    end
    
    m   
end

adjacency_matrix(g::Graph) = adjacency_matrix(g, keys(adj(g)))
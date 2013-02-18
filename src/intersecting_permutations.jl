function intersecting_permutations_graph(n, k)
    g = Graph()
    
    for i = 1:factorial(n)
        addnode!(g, nthperm([1:n], i))
    end
    
    for u in nodes(g)
        for v in nodes(g)
            t = v[invperm(u)]
            fixedpoints = 0
            for i = 1:n
                if i == t[i]
                    fixedpoints += 1
                end
            end
            if fixedpoints < k
                addedge!(g, u, v)
            end
        end
    end
       
    g     
end

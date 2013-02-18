function is_independent_set(g::Graph, nodes)
    for u in nodes
        for v in nodes
            if adjacent(g, u, v)
                return false
            end
        end
    end
    true
end

# Extends the independent set `iset` to a maximal independent set in a greedy way
function greedy_maximal_independent_set(g::Graph, iset::Set)
    for u in nodes(g) - iset
        independent = true
        for v in iset
            if adjacent(g, u, v)
                independent = false
                break
            end
        end
        if independent
            return greedy_maximal_independent_set(g::Graph, iset | Set(u))
        end
    end
    iset        
end

is_maximal_independent_set(g::Graph, iset::Set) = 
    is_independent_set(g, iset) && iset == greedy_maximal_independent_set(g, iset)
    
approx_max_independent_set(g::Graph) = clique_removal_algorithm(g)[1]

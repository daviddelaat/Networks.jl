function is_clique(g::Graph, nodes)
    for u in nodes
        for v in nodes
            if !adjacent(g, u, v) && u != v
                return false
            end
        end
    end
    true
end

# Extends the clique `clique` to a maximal clique set in a greedy way
function greedy_maximal_clique(g::Graph, clique::Set)
    for u in nodes(g) - clique
        ok = true
        for v in clique
            if !adjacent(g, u, v)
                ok = false
                break
            end
        end
        if ok
            return greedy_maximal_clique(g::Graph, iset | Set(u))
        end
    end
    iset
end


approx_max_clique(g::Graph) = clique_removal_algorithm(complement(g))[1]

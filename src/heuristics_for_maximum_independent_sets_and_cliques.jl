# Algorithms taken from the NetworkX library (which is BSD licenced by Nicholas Mancuso)
# Based on the paper:
# Boppana, R., & Halldórsson, M. M. (1992).
# Approximating maximum independent sets by excluding subgraphs.
# BIT Numerical Mathematics, 32(2), 180–196. Springer.
# doi:10.1007/BF01994876

function approx_ramsey(g::Graph)
    if order(g) == 0
        return Set(), Set()
    end
    s = nodes(g); u = s.hash.keys[start(s.hash)]
    c1, i1 = approx_ramsey(subgraph(g, neighbors(g, u)))
    c2, i2 = approx_ramsey(subgraph(g, nonneighbors(g, u)))
    add!(c1, u)
    add!(i2, u)
    c = length(c1) >= length(c2) ? c1 : c2
    i = length(i1) >= length(i2) ? i1 : i2
    c, i
end

function clique_removal_algorithm(g::Graph)
    gr = copy(g)
    
    c, i = approx_ramsey(gr)
    
    cliques = Set(c)
    isets = Set(i)
    
    while order(gr) > 0
        deletenodes!(gr, c)
        c, i = approx_ramsey(gr)
        
        if length(c) > 0
            add!(cliques, c)
        end
        
        if length(i) > 0
            add!(isets, i)
        end
    end
    
    max(isets), cliques
end

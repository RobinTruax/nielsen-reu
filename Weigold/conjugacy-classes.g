generatesFull := function(tuple, G)
    local U;
    U := Subgroup(G, tuple);
    if Index(G, U) = 1 then
        return true;
    fi; 
    return false;
end;

randomStep := function(tuple, G)
    local l,i,j,k,U;

    # Determine Indices
    l := [1 .. 3];
    i := Random(l);
    Remove(l, i);
    j := Random(l);
    Remove(l, j);
    k := l[1];

    # Step
    if Random([0,1]) = 1 then
        tuple[i] := tuple[j]^(Random([-1,1])) * tuple[i];
    else
        tuple[i] := tuple[i] * tuple[j]^(Random([-1,1]));
    fi; 

    # Test For Full Generation
    if generatesFull([tuple[i], tuple[k]], G) then
        return true;
    fi; 

    # Otherwise Return Tuple
    return tuple;
end; 

explore := function(tuple, G, maximum)
    local i;
    for i in [1 .. maximum] do
        tuple := randomStep(tuple, G);
        if tuple = true then
            return true;
        fi;
    od;
    return false;
end;

testConjecture := function(G, N, M)
    local maxSubgroups, conjClasses, conClass, sigma_1, centralizer, maximal, randomInCent, smallest, sigma_2, sigma_3, U, count, total, i;
    maxSubgroups := MaximalSubgroups(G);
    count := 0;
    conjClasses := ConjugacyClasses(G);
    total := Length(conjClasses);
    for conClass in conjClasses do
        count := count + 1;
        #Print(count, "/", total, "\n");
        sigma_1 := Representative(conClass);
        for maximal in maxSubgroups do
            if sigma_1 in maximal then
                centralizer := Centralizer(maximal, sigma_1);
                smallest := true;
                for sigma_2 in maximal do
                    for i in [1 .. N] do
                        randomInCent := Random(centralizer);
                        if sigma_2 > randomInCent^(-1) * sigma_2 * randomInCent then
                            smallest := false;
                            break;
                        fi; 
                    od; 
                    if smallest then
                        U := Subgroup(G, [sigma_1, sigma_2]);
                        for sigma_3 in RightTransversal(G, U) do
                            if generatesFull([sigma_1, sigma_2, sigma_3], G) then
                                if explore([sigma_1, sigma_2, sigma_3], G, M) = false then
                                    return [sigma_1, sigma_2, sigma_3];
                                fi;
                            fi;
                        od;
                    fi; 
                od; 
            fi; 
        od; 
    od;
    return true;
end;

for group in AllSmallGroups(100) do
    Print(group, ":", testConjecture(group, 100, 1000000), "\n");
od; 

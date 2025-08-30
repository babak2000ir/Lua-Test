function findqueens()
    for i1 = 1, 8 do
        for i2 = 1, 8 do
            for i3 = 1, 8 do
                for i4 = 1, 8 do
                    for i5 = 1, 8 do
                        for i6 = 1, 8 do
                            for i7 = 1, 8 do
                                for i8 = 1, 8 do
                                    checkvalidsolution({i1, i2, i3, i4, i5, i6, i7, i8})
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function checkvalidsolution(a)
    for r = 1, 8 do
        if not isplaceok(a, r, a[r]) then
            return
        end
    end
    printsolution(a) 
end

function printsolution(a)
    for i = 1, 8 do -- for each row
        for j = 1, 8 do -- and for each column
            -- write "X" or "-" plus a space
            io.write(a[i] == j and "X" or "-", " ")
        end
        io.write("\n")
    end
    io.write("\n")
end

function isplaceok(a, r, c)
    for i = 1, r - 1 do -- for each queen already placed
        if (a[i] == c) or -- same column?
        (a[i] - i == c - r) or -- same diagonal?
        (a[i] + i == c + r) then -- same diagonal?
            return false -- place can be attacked
        end
    end
    return true -- no attacks; place is OK
end

-- run the program
start = os.time()
findqueens()
findqueens()
findqueens()
findqueens()
findqueens()
print("Elapsed time: " .. os.time() - start)
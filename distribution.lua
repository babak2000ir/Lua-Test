N = 10000
-- Box-Muller transform to generate standard normal random numbers
-- Truncated Gaussian random between 0 and n using Box-Muller
function gaussianRandom(n, mean, stddev)
    mean = mean or n / 2
    stddev = stddev or n / 6   -- ~99.7% values fall within [0,n]

    while true do
        local u1, u2
        repeat
            u1 = math.random()
        until u1 > 0   -- avoid log(0)
        u2 = math.random()

        -- Box-Muller transform
        local z0 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)

        -- Scale to mean/stddev
        local value = z0 * stddev + mean

        -- Accept only if inside [0, n]
        if value >= 0 and value <= n then
            return value
        end
    end
end


-- Normal random generator (uniform distribution between 0 and 1)
function normal_random()
    return math.random() * 100
end

function count_ranges(list)
    local range_counts = {}

    -- Define the ranges, for example: 0-10, 10-20, 20-30, ..., 90-100
    for i = 0, 90, 10 do
        range_counts[i] = 0
    end

    -- Loop through the list and count values in each range
    for _, value in ipairs(list) do
        -- Check which range the value falls into
        for i = 0, 90, 10 do
            if value >= i and value < i + 10 then
                range_counts[i] = range_counts[i] + 1
                break
            end
        end
    end

    -- Return the range counts
    return range_counts
end

-- Helper function to print range counts in order
function print_counts(title, counts)
    print(title)
    local keys = {}
    for k in pairs(counts) do
        table.insert(keys, k)
    end
    table.sort(keys)
    for _, range_start in ipairs(keys) do
        print(string.format("%d-%d: %.0f", range_start, range_start + 10, counts[range_start]/1000 * 100) .. '%')
    end
end

function print_graph(title, counts)
    print(title)
    local keys = {}
    for k in pairs(counts) do
        table.insert(keys, k)
    end
    table.sort(keys)

    -- find max count for scaling
    local max_count = 0
    for _, k in ipairs(keys) do
        if counts[k] > max_count then
            max_count = counts[k]
        end
    end

    -- print simple bar graph
    for _, range_start in ipairs(keys) do
        local bar_len = math.floor((counts[range_start] / max_count) * 50) -- max 50 chars
        local bar = string.rep("*", bar_len)
        print(string.format("%2d-%2d | %s (%.0f", range_start, range_start + 10, bar, counts[range_start]/N * 100) .. '%)')
    end
end


glist = {}
nlist = {}
glistt = {}
nlistt = {}

-- Example usage to print and compare random numbers
print("Comparing different random numbers:")

-- Gaussian (Normal distribution)
for i = 1, N do
    glist[i] = math.abs(gaussianRandom(100))
end

-- Normal random (Uniform distribution)
for i = 1, N do
    nlist[i] = math.abs(normal_random())
end

--randomized seed for better randomness
math.randomseed(os.time())

-- Gaussian (Normal distribution)
for i = 1, N do
    glistt[i] = math.abs(gaussianRandom(100))
end

-- Normal random (Uniform distribution)
for i = 1, N do
    nlistt[i] = math.abs(normal_random())
end

gcounts = count_ranges(glist)
ncounts = count_ranges(nlist)
gcountst = count_ranges(glistt)
ncountst = count_ranges(nlistt)

--print_counts("Gaussian Random Counts:", gcounts)
print_graph("Gaussian Random Distribution Graph:", gcounts)

--print_counts("Normal Random Counts:", ncounts)
print_graph("Normal Random Distribution Graph:", ncounts)

--print_counts("Gaussian Random Counts (after reseeding):", gcountst)
print_graph("Gaussian Random Distribution Graph (after reseeding):", gcountst)

--print_counts("Normal Random Counts (after reseeding):", ncountst)
print_graph("Normal Random Distribution Graph (after reseeding):", ncountst)


-- Box-Muller transform to generate standard normal random numbers
function gaussian_random()
    -- Generate two independent random numbers from a uniform distribution
    local u1 = math.random()
    local u2 = math.random()

    -- Box-Muller transform to get a standard normal random variable
    local z0 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)

    return z0 * 16.67 + 50
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

glist = {}
nlist = {}
glistt = {}
nlistt = {}

-- Example usage to print and compare random numbers
print("Comparing different random numbers:")

-- Gaussian (Normal distribution)
for i = 1, 1000 do
    glist[i] = math.abs(gaussian_random())
end

-- Normal random (Uniform distribution)
for i = 1, 1000 do
    nlist[i] = math.abs(normal_random())
end

--randomized seed for better randomness
math.randomseed(os.time())

-- Gaussian (Normal distribution)
for i = 1, 1000 do
    glistt[i] = math.abs(gaussian_random())
end

-- Normal random (Uniform distribution)
for i = 1, 1000 do
    nlistt[i] = math.abs(normal_random())
end

gcounts = count_ranges(glist)
ncounts = count_ranges(nlist)
gcountst = count_ranges(glistt)
ncountst = count_ranges(nlistt)

print("Gaussian Random Counts:")
for range_start, count in pairs(gcounts) do
    print(string.format("%d-%d: %d", range_start, range_start + 10, count))
end

print("Normal Random Counts:")
for range_start, count in pairs(ncounts) do
    print(string.format("%d-%d: %d", range_start, range_start + 10, count))
end

print("Gaussian Random Counts (after reseeding):")
for range_start, count in pairs(gcountst) do
    print(string.format("%d-%d: %d", range_start, range_start + 10, count))
end

print("Normal Random Counts (after reseeding):")
for range_start, count in pairs(ncountst) do
    print(string.format("%d-%d: %d", range_start, range_start + 10, count))
end



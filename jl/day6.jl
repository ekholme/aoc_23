f = open("./data/day6.txt", "r")

data = readlines(f)

rx = r"\d+"

t = [parse(Int, m.match) for m in eachmatch(rx, data[1])]
d = [parse(Int, m.match) for m in eachmatch(rx, data[2])]

mutable struct Race
    time::Int
    distance::Int
    ways::Int
end

function Race(; time::Int, distance::Int)
    w = 0
    return Race(time, distance, w)
end

# function to solve a given race
function solve!(r::Race)
    w = 0
    for i in 1:r.time
        t = r.time - i
        d = t * i
        if d > r.distance
            w += 1
        end
    end
    r.ways = w
end

#race vector
rv = Vector{Race}(undef, length(t))

for i in eachindex(t)
    rv[i] = Race(time=t[i], distance=d[i])
end

solve!(rv[1])

[solve!(rv[i]) for i in eachindex(rv)]

p1 = prod([rv[i].ways for i in eachindex(rv)])

# p2 -------------------
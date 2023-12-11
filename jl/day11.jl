using DataFrames
using LinearAlgebra
using Distances

f = open("./data/day11.txt", "r")

data = readlines(f)

d = replace.(data, "." => "0", "#" => "1")

ds = split.(d, "")

d2 = DataFrame(ds, :auto)

m = Matrix(convert.(String, d2) .== "1")

m2 = m'

#getting row and column sums
cs = sum(m2, dims=1)
rs = sum(m2, dims=2)

rs_ind = [Tuple(i)[1] for i in findall(==(0), rs)]
cs_ind = [Tuple(i)[2] for i in findall(==(0), cs)]

#build new matrix
function add_m_rows(x, inds)
    i = 0
    tmp = x
    for j in inds
        k = j + i
        z = vcat(tmp[1:k, :], zeros(Int, 140)')
        y = tmp[k+1:end, :]
        tmp = vcat(z, y)
        i += 1
    end
    return tmp
end

m3 = add_m_rows(m2, rs_ind)

function add_m_cols(x, inds)
    i = 0
    tmp = x
    r = size(x)[1]
    for j in inds
        k = j + i
        z = hcat(tmp[:, 1:k], zeros(Int, r))
        y = tmp[:, k+1:end]
        tmp = hcat(z, y)
        i += 1
    end
    return tmp
end

m4 = add_m_cols(m3, cs_ind)

# find 1's
coords = [Tuple(i) for i in findall(==(1), m4)]

# calculate distances
xs = [i[1] for i in coords]
ys = [i[2] for i in coords]
cm = hcat(xs, ys)

dists = pairwise(Cityblock(), cm, dims=1)
l = LowerTriangular(dists)
p1 = sum(l)

# p2 ------------------
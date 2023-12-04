using DataFrames

f = open("./data/day3.txt", "r")

data = readlines(f)

mutable struct NumberPos
    n::Int
    m_start::Int
    m_end::Int
    value::Int
end

m = split(data[1], "")

d = data[1]

r = [isdigit(i) for i in d]

function get_spans(x)
    spans = []
    tmp = findall(x)
    s = [tmp[1]]
    for i in 2:length(tmp)
        if (tmp[i-1] + 1) == tmp[i]
            push!(s, tmp[i])
            if i == length(tmp)
                push!(spans, s)
            end
        else
            push!(spans, s)
            s = [tmp[i]]
        end
    end
    return spans
end

zz = get_spans(r)

function get_all_spans(x)
    r = [isdigit(i) for i in x]
    ret = get_spans(r)
    return ret
end

ss = get_all_spans.(data)

function find_symbols(x)
    rxd = r"[^0-9.]"
    tmp = [m.offset for m in eachmatch(rxd, x)]
    return tmp
end

aaa = find_symbols(data[2])

#bah -- on the right track but don't have time to finish this




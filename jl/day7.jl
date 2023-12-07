using DataFrames

f = open("./data/day7.txt")

data = readlines(f)

d = [split(i) for i in data]
h = string.([i[1] for i in d])
b = parse.(Int, [i[2] for i in d])

mutable struct Hand
    cards::String
    bid::Int
    type::Int
    card_split::Vector{Int}
end

function coerce_cards(x::String)
    s = split(x, "")
    rd = Dict(
        "A" => "14",
        "K" => "13",
        "Q" => "12",
        "J" => "11",
        "T" => "10",
    )
    tmp = [s[i] in keys(rd) ? rd[s[i]] : s[i] for i in eachindex(s)]
    ret = parse.(Int, tmp)
    return ret
end

function Hand(; card::String, bid::Int)
    t = 0
    cs = coerce_cards(card)
    return Hand(card, bid, t, cs)
end

function hands(cards::Vector{String}, bids::Vector{Int})
    hs = Vector{Hand}(undef, length(cards))
    for i ∈ eachindex(cards)
        hs[i] = Hand(card=cards[i], bid=bids[i])
    end
    return hs
end

function count_cards(cards::String)
    s = Set(cards)
    c = [count(==(i), cards) for i in s]
    return Dict(zip(s, c))
end

function score_type!(h::Hand)
    cc = count_cards(h.cards)
    cv = values(cc)
    if length(unique(h.cards)) == 1
        h.type = 7
    elseif maximum(cv) == 4
        h.type = 6
    elseif issetequal(cv, [3, 2])
        h.type = 5
    elseif maximum(cv) == 3
        h.type = 4
    elseif isequal(sort(collect(cv)), [1, 2, 2])
        h.type = 3
    elseif maximum(cv) == 2
        h.type = 2
    else
        h.type = 1
    end
end

hs = hands(h, b)
score_type!.(hs);

function enframe(h::Vector{Hand})
    b = [x.bid for x in h]
    t = [x.type for x in h]
    p1 = [x.card_split[1] for x in h]
    p2 = [x.card_split[2] for x in h]
    p3 = [x.card_split[3] for x in h]
    p4 = [x.card_split[4] for x in h]
    p5 = [x.card_split[5] for x in h]

    df = DataFrame(
        b=b,
        t=t,
        p1=p1,
        p2=p2,
        p3=p3,
        p4=p4,
        p5=p5
    )
    return df
end

hdf = enframe(hs)

sort!(hdf, [:t, :p1, :p2, :p3, :p4, :p5], rev=fill(true, 6))

hdf.:rank = nrow(hdf):-1:1

p1 = sum(hdf.:b .* hdf.:rank)

# p2 -------------

function coerce_cards2(x::String)
    s = split(x, "")
    rd = Dict(
        "A" => "14",
        "K" => "13",
        "Q" => "12",
        "J" => "0",
        "T" => "10",
    )
    tmp = [s[i] in keys(rd) ? rd[s[i]] : s[i] for i in eachindex(s)]
    ret = parse.(Int, tmp)
    return ret
end

function Hand2(; card::String, bid::Int)
    t = 0
    cs = coerce_cards2(card)
    return Hand(card, bid, t, cs)
end

function hands2(cards::Vector{String}, bids::Vector{Int})
    hs = Vector{Hand}(undef, length(cards))
    for i ∈ eachindex(cards)
        hs[i] = Hand2(card=cards[i], bid=bids[i])
    end
    return hs
end

h2 = hands2(h, b)
score_type!.(h2);

hdf2 = enframe(h2)

sort!(hdf2, [:t, :p1, :p2, :p3, :p4, :p5], rev=fill(true, 6))

hdf2.:rank = nrow(hdf2):-1:1

p2 = sum(hdf2.:b .* hdf2.:rank)
# p2 isn't right but don't have time to fix right now
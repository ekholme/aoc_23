f = open("./data/day1.txt", "r")

data = readlines(f)

function get_digits(x::String, rx::Regex, o::Bool)
    tmp = [m.match for m in eachmatch(rx, x, overlap=o)]
    d = tmp[begin] * tmp[end]
    ret = parse(Int, d)
    return ret
end

rx1 = r"[0-9]"

p1 = get_digits.(data, rx1, false)

sum(p1)

# p2 ---------

repl_dict = Dict(
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
)

tst = "eightwo"

rx2 = r"one|two|three|four|five|six|seven|eight|nine|[0-9]"

function get_digits2(x::String, rx::Regex, o::Bool)
    tmp = [m.match for m in eachmatch(rx, x, overlap=o)]
    tmp2 = [tmp[i] in keys(repl_dict) ? repl_dict[tmp[i]] : tmp[i] for i in eachindex(tmp)]
    d = tmp2[begin] * tmp2[end]
    ret = parse(Int, d)
    return ret
end

p2 = get_digits2.(data, rx2, true)

sum(p2)
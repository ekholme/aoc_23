import re

f = open("./data/day1.txt", "r")

data = f.readlines()

def get_digits(x):
    x_rev = x[::-1]
    d1 = re.findall(r'\d{1}', x)[0]
    d2 = re.findall(r'\d{1}', x_rev)[0] 

    ret = int(d1 + d2)

    return ret

p1 = sum([get_digits(x) for x in data])

# part 2

repl_dict = {'one': '1', 'two': '2', 'three': '3', 'four': '4', 'five': '5', 'six': '6', 'seven': '7', 'eight': '8', 'nine': '9'}

p = 'one|two|three|four|five|six|seven|eight|nine|1|2|3|4|5|6|7|8|9'

def replace_digits(x):
    for k, v in repl_dict.items():
        x = x.replace(k, v)
    return x

def extract_digits(x, pattern):
    p1 = re.findall(pattern, x)[0]
    p2 = re.findall(pattern[::-1], x[::-1])[0][::-1]
    tmp = [p1, p2]
    ds = [replace_digits(j) for j in tmp]
    ret = int(ds[0] + ds[1])
    return ret

p2 = sum([extract_digits(i, p) for i in data])
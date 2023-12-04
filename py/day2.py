import re
import numpy as np

f = open("./data/day2.txt", "r")

data = f.readlines()

def max_color(x, color):
    rx = r"(\d+)\s+" + color
    tmp = re.findall(rx, x)
    return max(int(i) for i in tmp)

def round_colors(x):
    cs = ["green", "blue", "red"]
    m = [max_color(x, c) for c in cs]
    return m

# ground truth to test against as [green, blue, red]
gt = [13, 14, 12]

def round_possible(x, truth):
    tmp = round_colors(x)
    res = [tmp[i] <= truth[i] for i, j in enumerate(truth)]
    return all(res)

res1 = [round_possible(i, gt) for i in data]

games = [i+1 for i, j in enumerate(res1) if j]

p1 = sum(games)

# p2 --------------------

res2 = [np.prod(round_colors(i)) for i in data]

p2 = sum(res2)
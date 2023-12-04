import re
import numpy as np

f = open("./data/day3.txt", "r")

data = f.readlines()

d2 = [x.strip("\n") for x in data]
d3 = [x.split('.') for x in d2]
d4 = [list(i) for i in d2]

#make a matrix
m = np.array(d4)

rx = r"[^0-9.]"

#boolean matrix where symbols are located
m_symbol = np.array([[bool(re.search(rx, x)) for x in y] for y in m])

zz = np.where(m_symbol == True)

sym_coords = [(x, y) for x, y in zip(zz[0], zz[1])]


def subset_matrix(m, coords):
    x = coords[0]
    y = coords[1]
    i = 1
    j = 2
    rxd = r"[0-9]"
    while any([bool(re.search(rxd, k)) for k in m[x-1:x+2, y-i]]):
        i = i+1
    while any([bool(re.search(rxd, k)) for k in m[x-1:x+2, y+j]]):
        j = j+1

    tmp = m[x-1:x+2, y-i:y+j]
    # ret = (i, j) 
    return tmp

def subset_matrix_2(m, coords):
    x = coords[0]
    y = coords[1]
    rxd = r"[0-9]"
    nums = []

    for row in m[x-1:x+2]:
        i = 1
        j = 1
        num = []
        while bool(re.search(rxd, row[y-i])):
            i = i+1
        while bool(re.search(rxd, row[y+j])):
            j = j+1

        l_ind = y-i
        r_ind = y+j
        if l_ind < 0:
            l_ind = 0
        if r_ind > m.shape[1]:
            r_ind = m.shape[1]
        num = row[l_ind:r_ind]
        nums.append(num)
    return nums

def extract_int(x):
    d = ''.join(x)
    r = re.sub(r"[^0-9]", "", d)
    if r == '':
        return 0
    return int(r)


ccc = subset_matrix_2(m, sym_coords[2])
zzz = subset_matrix_2(m, sym_coords[1])

aaa = [extract_int(x) for x in ccc]

res = [subset_matrix_2(m, x) for x in sym_coords[0:10]]

def solve_p1(m, coords):
    tmp = [subset_matrix_2(m, x) for x in coords]
    return tmp

mmm = solve_p1(m, sym_coords[0:10])

ret = [[extract_int(x) for x in y] for y in mmm]
#didn't finish this but I'm close -- also indexing in python sucks
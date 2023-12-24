import re
from sympy import Symbol
from sympy import solve_poly_system

stone0, stone1, stone2, *_ = [list(map(int, re.split(",|@", line))) for line in open(0)]
x0, y0, z0, vx0, vy0, vz0 = stone0
x1, y1, z1, vx1, vy1, vz1 = stone1
x2, y2, z2, vx2, vy2, vz2 = stone2

x, y, z, vx, vy, vz, t0, t1, t2 = [Symbol(c) for c in "x,y,z,vx,vy,vz,t0,t1,t2".split(",")]

result = solve_poly_system(
    [
        x + vx * t0 - x0 - vx0 * t0,
        y + vy * t0 - y0 - vy0 * t0,
        z + vz * t0 - z0 - vz0 * t0,
 
        x + vx * t1 - x1 - vx1 * t1,
        y + vy * t1 - y1 - vy1 * t1,
        z + vz * t1 - z1 - vz1 * t1,
 
        x + vx * t2 - x2 - vx2 * t2,
        y + vy * t2 - y2 - vy2 * t2,
        z + vz * t2 - z2 - vz2 * t2,
    ], 
    x, y, z, vx, vy, vz, t0, t1, t2
)
print(sum(result[0][0:3]))

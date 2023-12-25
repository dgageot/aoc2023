import networkx as nx
import re

g = nx.Graph()

for line in open(0):
    node, *children = re.split(": | ", line.strip())
    for child in children:
        g.add_edge(node, child)

cut = nx.minimum_edge_cut(g)
g.remove_edges_from(cut)

components = list(nx.connected_components(g))
print(len(components[0]) * len(components[1]))

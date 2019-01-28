import numpy as np
from niio import write, loaded
import nibabel as nb

from surface_utilities import adjacency as adj

import pandas as pd
from scipy.sparse import csr_matrix

import networkx as nx

import argparse

parser = argparse.ArgumentParser()

parser.add_argument('-s', '--surf', help='Surface file.', required=True,
    type=str)
parser.add_argument('-iv', '--init_vertex', help='Start vertex of path.',
    required=True, type=int)
parser.add_argument('-tv', '--target_vertex', help='Target vertex of path.',
    required=True, type=int)
parser.add_argument('-f', '--features', help='.dot file from Probtrackx.',
    required=True, type=str)
parser.add_argument('-o', '--outbase', help='Output base name.',
    required=True, type=str)

args = parser.parse_args()

surf = nb.load(args.surf)
vertices = surf.darrays[0].data
triangles = surf.darrays[1].data

nv = vertices.shape[0]

print('Generating adjacency matrix and shortest path...')
S = adj.SurfaceAdjacency(vertices = vertices, faces = triangles)
S.generate()

graph = nx.from_dict_of_list(S.adj)
path = nx.shortest_path(G=graph, source=args.init_vertex, target=args.target_vertex)

print('Loading features...')
dot = pd.read_table(args.features, sep='\s+', names=['source', 'target', 'count'])
dot['source'] -= 1
dot['target'] -= 1

sps = csr_matrix((dot['count'], (dot['source'], dot['target'])), shape=(nv, nv))
sps = np.asarray(sps.todense())

print('Generating d-maps...')
z = np.zeros((nv,len(path)))
for j, p in enumerate(path):
    z[:, j] = sps[j, :]
    z[S.adj[p], j] = 1

p = np.zeros((nv,))
p[path] = np.arange(1, len(path)+1)

write.save(p, ''.join([args.outbase, '.path.func.gii']), 'CortexLeft')
write.save(z, ''.join([args.outbase, '.dmaps.func.gii']), 'CortexLeft')
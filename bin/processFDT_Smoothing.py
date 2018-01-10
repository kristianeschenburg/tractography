#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Jan  9 22:11:28 2018

@author: kristianeschenburg
"""

import argparse,os,sys
sys.path.append('..')
sys.path.insert(0,'../../io/')

import json
import networkx as nx
import numpy as np
import scipy

import tractography.smoothing as sm
import loaded as ld

parser = argparse.ArgumentParser()

parser.add_argument('-fdt','--fdtMatrix',help='Path to fdt file.',
                    required=True,type=str)
parser.add_argument('-sj','--surfAdj',help='Surface adjacency file.',
                    required=True,type=str)
parser.add_argument('-dp','--depth',help='Sulcal depth file.',
                    required=True,type=str)
parser.add_argument('-kw','--kernelWeight',help='Scaling factor for Gaussian kernel.',
                    required=True,type=int)
parser.add_argument('-d','--distance',help='Distance to smooth over.',
                    required=True,type=int)
parser.add_argument('-out','--output',help='Output file name for sparse matrix.',
                    required=True,type=str)

args = parser.parse_args()

fdtFile = args.fdtMatrix
surfAdjFile = args.surfAdj
depthFile = args.depth

kw = args.kernelWeight
dist = args.distance
output = args.output

assert os.path.exists(depthFile)
assert os.path.exists(fdtFile)
assert os.path.exists(surfAdjFile)

depth = ld.loadGii(depthFile,darray=np.arange(1))
fdt = sm.loadFDT(fdtFile)

with open(surfAdjFile,'r') as inS:
    J = json.load(inS)
J = {int(k): J[k] for k in J.keys()}

G = nx.from_dict_of_lists(J)
apsp = nx.all_pairs_shortest_path_length(G,cutoff=dist)

sparseMatrix = sm.smoothFeatures(fdt,apsp,depth,kw)
scipy.sparse.save_npz(output,sparseMatrix)

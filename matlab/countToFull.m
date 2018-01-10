function [counts] = convertToFull(dotMatrix)

	temp = load(dotMatrix);
	counts = spconvert(temp);
	counts = squareform(counts);
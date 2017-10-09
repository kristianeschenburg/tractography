function convertToFull(dotMatrix,outMatrix)

	temp = load(dotMatrix)
	counts = spconvert(temp)

	save(outMatrix,'counts','-v7.3')
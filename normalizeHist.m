function normalizedfeatures= normalizeHist(siftVectors)
for i=1:size(siftVectors,1)
    siftVectors(i,4:end)=siftVectors(i,4:end)./sum(siftVectors(i,4:end));
    normalizedfeatures=siftVectors;
end
end
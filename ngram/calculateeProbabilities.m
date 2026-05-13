function probabilities = calculateeProbabilities(counts, alpha)
%CALCULATEEPROBABILITIES Convert bigram counts to probabilities.
%   probabilities = calculateeProbabilities(counts, alpha)

if nargin < 2
    alpha = 1;
end

smoothed = smoothing(counts, alpha);
rowSums = sum(smoothed, 2);
rowSums(rowSums == 0) = 1;
probabilities = smoothed ./ rowSums;
end

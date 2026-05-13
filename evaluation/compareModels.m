function results = compareModels(testTokens, bigramModel, coMat, vocab, alpha)
%COMPAREMODELS Compare bigram and vector model accuracy.
%   results = compareModels(testTokens, bigramModel, coMat, vocab, alpha)

if nargin < 4
    error('compareModels:MissingInput', 'testTokens, bigramModel, coMat, vocab required.');
end

if nargin < 5
    alpha = 1;
end

results.bigramAccuracy = calculateAccuracy(testTokens, bigramModel, "bigram", [], [], alpha);
results.vectorAccuracy = calculateAccuracy(testTokens, [], "vector", coMat, vocab, alpha);
results.perplexity = calculatePerplexity(testTokens, bigramModel, alpha);
end

function perp = calculatePerplexity(testTokens, model, alpha)
%CALCULATEPERPLEXITY Calculate perplexity for bigram model.
%   perp = calculatePerplexity(testTokens, model, alpha)

if nargin < 2
    error('calculatePerplexity:MissingInput', 'testTokens and model required.');
end

if nargin < 3
    alpha = 1;
end

testTokens = string(testTokens);
if numel(testTokens) < 2
    perp = Inf;
    return;
end

probs = calculateeProbabilities(model.counts, alpha);
logProb = 0;
count = 0;

for i = 1:numel(testTokens)-1
    w1 = testTokens(i);
    w2 = testTokens(i+1);
    if isKey(model.wordToIndex, w1) && isKey(model.wordToIndex, w2)
        i1 = model.wordToIndex(w1);
        i2 = model.wordToIndex(w2);
        p = probs(i1, i2);
        logProb = logProb + log(max(p, eps));
        count = count + 1;
    end
end

if count == 0
    perp = Inf;
else
    perp = exp(-logProb / count);
end
end

function [nextWord, score] = predictNextWordVector(prevWord, coMat, vocab)
%PREDICTNEXTWORDVECTOR Predict next word using vector similarity.
%   [nextWord, score] = predictNextWordVector(prevWord, coMat, vocab)

if nargin < 3
    error('predictNextWordVector:MissingInput', 'Prev word, coMat, vocab required.');
end

prevWord = string(prevWord);
vocab = string(vocab);

idx = find(vocab == prevWord, 1);
if isempty(idx)
    nextWord = "";
    score = 0;
    return;
end

targetVec = coMat(idx, :);
bestScore = -inf;
bestIdx = 1;

for j = 1:numel(vocab)
    if j == idx
        continue;
    end
    s = cosineSimilarity(targetVec, coMat(j, :));
    if s > bestScore
        bestScore = s;
        bestIdx = j;
    end
end

nextWord = vocab(bestIdx);
score = bestScore;
end

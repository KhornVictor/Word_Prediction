function [nextWord, score] = predictNextWordBigram(prevWord, model, alpha)
%PREDICTNEXTWORDBIGRAM Predict next word using bigram probabilities.
%   [nextWord, score] = predictNextWordBigram(prevWord, model, alpha)

if nargin < 2
    error('predictNextWordBigram:MissingInput', 'Prev word and model required.');
end

if nargin < 3
    alpha = 1;
end

prevWord = string(prevWord);
vocab = model.vocab;
counts = model.counts;

if ~isKey(model.wordToIndex, prevWord)
    nextWord = "";
    score = 0;
    return;
end

row = model.wordToIndex(prevWord);
probs = calculateeProbabilities(counts, alpha);
rowProbs = probs(row, :);

[score, idx] = max(rowProbs);
nextWord = vocab(idx);
end

function model = buildBigramModel(tokens, vocab)
%BUILDBIGRAMMODEL Build bigram count model.
%   model = buildBigramModel(tokens, vocab)

if nargin < 2
    error('buildBigramModel:MissingInput', 'Tokens and vocab are required.');
end

tokens = string(tokens);
vocab = string(vocab);
vocab = vocab(:);

vocabSize = numel(vocab);
wordToIndex = containers.Map(cellstr(vocab), 1:vocabSize);

counts = zeros(vocabSize, vocabSize);

for i = 1:numel(tokens)-1
    w1 = tokens(i);
    w2 = tokens(i+1);
    if isKey(wordToIndex, w1) && isKey(wordToIndex, w2)
        i1 = wordToIndex(w1);
        i2 = wordToIndex(w2);
        counts(i1, i2) = counts(i1, i2) + 1;
    end
end

model.counts = counts;
model.vocab = vocab;
model.wordToIndex = wordToIndex;
end

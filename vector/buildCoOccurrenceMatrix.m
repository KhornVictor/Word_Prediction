function coMat = buildCoOccurrenceMatrix(tokens, vocab, windowSize)
%BUILDCOOCCURRENCEMATRIX Build co-occurrence matrix for context windows.
%   coMat = buildCoOccurrenceMatrix(tokens, vocab, windowSize)

if nargin < 3
    windowSize = 2;
end

tokens = string(tokens);
vocab = string(vocab);
vocab = vocab(:);
vocabSize = numel(vocab);

wordToIndex = containers.Map(cellstr(vocab), 1:vocabSize);
coMat = zeros(vocabSize, vocabSize);

for i = 1:numel(tokens)
    w = tokens(i);
    if ~isKey(wordToIndex, w)
        continue;
    end
    centerIdx = wordToIndex(w);
    left = max(1, i - windowSize);
    right = min(numel(tokens), i + windowSize);
    for j = left:right
        if j == i
            continue;
        end
        c = tokens(j);
        if isKey(wordToIndex, c)
            contextIdx = wordToIndex(c);
            coMat(centerIdx, contextIdx) = coMat(centerIdx, contextIdx) + 1;
        end
    end
end
end

function accuracy = calculateAccuracy(testTokens, model, mode, coMat, vocab, alpha)
%CALCULATEACCURACY Compute next-word prediction accuracy.
%   accuracy = calculateAccuracy(testTokens, model, mode, coMat, vocab, alpha)
%   mode: "bigram" or "vector"

if nargin < 3
    error('calculateAccuracy:MissingInput', 'testTokens, model, and mode are required.');
end

if nargin < 6
    alpha = 1;
end

testTokens = string(testTokens);
if numel(testTokens) < 2
    accuracy = 0;
    return;
end

correct = 0;
total = 0;

for i = 1:numel(testTokens)-1
    prevWord = testTokens(i);
    trueNext = testTokens(i+1);

    if mode == "bigram"
        [pred, ~] = predictNextWordBigram(prevWord, model, alpha);
    elseif mode == "vector"
        [pred, ~] = predictNextWordVector(prevWord, coMat, vocab);
    else
        error('calculateAccuracy:InvalidMode', 'Mode must be "bigram" or "vector".');
    end

    if pred == trueNext
        correct = correct + 1;
    end
    total = total + 1;
end

accuracy = correct / max(total, 1);
end

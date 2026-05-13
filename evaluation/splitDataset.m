function [trainTokens, testTokens] = splitDataset(tokens, splitRatio)
%SPLITDATASET Split tokens into train and test sets.
%   [trainTokens, testTokens] = splitDataset(tokens, splitRatio)

if nargin < 2
    splitRatio = 0.8;
end

tokens = string(tokens);
n = numel(tokens);
if n == 0
    trainTokens = strings(0, 1);
    testTokens = strings(0, 1);
    return;
end

splitIndex = max(1, floor(n * splitRatio));
trainTokens = tokens(1:splitIndex);
testTokens = tokens(splitIndex+1:end);
end

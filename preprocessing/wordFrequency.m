function [words, counts] = wordFrequency(tokens)
%WORDFREQUENCY Compute word frequency counts.
%   [words, counts] = wordFrequency(tokens)

if nargin < 1
    error('wordFrequency:MissingInput', 'Tokens input is required.');
end

tokens = string(tokens);
tokens = tokens(tokens ~= "");

[words, ~, idx] = unique(tokens, 'stable');
counts = accumarray(idx, 1);

% Sort by frequency descending
[counts, order] = sort(counts, 'descend');
words = words(order);
end

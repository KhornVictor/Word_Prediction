function vocab = buildVocabulary(tokens)
%BUILDVOCABULARY Build unique word list from tokens.
%   vocab = buildVocabulary(tokens)

if nargin < 1
    error('buildVocabulary:MissingInput', 'Tokens input is required.');
end

tokens = string(tokens);
tokens = tokens(tokens ~= "");

vocab = unique(tokens, 'stable');
vocab = vocab(:);
end

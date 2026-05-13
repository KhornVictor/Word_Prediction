function tokens = tokenizeText(text)
%TOKENIZETEXT Split cleaned text into word tokens.
%   tokens = tokenizeText(text)

if nargin < 1
    error('tokenizeText:MissingInput', 'Text input is required.');
end

text = string(text);
if strlength(text) == 0
    tokens = strings(0, 1);
    return;
end

tokens = split(text);
tokens = tokens(tokens ~= "");
tokens = tokens(:);
end

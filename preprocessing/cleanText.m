function cleaned = cleanText(text)
%CLEANTEXT Lowercase and remove punctuation/special characters.
%   cleaned = cleanText(text)

if nargin < 1
    error('cleanText:MissingInput', 'Text input is required.');
end

text = string(text);
text = lower(text);

% Keep letters, numbers, and whitespace. Replace others with space.
text = regexprep(text, "[^a-z0-9\s]", " ");
text = regexprep(text, "\s+", " ");
text = strtrim(text);

cleaned = char(text);
end

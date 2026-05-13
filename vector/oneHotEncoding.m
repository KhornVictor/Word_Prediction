function vec = oneHotEncoding(word, vocab)
%ONEHOTENCODING Create one-hot vector for a word.
%   vec = oneHotEncoding(word, vocab)

if nargin < 2
    error('oneHotEncoding:MissingInput', 'Word and vocab are required.');
end

vocab = string(vocab);
word = string(word);

vec = zeros(1, numel(vocab));
idx = find(vocab == word, 1);
if ~isempty(idx)
    vec(idx) = 1;
end
end

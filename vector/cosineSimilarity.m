function score = cosineSimilarity(a, b)
%COSINESIMILARITY Compute cosine similarity between vectors.
%   score = cosineSimilarity(a, b)

if nargin < 2
    error('cosineSimilarity:MissingInput', 'Two vectors are required.');
end

a = a(:);
b = b(:);
den = norm(a) * norm(b);
if den == 0
    score = 0;
else
    score = (a' * b) / den;
end
end

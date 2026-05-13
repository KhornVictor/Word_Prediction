function smoothed = smoothing(counts, alpha)
%SMOOTHING Apply Laplace (add-alpha) smoothing.
%   smoothed = smoothing(counts, alpha)

if nargin < 2
    alpha = 1;
end

smoothed = counts + alpha;
end

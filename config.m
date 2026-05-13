function cfg = config()
%CONFIG Central configuration for the project.

cfg.dataPath = fullfile(pwd, 'data', 'corpus.txt');
cfg.processedPath = fullfile(pwd, 'data', 'processed_data.mat');
cfg.splitRatio = 0.8;
cfg.smoothingAlpha = 1;
cfg.coWindowSize = 2;
cfg.topWords = 10;
end

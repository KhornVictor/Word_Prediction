function main(runUI)
%MAIN End-to-end pipeline for next word prediction.

if nargin < 1
    runUI = true;
end

rootDir = fileparts(mfilename('fullpath'));
addpath(rootDir);
addpath(fullfile(rootDir, 'preprocessing'));
addpath(fullfile(rootDir, 'ngram'));
addpath(fullfile(rootDir, 'vector'));
addpath(fullfile(rootDir, 'evaluation'));
addpath(fullfile(rootDir, 'ui'));

cfg = config();

% Load and preprocess text
rawText = loadText(cfg.dataPath);
cleaned = cleanText(rawText);
tokens = tokenizeText(cleaned);

% Vocabulary and frequency analysis
vocab = buildVocabulary(tokens);
[freqWords, freqCounts] = wordFrequency(tokens);

fprintf('Vocabulary size: %d\n', numel(vocab));
fprintf('Total tokens: %d\n', numel(tokens));

% Plot top words
% topN = min(cfg.topWords, numel(freqWords));
% figure('Name', 'Top Words');
% bar(categorical(freqWords(1:topN)), freqCounts(1:topN));
% title('Top Words');
% xlabel('Words');
% ylabel('Frequency');

% Split dataset
[trainTokens, testTokens] = splitDataset(tokens, cfg.splitRatio);

% Bigram model
bigramModel = buildBigramModel(trainTokens, vocab);

% Vector model
coMat = buildCoOccurrenceMatrix(trainTokens, vocab, cfg.coWindowSize);

% Evaluate models
results = compareModels(testTokens, bigramModel, coMat, vocab, cfg.smoothingAlpha);
fprintf('Bigram accuracy: %.4f\n', results.bigramAccuracy);
fprintf('Vector accuracy: %.4f\n', results.vectorAccuracy);
fprintf('Perplexity: %.4f\n', results.perplexity);

% Example prediction
% example = "I";
% exampleTokens = tokenizeText(cleanText(example));
% prevWord = exampleTokens(end);
% [nextBigram, scoreB] = predictNextWordBigram(prevWord, bigramModel, cfg.smoothingAlpha);
% [nextVector, scoreV] = predictNextWordVector(prevWord, coMat, vocab);
% fprintf('Input: "%s"\n', example);
% fprintf('Bigram prediction: %s (%.4f)\n', nextBigram, scoreB);
% fprintf('Vector prediction: %s (%.4f)\n', nextVector, scoreV);

% Save processed data
save(cfg.processedPath, 'tokens', 'vocab', 'bigramModel', 'coMat', 'results');

if runUI
    uiPath = fullfile(rootDir, 'ui');
    uiFile = fullfile(uiPath, 'predictionApp.m');
    if isfile(uiFile)
        addpath(uiPath);
        predictionApp;
    else
        error('main:UIFileMissing', 'UI file not found: %s', uiFile);
    end
end
end

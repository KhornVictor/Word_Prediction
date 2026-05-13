classdef predictionApp < matlab.ui.componentcontainer.ComponentContainer

    % Properties that correspond to underlying components
    properties (Access = private, Transient, NonCopyable)
        Button5_4                    matlab.ui.control.Button
        Button5_3                    matlab.ui.control.Button
        Button5_2                    matlab.ui.control.Button
        Button5                      matlab.ui.control.Button
        AccuracyVisualizationLabel   matlab.ui.control.Label
        AlternativePredictionsLabel  matlab.ui.control.Label
        Probability87Label           matlab.ui.control.Label
        PredictedWordLabel           matlab.ui.control.Label
        ModelButtonGroup             matlab.ui.container.ButtonGroup
        vectorwordButton             matlab.ui.control.RadioButton
        trigramButton                matlab.ui.control.RadioButton
        BigramButton                 matlab.ui.control.RadioButton
        WordPredictionLabel          matlab.ui.control.Label
        EnterthetextLabel            matlab.ui.control.Label
        EditField                    matlab.ui.control.EditField
        UIAxes                       matlab.ui.control.UIAxes
    end

    properties (Access = private)
        Config
        Model
        LastSuggestions string = strings(0, 1)
    end

    methods (Access = protected)
        
        % Code that executes when the value of a public property is changed
        function update(comp)
            % Use this function to update the underlying components
            
        end

        % Create the underlying components
        function setup(comp)

            comp.Position = [1 1 703 525];
            comp.BackgroundColor = [0.302 0.7451 0.9333];

            % Create UIAxes
            comp.UIAxes = uiaxes(comp);
            title(comp.UIAxes, 'Model Accuracy')
            xlabel(comp.UIAxes, 'Model')
            ylabel(comp.UIAxes, 'Accuracy')
            comp.UIAxes.Position = [399 21 266 415];

            % Create EditField
            comp.EditField = uieditfield(comp, 'text');
            comp.EditField.FontColor = [0.502 0.502 0.502];
            comp.EditField.Placeholder = 'Text';
            comp.EditField.Position = [24 392 336 38];
            comp.EditField.ValueChangedFcn = @(src, event) comp.predictAndRender();
            comp.EditField.ValueChangingFcn = @(src, event) comp.predictAndRender(event.Value);

            % Create EnterthetextLabel
            comp.EnterthetextLabel = uilabel(comp);
            comp.EnterthetextLabel.FontSize = 18;
            comp.EnterthetextLabel.FontWeight = 'bold';
            comp.EnterthetextLabel.FontColor = [1 1 1];
            comp.EnterthetextLabel.Position = [24 438 120 23];
            comp.EnterthetextLabel.Text = 'Enter the text';

            % Create WordPredictionLabel
            comp.WordPredictionLabel = uilabel(comp);
            comp.WordPredictionLabel.FontSize = 24;
            comp.WordPredictionLabel.FontWeight = 'bold';
            comp.WordPredictionLabel.FontColor = [1 1 1];
            comp.WordPredictionLabel.Position = [257 476 191 31];
            comp.WordPredictionLabel.Text = 'Word Prediction';

            % Create ModelButtonGroup
            comp.ModelButtonGroup = uibuttongroup(comp);
            comp.ModelButtonGroup.BorderColor = [0.302 0.7451 0.9333];
            comp.ModelButtonGroup.ForegroundColor = [1 1 1];
            comp.ModelButtonGroup.HighlightColor = [0.302 0.7451 0.9333];
            comp.ModelButtonGroup.Title = 'Model';
            comp.ModelButtonGroup.BackgroundColor = [0.302 0.7451 0.9333];
            comp.ModelButtonGroup.Position = [24 271 336 106];

            % Create BigramButton
            comp.BigramButton = uiradiobutton(comp.ModelButtonGroup);
            comp.BigramButton.Text = 'Bigram';
            comp.BigramButton.FontColor = [1 1 1];
            comp.BigramButton.Position = [11 60 60 22];
            comp.BigramButton.Value = true;

            % Create trigramButton
            comp.trigramButton = uiradiobutton(comp.ModelButtonGroup);
            comp.trigramButton.Text = 'trigram';
            comp.trigramButton.FontColor = [1 1 1];
            comp.trigramButton.Position = [11 38 65 22];

            % Create vectorwordButton
            comp.vectorwordButton = uiradiobutton(comp.ModelButtonGroup);
            comp.vectorwordButton.Text = 'vector word';
            comp.vectorwordButton.FontColor = [1 1 1];
            comp.vectorwordButton.Position = [11 16 84 22];

            % Create PredictedWordLabel
            comp.PredictedWordLabel = uilabel(comp);
            comp.PredictedWordLabel.FontSize = 18;
            comp.PredictedWordLabel.FontWeight = 'bold';
            comp.PredictedWordLabel.FontColor = [1 1 1];
            comp.PredictedWordLabel.Position = [23 248 139 23];
            comp.PredictedWordLabel.Text = 'Predicted Word';

            % Create Probability87Label
            comp.Probability87Label = uilabel(comp);
            comp.Probability87Label.FontSize = 14;
            comp.Probability87Label.FontWeight = 'bold';
            comp.Probability87Label.FontColor = [0.902 0.902 0.902];
            comp.Probability87Label.Position = [23 188 118 22];
            comp.Probability87Label.Text = 'Probability: 87% ';

            % Create AlternativePredictionsLabel
            comp.AlternativePredictionsLabel = uilabel(comp);
            comp.AlternativePredictionsLabel.FontSize = 18;
            comp.AlternativePredictionsLabel.FontWeight = 'bold';
            comp.AlternativePredictionsLabel.FontColor = [1 1 1];
            comp.AlternativePredictionsLabel.Position = [24 153 217 23];
            comp.AlternativePredictionsLabel.Text = 'Alternative Predictions   ';

            % Create AccuracyVisualizationLabel
            comp.AccuracyVisualizationLabel = uilabel(comp);
            comp.AccuracyVisualizationLabel.FontSize = 18;
            comp.AccuracyVisualizationLabel.FontWeight = 'bold';
            comp.AccuracyVisualizationLabel.FontColor = [1 1 1];
            comp.AccuracyVisualizationLabel.Position = [399 438 202 23];
            comp.AccuracyVisualizationLabel.Text = 'Accuracy Visualization';

            % Create Button5
            comp.Button5 = uibutton(comp, 'push');
            comp.Button5.HorizontalAlignment = 'left';
            comp.Button5.Position = [24 216 336 23];
            comp.Button5.Text = 'Button5';
            comp.Button5.ButtonPushedFcn = @(src, event) comp.appendChoice(1);

            % Create Button5_2
            comp.Button5_2 = uibutton(comp, 'push');
            comp.Button5_2.HorizontalAlignment = 'left';
            comp.Button5_2.Position = [23 120 336 23];
            comp.Button5_2.Text = 'Button5';
            comp.Button5_2.ButtonPushedFcn = @(src, event) comp.appendChoice(2);

            % Create Button5_3
            comp.Button5_3 = uibutton(comp, 'push');
            comp.Button5_3.HorizontalAlignment = 'left';
            comp.Button5_3.Position = [24 86 336 23];
            comp.Button5_3.Text = 'Button5';
            comp.Button5_3.ButtonPushedFcn = @(src, event) comp.appendChoice(3);

            % Create Button5_4
            comp.Button5_4 = uibutton(comp, 'push');
            comp.Button5_4.HorizontalAlignment = 'left';
            comp.Button5_4.Position = [24 50 336 23];
            comp.Button5_4.Text = 'Button5';
            comp.Button5_4.ButtonPushedFcn = @(src, event) comp.appendChoice(4);

            comp.loadModel();
            comp.setSuggestionButtons(strings(0, 1));
        end
    end

    methods (Access = private)
        function loadModel(comp)
            rootDir = fileparts(fileparts(mfilename('fullpath')));
            addpath(rootDir);
            addpath(fullfile(rootDir, 'preprocessing'));
            addpath(fullfile(rootDir, 'ngram'));
            addpath(fullfile(rootDir, 'vector'));
            addpath(fullfile(rootDir, 'evaluation'));

            comp.Config = config();
            if isfile(comp.Config.processedPath)
                data = load(comp.Config.processedPath);
            else
                main(false);
                data = load(comp.Config.processedPath);
            end

            comp.Model.vocab = data.vocab;
            comp.Model.bigramModel = data.bigramModel;
            comp.Model.coMat = data.coMat;

            if isfield(data, 'results')
                comp.renderAccuracy(data.results);
            end
        end

        function renderAccuracy(comp, results)
            cla(comp.UIAxes);
            models = {'Bigram', 'Vector'};
            values = [results.bigramAccuracy, results.vectorAccuracy];
            bar(comp.UIAxes, categorical(models), values);
            ylim(comp.UIAxes, [0 1]);
        end

        function predictAndRender(comp, inputOverride)
            if nargin > 1
                inputText = string(inputOverride);
            else
                inputText = string(comp.EditField.Value);
            end
            cleaned = cleanText(inputText);
            tokens = tokenizeText(cleaned);

            if isempty(tokens)
                comp.Probability87Label.Text = 'Probability: 0%';
                comp.Button5.Text = 'No prediction';
                comp.setSuggestionButtons(strings(0, 1));
                return;
            end

            prevWord = tokens(end);
            if comp.vectorwordButton.Value
                [choices, scores] = comp.topNVector(prevWord, 4);
            else
                [choices, scores] = comp.topNBigram(prevWord, 4);
            end

            comp.setSuggestionButtons(choices);
            if ~isempty(scores)
                comp.Probability87Label.Text = sprintf('Probability: %d%%', round(100 * scores(1)));
            else
                comp.Probability87Label.Text = 'Probability: 0%';
            end
        end

        function [choices, scores] = topNBigram(comp, prevWord, n)
            model = comp.Model.bigramModel;
            vocab = comp.Model.vocab;
            if ~isKey(model.wordToIndex, prevWord)
                choices = strings(0, 1);
                scores = [];
                return;
            end
            probs = calculateeProbabilities(model.counts, comp.Config.smoothingAlpha);
            row = model.wordToIndex(prevWord);
            rowProbs = probs(row, :);
            [scores, idx] = sort(rowProbs, 'descend');
            topN = min(n, numel(idx));
            choices = vocab(idx(1:topN));
            scores = scores(1:topN);
        end

        function [choices, scores] = topNVector(comp, prevWord, n)
            vocab = comp.Model.vocab;
            coMat = comp.Model.coMat;
            idx = find(vocab == string(prevWord), 1);
            if isempty(idx)
                choices = strings(0, 1);
                scores = [];
                return;
            end
            targetVec = coMat(idx, :);
            scores = zeros(1, numel(vocab));
            for j = 1:numel(vocab)
                if j == idx
                    scores(j) = -inf;
                else
                    scores(j) = cosineSimilarity(targetVec, coMat(j, :));
                end
            end
            [scores, order] = sort(scores, 'descend');
            topN = min(n, numel(order));
            choices = vocab(order(1:topN));
            scores = scores(1:topN);
        end

        function setSuggestionButtons(comp, choices)
            comp.LastSuggestions = choices;

            if numel(choices) >= 1
                comp.Button5.Text = choices(1);
                comp.Button5.Enable = 'on';
            else
                comp.Button5.Text = 'No prediction';
                comp.Button5.Enable = 'off';
            end

            if numel(choices) >= 2
                comp.Button5_2.Text = choices(2);
                comp.Button5_2.Enable = 'on';
            else
                comp.Button5_2.Text = 'Choice 2';
                comp.Button5_2.Enable = 'off';
            end

            if numel(choices) >= 3
                comp.Button5_3.Text = choices(3);
                comp.Button5_3.Enable = 'on';
            else
                comp.Button5_3.Text = 'Choice 3';
                comp.Button5_3.Enable = 'off';
            end

            if numel(choices) >= 4
                comp.Button5_4.Text = choices(4);
                comp.Button5_4.Enable = 'on';
            else
                comp.Button5_4.Text = 'Choice 4';
                comp.Button5_4.Enable = 'off';
            end
        end

        function appendChoice(comp, idx)
            if numel(comp.LastSuggestions) < idx
                return;
            end
            word = comp.LastSuggestions(idx);
            current = string(comp.EditField.Value);
            comp.EditField.Value = strtrim(current + " " + word);
            comp.predictAndRender();
        end
    end
end

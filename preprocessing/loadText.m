function text = loadText(filePath)
%LOADTEXT Load raw text from a file.
%   text = loadText(filePath) reads a text file and returns it as a char.

if nargin < 1 || strlength(string(filePath)) == 0
    error('loadText:MissingPath', 'File path is required.');
end

if ~isfile(filePath)
    error('loadText:FileNotFound', 'File not found: %s', filePath);
end

text = fileread(filePath);
end

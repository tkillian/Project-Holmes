% cracker.m

% This program brute-force cracks a password.  What I'm thinking we can do
% initially is start small, so have like a 2 character password, and see
% what we can do to break that.  Once we have our cracking code on the
% page, then we can play around with the password, perhaps by increasing
% length or complexity, or having the program generate a password.

% Authors: Happy Hale
%          Tucker Killian
%          Grace Bushong
%          Rachael Mullin
%          Will Badart

% See git for version control.

clear;
clc;

%GUI_OpeningFcn;
realpass = input('What is the password: ', 's');

%% Import Password Library

filename = 'commonPass.txt';
delimiter = '';
formatSpec = '%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
password = dataArray{:, 1};
clearvars filename delimiter formatSpec fileID dataArray ans;

%% Set Parameters

alphabet = 'abc';
%defghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[{]}\|";:/?.>'',<��������������������������ܢ��?������Ѫ��������ߵ���
alphasizeA = size(alphabet);
alphasize = alphasizeA(2);

guess = ' ';
counter = 0;
%i = 0;
%j = 0;

%% Crack Password

% checks password against the library
if counter < 0
for i = 1:size(password)
    counter = counter + 1;
    guess = password(i);
    if strcmp(guess, realpass) == 1
        guess = guess{:};
        break
    end
end
end
counter = counter + 1;
% if password isn't found in library:
if strcmp(guess, realpass) == 0
    passLength = 1;
    guess = ' '; % reset 'guess.'  It wasn't a common password
    
    while strcmp(guess, realpass) == 0
        if guess(1:end) == alphabet(end)
            passLength = passLength + 1;
        end
        
        x = 2;
        n = ones(1, passLength);
        n(1) = passLength;
        while n > 0
            n(x) = n(x - 1) - 1;
            x = x + 1;
        end
        n = n(1:end-1);
        %now you have [n] i.e. [4, 3, 2, 1]
        
        
        guess(n) = guessfunc(alphabet, passLength, guess, n, i);
        counter = counter + 1;
        i = i + 1;
        
    end %ends while, checks guess
    
end %ends if strcmp(... if match

%% Display Results

disp(['Got it.  The password is "', guess, '".']);
if counter == 1
    disp(['It took ', num2str(counter), ' guess.']);
else
    disp(['It took ', num2str(counter), ' guesses.']);
end

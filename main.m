%% Machine Learning Online Class - Exercise 4 Neural Network Learning
% altered for Ian Moore science project

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions 
%  in this exericse:
%
%     sigmoidGradient.m
%     randInitializeWeights.m
%     nnCostFunction.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this exercise
%input_layer_size  = 400;  % 20x20 Input Images of Digits
%hidden_layer_size = 25;   % 25 hidden units
%num_labels = 10;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

input_layer_size = 500000; %the size of the discrete cosine transform sample
hidden_layer_size = 50;    %the size of the hidden layer (we can play w/this)
num_labels = 10;           %the number of genres
iterations = 25;           %the number of training iterations

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading Data ...\n')

%X is a matrix of n training examples, each with input_layer_size columns
%load('ex4data1.mat');
%y is a vector of n labels, each being an integer representing the genre
% for the corresponding row in X
%fid = fopen("example.txt");
%X = [];
%row_count = 0

%while (! feof (fid))
%  line = fgets(fid);
%  printf('read %d characters\n', length(line));
%  printf(line(1:10));
%  row_count += 1;
%  printf('%d rows read\n', row_count);
%  x = strread(line);
%  X = vertcat(X, transpose(x));
%  puts "added row to X\n"
%end
%fclose(fid);
X = load('X.txt');

printf('X has %d rows and %d columns\n', size(X, 1), size(X, 2))
y = textread('y.txt');
printf('y has %d rows and %d columns\n', size(y, 1), size(y, 2))

m = size(X, 1);




%% ================ Part 6: Initializing Pameters ================
%  In this part of the exercise, you will be starting to implment a two
%  layer neural network that classifies digits. You will start by
%  implementing a function to initialize the weights of the neural network
%  (randInitializeWeights.m)

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


%% =================== Part 8: Training NN ===================
%  You have now implemented all the code necessary to train a neural 
%  network. To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', iterations);

%  You should also try different values of lambda
lambda = 1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

%fprintf('Program paused. Press enter to continue.\n');
%pause;
printf('Training complete.');

save('thetas.txt', 'Theta1', 'Theta2');


%% ================= Part 10: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

pred = predict(Theta1, Theta2, X);

printf('The predictions are... \n');
printf('%d\n', pred);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

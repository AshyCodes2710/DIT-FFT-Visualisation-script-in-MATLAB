clc; clear all;
graphics_toolkit("gnuplot")

% octave uses "qt" for it's GUI handling, but that is interfering with my system's Wayland compositor.
% Such run ins are normal with my system, since I'm running Arch linux with Hyprland. For the sake of this 
% project, I am going to use "gnuplot" instead of forcing qt to work.

%% TAKE INPUT

str = input("Enter your Discrete in Time signal. (separate with spaces.): ", "s");
% going to convert this string into a num-array, i.e. numeric array.
x = str2num(str);

% can't have an empty input.
if isempty(x) % Returns boolean if x is NULL or not.
  error("Invalid input. Please enter numbers like: 1 2 3 4.. etc. Try again.")
end

%save the original for later comparison.
% x_original = x; % the zeropad will be performed UPON x.

%%  ZERO PAD
% We're using Radix 2. This means that the length of our input signal (N) has to be EQUAL to a POWER of 2.
% we're going to compare, then zeropad the remaining size's worth.

next = 2^nextpow2(length(x));
% x_zeroPadded = zeros(1,next);  unneccessary. gets overwritten anyways later.
if next ~= length(x)
  fprintf("Zero padding from %d to %d\n", length(x), next)
  % add the required zeros to the end of input.
  x_zeroPadded = [x zeros(1,next-length(x))];
else
  x_zeroPadded = x;
end

disp("signal after padding");
disp(x_zeroPadded);

%% CALL bitRev()

x_bitReversed = bitRev(x_zeroPadded);

%% CALL ditFFT()

[y, stages] = ditFFT(x_bitReversed);
disp("error: ");
disp(abs(y-fft(x_zeroPadded))); %this is our error checking. MATLAB's built in fft() function does zero padding itself.

%% BIT REVERSAL PLOT.
figure;

subplot(2,1,1);
stem(x_zeroPadded, 'filled');
title("Original Signal");

subplot(2,1,2);
stem(x_bitReversed, 'filled');
title("Bit-Reversed Signal");

saveas(gcf, '../plots/bit_reversal.png');
%% DITFFT PLOT.
figure;

num_stages = size(stages,1);

for s = 1:num_stages
    subplot(num_stages,1,s);
    stem(abs(stages(s,:)), 'filled');
    title(["Stage ", num2str(s)]);
    xlabel("Index");
    ylabel("|X|");
    grid on;
end

saveas(gcf, '../plots/stage_wise_output.png');

% octave closes the figure the instant code is done compiling
% so we will "Hold Plots"

disp("Press any key to close plots...");
waitforbuttonpress; % working on linux, so i need this command.

function [filtered_output] = derivative_filter_algorithm(input_signal)
% Derivative Filter Algorithm for HDL Coder
% Implements the filter: H(z) = G * (1/T) * [1 - z^-1] / [1 - 0.995z^-1]

persistent y_prev x_prev;
if isempty(y_prev)
    y_prev = 0;
    x_prev = 0;
end

% Filter coefficients (pre-calculated)
G = 0.9975;  % Normalization gain
a1 = -0.995;  % denominator coefficient
b0 = 1 * G;   % numerator coefficients
b1 = -1 * G;

% Implement the difference equation:
% y(n) = b0*x(n) + b1*x(n-1) - a1*y(n-1)
current_output = b0 * input_signal + b1 * x_prev - a1 * y_prev;

% Update persistent variables for next iteration
y_prev = current_output;
x_prev = input_signal;

filtered_output = current_output;
end
function x_br = bitRev(x)
  % This function takes our zero-padded input Discrete in time signal "x"" and then returns "x_br"
  % The output of this function is just a reordered and bit-reversed variation of the input signal.

  N = length(x);
  bits = log2(N); % Size of the input signal AFTER zero padding.
  x_br = zeros(1,N); % Made an empty array to hold our Bit-Reversed signal.

  % Run a loop to go step by step and reassign new indices after performing binary inversion of it's current index.

  for i = 0:N-1 % traverse the whole signal.
    % convert index to binary (0 -> 00; 1 -> 01; 2 -> 10; 3 -> 11)
    b = dec2bin(i, bits);
    % reverse that binary index.
    br = b(end:-1:1);
    % turn that inverted binary index, BACK into Decimal.
    new = bin2dec(br);
    % place elements in new positions.
    x_br(new+1) = x(i+1); % take value at x(i+1), and replace x_br(new+1) if existsm, with that value at x(i+1)
  end
end



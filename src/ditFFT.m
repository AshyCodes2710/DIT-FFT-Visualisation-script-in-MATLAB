function [y,stages_out]=ditFFT(X)
  N = length(X)
  stages = log2(N);
  stages_out = zeros(stages, N);
  for s = 1:stages
    % m = size of group at stage "s", doubles every stage.
    m = 2^s;

    % half of group size -> distance between butterfly pairs in a stage s.
    intervalbutterfly = m/2;

    for k = 0:intervalbutterfly-1
      % twiddle factor!!
      w = exp(-2j*pi*k/m);

      for i = k:m:N-1
        % find even and odd elements.
        even = X(i+1); 
        odd = w * X(i+intervalbutterfly+1); % it's the index on the other half of the group as "even".

        % butterfly calculation.
        X(i+1) = even+odd;
        X(i+intervalbutterfly+1) = even-odd;
      end
    end

    %save the stage output
    stages_out(s,:)=X;

  end
  y = X;
end

%% LOGIC?
% make a "stages_out = zeros(stages, N);" for saving every stage.
% function [y, stages_out] = ditFFT(X)
%   for each stage "S"
%     we want to compute m. Size of group at that stage.
%
%     for each iteration "k"
%       we want to calculate W = exp(-2j*pi*k/m) i.e. our Twiddle factor per stage per iteration k.
%       save the stage.
%
%       for each index "i"
%         do butterfly.
%         save stage.
%     save the stage: stages_out(s,:)=x;
%   y = x. make a new array save it as exactly x so that we don't run into the issue of outputting the same logical location as input was.
% end

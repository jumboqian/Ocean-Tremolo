function [res] = myPeak(samplevector)
res=max(abs(samplevector))
end

% I verified it by inputting a simple vector like [1 3 -16] and see if the
% function returns the expected value 16 as expected. 
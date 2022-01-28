function [res] = myRms(samplevector)
res=sqrt(mean(samplevector.^2))
end

%I verified my code by inputting a rather simple vector and see if the
%result is the same as calculated manually.
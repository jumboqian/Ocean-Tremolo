function [res] = dBFS(value)
res=20*log10(abs(value)/myPeak(value));
end

%I learned in class that double the value of the output should gives a 6dB
%. The code displays the same value. Also if the value is less than the
%peak, the value should be negative. When the value is the same as the peak
%, the output should be zero. The results of the code coincide with these
%known qualities. 

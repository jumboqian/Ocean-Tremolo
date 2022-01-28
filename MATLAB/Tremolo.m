function [outsig] = Tremolo(x,fs,D,R)

% x = input signal
% fs = sampling frequency
% R = tremolo rate (cycles per second)
% D = tremolo depth (values 0 to 1)

%equal length for original signal and tremolo signal
x_Length = length(x);

%mod signal TremSig using the D and fs parameters
    for x = 1:x_Length;
        TremSig(x) = (1-D) + D .* ((1 + sin((2.*pi.* R .* x) ./ fs)) ./ 2);
    end

%multiply TremSig to make TremOut
TremOut = x .* TremSig;
outsig(:,1) = TremOut(1,:);

end
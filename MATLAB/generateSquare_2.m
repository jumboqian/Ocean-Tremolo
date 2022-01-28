function [t,x] = generateSquare_2(amplitude, frequencyInHz, lengthInS, phaseInRadians)
t = linspace(0, lengthInS,65536*lengthInS);
x=zeros(size(t));
x=square(2*i*pi*frequencyInHz .*t + phaseInRadians)
x=x/max(abs(x))*amplitude;
plot(t,x);
end


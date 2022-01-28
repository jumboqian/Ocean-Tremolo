function [t,x] = generateSquare_1(amplitude, frequencyInHz, lengthInS, phaseInRadians)
t = linspace(0, lengthInS,65536*lengthInS);
x=zeros(size(t));
for i=1
    sinx = sin(2*i*pi*frequencyInHz .*t + phaseInRadians);
    x = x + sinx/i
end

x=x/max(abs(x))*amplitude;
plot(t,x);
end

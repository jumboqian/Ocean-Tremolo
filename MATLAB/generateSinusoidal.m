function [t,x] = generateSinusoidal(amplitude,frenquencyInHz,lengthIns)

t= linspace(0,lengthIns-1/44100,44100*lengthIns);
x=amplitude*sin(2*pi*frenquencyInHz*t);
plot(t,x);
end


function [t,x] = generateSquare(amplitude, frequencyInHz, lengthInS, phaseInRadians)

t = linspace(0, lengthInS,65536*lengthInS);

%gives 0/1/0.5
x = heaviside(sin(2*pi*frequencyInHz.*t + phaseInRadians));

%deal with values of 0.5->1
x=round(x)

%shift down 0.5 to have positive and negative values
x=x-0.5

%double the value to adjust for right amplitude 
x=x*2

%multiply amplitude
x=x*amplitude


%sound(x,65536);
end


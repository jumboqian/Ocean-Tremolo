function [outputvector] = mySinglePole(inputvector, alpha)
samples= 44100;
y=zeros(1,length(inputvector));
for i=1:length(inputvector)
    y(i+1)=(1-alpha)*inputvector+alpha*y(1)
end


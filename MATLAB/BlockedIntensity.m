function [rms_block,peak_block] = BlockedIntensity(x)
block=2048;
totalblock=ceil(length(x)/block);
rms_block=0;
peak_block=0;
remain=mod(length(x),block);
z=zeros((2048-remain),1);
x=[x
   z];
for i = 0:totalblock-1
    a= i*block+1;
    b= i*block + block -1;
    rms_block=[rms_block myRms(x(a:b))];
    peak_block=[peak_block myPeak(x(a:b))];
    
end
end 

%first it didn't crash...I am able to find the RMS and peak of x and cliing
%the indices in blocks of 2048. I randomly checked locations of the output
%to see if they are correct. The attennuation of the zeros from making a
%vector of 2047 ones and seeing if ti only added one zero.
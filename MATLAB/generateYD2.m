function [t,x] = generateYD2(startFrequencyInHz) %554 for C#
    frequencyInHz = startFrequencyInHz* [1 1 9/8 5/4 1 5/4 9/8 3/4 1 1 9/8 5/4 1];
    t = [] ;
    x= [] ;
    for i=1:1:length(frequencyInHz)
        [ti, xi] = generation(0.5,frequencyInHz(i),0.5);
        x= [x xi];
        t= [t ti];
        plot(t,x);
    end
    sound(x,44100)
    
end 
    
    


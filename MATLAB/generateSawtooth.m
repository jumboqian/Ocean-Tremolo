function generateSawtooth( amplitude , frequencyInHz , lengthInS)
ts = 1/44100;
time=[0:ts:lengthInS];
Fs = 44100;
 t  = linspace(0,1-1/44100,Fs);
 h = plot(NaN,NaN);
 wave = amplitude/2;
 
 for n = 1:20
    wave = wave - (amplitude/(n*pi))*sin(2*pi*n*frequencyInHz*t) ;
    normalize(wave)
    set(h,'XData',t,'YData',wave);
    pause(0.1);
 end
 sound(wave, 44100)
end
%BONUS- The popping is due to change in frenquency and discontinuity btwenn
%notes
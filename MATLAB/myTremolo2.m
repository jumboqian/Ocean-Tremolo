function [TremFinal] = myTremolo2(x,fs,R,D,M)
% x   = input signal
% fs  = sampling frequency
% R  = tremolo rate (cycles per second)
% D  = tremolo depth (0 to 1 value)
% M   = mix wetness (wet/dry)

%mono signal check

MonoStereoTest = size(x);
if MonoStereoTest(:,2)==1
    input = x;
    

    
    % apply tremolo
    TremSignal  = Tremolo(x,fs,D,R);

    
end

%stereo signal check

MonoStereoTest = size(x);

if MonoStereoTest(:,2)==2

    
    % split into left (SigL) and right (SigR) signals
    SigL = x(:,1);
    SigR = x(:,2);

    
    % run SigL through tremolo
    TremL = Tremolo(SigL,fs,D,R);
    

    
    % run SigR through tremolo
    TremR = Tremolo(SigR,fs,D,R);
    

    
    % combine both
    TremLR  = [TremL, TremR];

end


%combine modulated and original signal

TremFinal = (TremLR .* M).* (x .* (1-M));



sound(TremFinal,fs);

end
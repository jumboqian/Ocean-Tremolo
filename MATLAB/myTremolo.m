function [TremFinal] = myTremolo(x,fs,R,D,M)
% x   = input signal
% fs  = sampling frequency
% R  = tremolo rate (cycles per second)
% D  = tremolo depth (0 to 1 value)
% M   = mix wetness

%mono signal check

MonoStereoTest = size(x);
if MonoStereoTest(:,2)==1
    input = x;
    
    % normalize
    x = x./max(abs(x));
    
    % apply tremolo
    TremSignal  = Tremolo(x,fs,D,R);

    % normalize again
    TremSignal = TremSignal./max(abs(TremSignal));
    
end

%stereo signal check

MonoStereoTest = size(x);

if MonoStereoTest(:,2)==2
    % normalize
    x(:,1) = x(:,1)./max(abs(x(:,1)));
    x(:,2) = x(:,2)./max(abs(x(:,2)));
    
    % split into left (SigL) and right (SigR) signals
    SigL = x(:,1);
    SigR = x(:,2);

    
    % run SigL through tremolo
    TremL = Tremolo(SigL,fs,D,R);
    
    % normalize SigL
    TremL  = TremL./max(abs(TremL));
    
    % run SigR through tremolo
    TremR = Tremolo(SigR,fs,D,R);
    
    % normalise SigR 
    TremR  = TremR./max(abs(TremR));
    
    % combine both
    TremLR  = [TremL, TremR];

end


%combine modulated and original signal

TremFinal = (TremLR .* M).* (x .* (1-M));

% normalization
TremFinal(:,1) = TremFinal(:,1)./max(abs(TremFinal(:,1)));
TremFinal(:,2) = TremFinal(:,2)./max(abs(TremFinal(:,2)));

end
function [ outsig ] = myTremolo(x,fs,R1,D1,M)
% x   = input signal
% fs  = sampling frequency
% C1  = Crossover Frequency between Low and Mid bands
% C2  = Crossover Frequency between Mid and High bands
% R1  = Tremolo rate - Low band (cycles per second)
% R2  = Tremolo rate - Mid band (cycles per second)
% R3  = Tremolo rate - High band (cycles per second)
% D1  = Tremolo depth - Low band (as a percentage, 0 < D1 le 1)
% D2  = Tremolo depth - Mid band (as a percentage, 0 < D2 le 1)
% D3  = Tremolo depth - High band (as a percentage, 0 < D3 le 1)
% M   = Overall Tremolo mix (0 < M greater-or-equal 1)


%% Test and run for Mono Signal

MonoStereoTest = size(x);
if MonoStereoTest(:,2)==1
    input = x;
    
    % Normalise Input Signal
    x = x./max(abs(x));
    


    % Run mono filtered signal through tremolo
    TremSignal  = Tremolo(x,fs,D1,R1);


    % Normalise each signal
    TremSignal = TremSignal./max(abs(TremSignal));
    
end

%% Test and operate for Stereo

MonoStereoTest = size(x);

if MonoStereoTest(:,2)==2
    % Normalise Input signal
    x(:,1) = x(:,1)./max(abs(x(:,1)));
    x(:,2) = x(:,2)./max(abs(x(:,2)));
    
    % Split stereo signal into left (SigL) and right (SigR) mono signals
    SigL = x(:,1);
    SigR = x(:,2);

    
    % Run filtered SigL through tremolo
    TremL = Tremolo(SigL,fs,D1,R1);
    
    % Normalise filtered SigL signals
    TremL  = TremL./max(abs(TremL));
    
    % Run filtered SigR through tremolo
    TremR = Tremolo(SigR,fs,D1,R1);
    
    % Normalise filtered SigR signals
    TremR  = TremR./max(abs(TremR));
    
    % Combine left and right signals
    TremLR  = [TremL, TremR];

end


%% CONVOLVE THREE BANDS TOGETHER



%%  MIX TOGETHER MODULATED SIGNAL AND ORIGINAL SIGNAL

outsig = (TremLR .* M).* (x .* (1-M));

% Normalise Final Signal
outsig(:,1) = outsig(:,1)./max(abs(outsig(:,1)));
outsig(:,2) = outsig(:,2)./max(abs(outsig(:,2)));


%% Create outsig file

sound(outsig,fs);

end
function [ outsig ] = MultiBandTremolo(x,fs,R1,D1,C1,R2,D2,C2,R3,D3,M)
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


%% CREATE FILTERS
    % LOWPASS FILTER
    
% FpLow = Passband end frequency for the Lowpass Filter
% FstLow = Stopband end frequency for the Lowpass Filter

FpLow  = round(C1-(C1./10));
FstLow = round(C1+(C1./0.5));

% Create Lowpass Fillter using fdesign.lowpass
LowFilt = fdesign.lowpass('Fp,Fst,Ap,Ast', FpLow, FstLow, 1, 60, fs);

% Create IIR version of Lowpass Filter
LowFiltIIR = design(LowFilt,'IIR'); %Implement IIR version of LF filter


    %BANDPASS FILTER
    
% MidNb = IIR numerator order for the Bandpass Filter
% MidNa = IIR denominator order for ther Bandpass Filter
% MidFst1 = Stopband end frequency for low end of the Bandpass Filter
% MidFp1 = Passband end frequency for low end of the Bandpass Filter
% MidFp2 = Passband end frequency for high end of the Bandpass Filter
% MidFst2 = Stopband end frequency for high end of the Bandpass Filter

MidNb  = 50; 
MidNa  = 10;
MidFs1 = (C1-(C1./10));
MidFp1 = (C1+(C1./10));
MidFp2 = (C2-(C2./10));
MidFs2 = (C2+(C2./1.5));

%Create Bandpass Filter using fdesign.bandpass
MidFilt=fdesign.bandpass('Nb,Na,Fst1,Fp1,Fp2,Fst2',MidNb,MidNa,MidFs1,MidFp1,MidFp2,MidFs2,fs);

% Create IIR version of Bandpass Filter
MidFiltIIR = design(MidFilt,'IIR');


    % HIGHPASS FILTER
    
% FpHi = Passband end frequency for the Highpass Filter
% FstHi = Stopband end frequency for the Highpass Filter

FstHi = (C2-(C2./3));
FpHi =  (C2+(C2./6));

%Create Highpass Filter using fdesign.highpass
HighFilt = fdesign.highpass('Fst,Fp,Ast,Ap', FstHi, FpHi, 60, 1, fs);
% Create FIR version of Lowpass Filter
HighFiltFIR = design(HighFilt,'FIR');


%% Test and run for Mono Signal

MonoStereoTest = size(x);
if MonoStereoTest(:,2)==1
    input = x;
    
    % Normalise Input Signal
    x = x./max(abs(x));
    
    % Run mono signal through filters
    LowSig = filter(LowFiltIIR,x);
    MidSig = filter(MidFiltIIR,x);
    HighSig = filter(HighFiltFIR,x);


    % Run mono filtered signal through tremolo
    LowTrem  = Tremolo(LowSig,fs,D1,R1);

    MidTrem  = Tremolo(MidSig,fs,D2,R2);

    HighTrem = Tremolo(HighSig,fs,D3,R3);

    % Normalise each signal
    LowTrem = LowTrem./max(abs(LowTrem));
    MidTrem = MidTrem./max(abs(MidTrem));
    HighTrem = HighTrem./max(abs(HighTrem));
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

    % Run SigL through filters
    LowSigL = filter(LowFiltIIR,SigL);
    MidSigL = filter(MidFiltIIR,SigL);
    HighSigL = filter(HighFiltFIR,SigL);
    
    % Run SigR through filters
    LowSigR = filter(LowFiltIIR,SigR);
    MidSigR = filter(MidFiltIIR,SigR);
    HighSigR = filter(HighFiltFIR,SigR);
    
    % Run filtered SigL through tremolo
    LowTremL = Tremolo(LowSigL,fs,D1,R1);
    MidTremL = Tremolo(MidSigL,fs,D2,R2);
    HighTremL = Tremolo(HighSigL,fs,D3,R3);
    
    % Normalise filtered SigL signals
    LowTremL  = LowTremL./max(abs(LowTremL));
    MidTremL  = MidTremL./max(abs(MidTremL));
    HighTremL = HighTremL./max(abs(HighTremL));
    
    % Run filtered SigR through tremolo
    LowTremR = Tremolo(LowSigR,fs,D1,R1);
    MidTremR = Tremolo(MidSigR,fs,D2,R2);
    HighTremR = Tremolo(HighSigR,fs,D3,R3);
    
    % Normalise filtered SigR signals
    LowTremR  = LowTremR./max(abs(LowTremR));
    MidTremR  = MidTremR./max(abs(MidTremR));
    HighTremR = HighTremR./max(abs(HighTremR));
    
    % Combine left and right signals
    LowTrem  = [LowTremL, LowTremR];
    MidTrem  = [MidTremL, MidTremR];
    HighTrem = [HighTremL, HighTremR]; 
end


%% CONVOLVE THREE BANDS TOGETHER

TremSig = LowTrem.*MidTrem.*HighTrem;

% Normalise output signal
outsig(:,1) = TremSig(:,1)./max(abs(TremSig(:,1)));
outsig(:,2) = TremSig(:,2)./max(abs(TremSig(:,2)));


%%  MIX TOGETHER MODULATED SIGNAL AND ORIGINAL SIGNAL

outsig = (TremSig .* M).* (x .* (1-M));

% Normalise Final Signal
outsig(:,1) = outsig(:,1)./max(abs(outsig(:,1)));
outsig(:,2) = outsig(:,2)./max(abs(outsig(:,2)));


%% Create outsig file

wavwrite(outsig,fs,'MBT_Output');

end
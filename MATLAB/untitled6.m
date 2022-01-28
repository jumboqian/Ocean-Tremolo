%  1) `220 Hz, Amplitude = 0.5, phase = 0, length = .5 seconds`
[t_sq, x1] = generateSquare(0.5, 220, 0.5, 0);
%  2)  `220 Hz, Amplitude = 0.5, phase = pi/2, length = .5 seconds`
[~, x2] = generateSquare(0.5, 220, 0.5, pi/2);
%  3) `330 Hz, Amplitude = 0.5, phase = 0, length = .5 seconds`
[~, x3] = generateSquare(0.5, 330, 0.5, 0);
%  4) `330 Hz, Amplitude = 0.5, phase = pi/2, length = .5 seconds`
[~, x4] = generateSquare(0.5, 330, 0.5, pi/2);

len_5ms = round(5/1000 * fs_sq);
t_5ms = linspace(0,5,len_5ms);

% Plot the the first 5 ms of the signals and label the axes properly.
figure(1)

subplot(4,1,1);
hold on
plot(t_5ms,x1(1:len_5ms));
legend('220 Hz, Phase=0');
xlabel('Time (ms)');
ylabel('Amplitude');

subplot(4,1,2);
hold on
plot(t_5ms,x2(1:len_5ms));
legend('220 Hz, Phase=pi/2');
xlabel('Time (ms)');
ylabel('Amplitude');

subplot(4,1,3);
hold on
plot(t_5ms,x3(1:len_5ms));
legend('330 Hz, Phase=0');
xlabel('Time (ms)');
ylabel('Amplitude');

subplot(4,1,4);
hold on
plot(t_5ms,x4(1:len_5ms));
legend('330 Hz, Phase=pi/2');
xlabel('Time (ms)');
ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%
% Computing Spectrum %
%%%%%%%%%%%%%%%%%%%%%%

% 4.b [4] Add calls to your main script to compute the spectrum and 
% plot for each signal (four figures subplots in one plot): the magnitude 
% spectrum, the phase spectrum, the real spectrum, and the imaginary 
% spectrum. Label all axes properly.

[x1f, X1Abs, X1Phase, X1Re, X1Im] = computeSpectrum(x1, fs_sq);
[x2f, X2Abs, X2Phase, X2Re, X2Im] = computeSpectrum(x2, fs_sq);
[x3f, X3Abs, X3Phase, X3Re, X3Im] = computeSpectrum(x3, fs_sq);
[x4f, X4Abs, X4Phase, X4Re, X4Im] = computeSpectrum(x4, fs_sq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Wave 1

figure(2)

subplot(2,2,1);
title('Magnitude');
hold on
plot(X1Abs);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,2);
title('Phase');
hold on
plot(X1Phase);
yticks([-pi -pi/2 0 pi/2 pi])
yticklabels({'-\pi', '-\pi/2','0','\pi/2','\pi'})
ylabel('Angle (rad)')

subplot(2,2,3);
title('Real Part');
hold on
plot(X1Re);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,4);
title('Imaginary');
hold on
plot(X1Im);
xlabel('Frequency');
ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Wave 2

figure(3)

subplot(2,2,1);
title('Magnitude');
hold on
plot(X2Abs);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,2);
title('Phase');
hold on
plot(X2Phase);
yticks([-pi -pi/2 0 pi/2 pi])
yticklabels({'-\pi', '-\pi/2','0','\pi/2','\pi'})
xlabel('Frequency')
ylabel('Angle (rad)')

subplot(2,2,3);
title('Real Part');
hold on
plot(X2Re);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,4);
title('Imaginary');
hold on
plot(X2Im);
xlabel('Frequency');
ylabel('Amplitude');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Wave 3

figure(4)

subplot(2,2,1);
title('Magnitude');
hold on
plot(X3Abs);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,2);
title('Phase');
hold on
plot(X3Phase);
yticks([-pi -pi/2 0 pi/2 pi])
yticklabels({'-\pi', '-\pi/2','0','\pi/2','\pi'})
xlabel('Frequency')
ylabel('Angle (rad)')

subplot(2,2,3);
title('Real Part');
hold on
plot(X3Re);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,4);
title('Imaginary');
hold on
plot(X3Im);
xlabel('Frequency');
ylabel('Amplitude');


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Wave 4

figure(5)

subplot(2,2,1);
title('Magnitude');
hold on
plot(X4Abs);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,2);
title('Phase');
hold on
plot(X4Phase);
yticks([-pi -pi/2 0 pi/2 pi])
yticklabels({'-\pi', '-\pi/2','0','\pi/2','\pi'})
xlabel('Frequency')
ylabel('Angle (rad)')

subplot(2,2,3);
title('Real Part');
hold on
plot(X4Re);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,4);
title('Imaginary');
hold on
plot(X4Im);
xlabel('Frequency');
ylabel('Amplitude');

% 4.c [4] Plot the log magnitude spectrum of signal 4.a.1) and 4.a.3). 
% Hint: log magnitude spectrum is given by 20*log10(X). 
% Label all axes properly.

figure(6);

subplot(1,2,1);
hold on
title('Square Wave 1')
plot(20*log10(X1Abs));
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(1,2,2);
hold on
title('Square Wave 3')
plot(20*log10(X3Abs));
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% 4.d [18] Discuss the properties of all spectra. 
% Discuss commonalities and differences. 
% How do the plots match your expectations?

%%%%%%%%%%%%%%%%%%%%%%%%%
% Computing Convolution %
%%%%%%%%%%%%%%%%%%%%%%%%%

% Add to the main script the convolution of 
    % cathy_2.wav and IR-Basilica_left.wav

fullMatlabConv = conv(cathy, basilica);

% Compute the difference between Matlab's conv output and the 
% output of your function.
% Use the first second of cathy_2.wav as input signal 
% Use IR-Basilica_left.wav as impulse response.

matlabConv = conv(cathy(1:fs), basilica);
myConv = myFreqConv(cathy(1:fs), basilica);
difference = matlabConv - myConv(1:length(matlabConv),:);
t = linspace(0,length(matlabConv)/fs,length(matlabConv));

%%% Plotting Information about the convolutions
figure(7)

subplot(3,1,1);
hold on
title('MATLAB conv()');
xlabel('Time (s)');
ylabel('Amplitude');
plot(t, matlabConv);

subplot(3,1,2);
hold on
title('myFreqConv()');
xlabel('Time (s)');
ylabel('Amplitude');
plot(t, myConv(1:length(matlabConv),:));

subplot(3,1,3);
hold on
title('Difference between Matlab and Custom Implementation');
xlabel('Time (s)');
ylabel('matlabConv - myConv');


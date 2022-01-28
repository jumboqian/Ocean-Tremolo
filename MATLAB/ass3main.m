%generate sqaure waves

% 1) `220 Hz, Amplitude = 0.5, phase = 0, length = .5 seconds`
[t1,x1]=generateSquare(0.5,220,0.5,0);

% 2)  `220 Hz, Amplitude = 0.5, phase = pi/2, length = .5 seconds`
[t2,x2]=generateSquare(0.5,220,0.5,pi/2);

% 3) `330 Hz, Amplitude = 0.5, phase = 0, length = .5 seconds`
[t3,x3]=generateSquare(0.5,330,0.5,0);

% 4) `330 Hz, Amplitude = 0.5, phase = pi/2, length = .5 seconds`
[t4,x4]=generateSquare(0.5,330,0.5,pi/2);


%plot the square waves

figure(1)

subplot(1,4,1);
plot(t1(1:len),x1(1:len));
legend('220 Hz, Phase=0');
axis([0,0.005,-1,1]);
xlabel('Time');
ylabel('Amplitude');

subplot(1,4,2)
plot(t2(1:len),x2(1:len));
legend('220 Hz, Phase=pi/2');
axis([0,0.005,-1,1]);
xlabel('Time');
ylabel('Amplitude');

subplot(1,4,3)
plot(t3(1:len),x3(1:len));
legend('330 Hz, Phase=0');
axis([0,0.005,-1,1]);
xlabel('Time');
ylabel('Amplitude');

subplot(1,4,4)
plot(t4(1:len),x4(1:len));
legend('330 Hz, Phase=pi/2');
axis([0,0.005,-1,1]);
xlabel('Time');
ylabel('Amplitude');



%call spectrums

[f1,XAbs1,XPhase1,XRe1,XIm1] = computeSpectrum(x1,65536);
[f2,XAbs2,XPhase2,XRe2,XIm2] = computeSpectrum(x2,65536);
[f3,XAbs3,XPhase3,XRe3,XIm3] = computeSpectrum(x3,65536);
[f4,XAbs4,XPhase4,XRe4,XIm4] = computeSpectrum(x4,65536);


%plot 

%square wave#1
figure(2)
title('1')
subplot(2,2,1);
title('Magnitude');
hold on
plot(XAbs1);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,2);
title('Phase');
hold on
plot(XPhase1);
ylabel('Angle')

subplot(2,2,3);
title('Real');
hold on
plot(XRe1);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,4);
title('Imaginary');
hold on
plot(XIm1);
xlabel('Frequency');
ylabel('Amplitude');

%square wave#2

figure(3)

subplot(2,2,1);
title('Magnitude');
hold on
plot(XAbs2);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,2);
title('Phase');
hold on
plot(XPhase2);
ylabel('Angle')

subplot(2,2,3);
title('Real');
hold on
plot(XRe2);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,4);
title('Imaginary');
hold on
plot(XIm2);
xlabel('Frequency');
ylabel('Amplitude');

%square wave#3

figure(4)

subplot(2,2,1);
title('Magnitude');
hold on
plot(XAbs3);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,2);
title('Phase');
hold on
plot(XPhase3);
ylabel('Angle')

subplot(2,2,3);
title('Real');
hold on
plot(XRe3);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,4);
title('Imaginary');
hold on
plot(XIm3);
xlabel('Frequency');
ylabel('Amplitude');


%square wave#4

figure(5)

subplot(2,2,1);
title('Magnitude');
hold on
plot(XAbs4);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,2);
title('Phase');
hold on
plot(XPhase4);
ylabel('Angle')

subplot(2,2,3);
title('Real');
hold on
plot(XRe4);
xlabel('Frequency');
ylabel('Amplitude');

subplot(2,2,4);
title('Imaginary');
hold on
plot(XIm4);
xlabel('Frequency');
ylabel('Amplitude');




%plot log magnitude sprxctrum

figure(6)
subplot(2,1,1);
plot(20*log10(XAbs1));
title('Square Wave 1')
xlabel('Frequency');
ylabel('Amplitude(dBFS)');

subplot(2,1,2);
plot(20*log10(XAbs3));
title('Square Wave 3')
xlabel('Frequency');
ylabel('Amplitude(dBFS)');


%read audio file

[cathy_2,cathyfs] = audioread('cathy_2.wav');
[basilica,basilicafs] = audioread('IR-Basilica_left.wav');




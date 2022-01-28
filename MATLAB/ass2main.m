[xs,fs]=audioread('serato_bigband.wav')
x=0.5*(xs(:,1)+xs(:,2));
a = [1,-4.019576181115830,6.189406442920687,-4.453198903544109,1.420842949621874,-0.141825473830304,0.004351177233495];
b = [0.255741125204258,-0.511482250408518,-0.255741125204251,1.022964500817026,-0.255741125204258,-0.511482250408514,0.255741125204258];
x_a=filter(b,a,x)
sound(x_a,fs)

%the sound seems fuller without the filter. The filter seems to cut off
%certain frequency. Also the overall volume decreased a lot after filtered.

%3
peak_x = myPeak(x);
peak_xa = myPeak(x_a);

%4
[rms_block_x, peak_block_x] = BlockedIntensity(x);
[rms_block_xa, peak_block_xa] = BlockedIntensity(x_a);


%5
[dBFS_rms_x] = dBFS(rms_block_x);
[dBFS_rms_xa] = dBFS(rms_block_xa);
[dBFS_peak_x] = dBFS(peak_block_x);
[dBFS_peak_xa] = dBFS(peak_block_xa);

totaltime = length(xs) ./ fs;
t= 0:totaltime/(length(xs)):totaltime-(totaltime/length(xs));
blockt = 0 :2048/ fs:length(rms_block_x)*2048/fs-2048/fs;

%plot(i)
plot(t,x);
title('Original');
xlabel('Time');
ylabel('Amplitude');

%plotii
subplot(2,1,1);
plot(blockt, rms_block_x);
title('Original RMS');
xlabel('Time');
ylabel('RMS');
subplot(2,1,2);
plot(blockt, rms_block_xa);
title('Filtered RMS');
xlabel('Time');
ylabel('RMS');

%plot iii 
subplot(2,1,1);
plot(blockt, peak_block_x);
title('original peak');
xlabel('time');
ylabel('Peak');
subplot(2,1,2);
plot(blockt, peak_block_xa);
title('filtered peak');
xlabel('Time');
ylabel('Peak');

%plot 4
subplot(2,1,1);
plot(blockt, dBFS_peak_x);
title('Original Peak in dBFS');
xlabel('Time');
ylabel('dBFS');
subplot(2,1,2);
plot(blockt, dBFS_peak_xa);
title('filtered peak in dBFS');
xlabel('Time');
ylabel('dBFS');

%Discussing the Plots
%Overall the plots after filtered has a lower amplitude at any given point
%of time. After cutting off certain band of frequencies, the signal
%doesnt't peak as much. It looks like the signal has been
%compressed and had less dynamic overall. Both measure in dBFS and peak
%amplitude decresed. But the overall pattern of the signal doesnt't change.
%For one point, the signal is quieting down, it still goes down. For points
%where it gets loud, it still gets loud. To summarizem, the filter changed
%the overall loudness(eq) of of the signal. But the signal's information
%pattern stayed the same.

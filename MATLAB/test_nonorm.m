clear all % Clear orkspace
[x,fs] = audioread('Guitar.wav');
tremOutput = myTremolo2(x,fs,5,0.7,0.8);
sound(tremOutput,fs);

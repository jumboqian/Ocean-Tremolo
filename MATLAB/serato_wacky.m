clear all % clears anything playing
[x,fs] = audioread('serato_bigband.wav');
tremOutput = myTremolo(x,fs,5,0.7,0.8);
sound(tremOutput,fs);

fs=44100;
[new_x_vec]=generateYD(440);

sound(new_x_vec,44100);
audiowrite('partB.wav', new_x_vec, fs)


%2b - 1, 2, 3, 1, 4, 2, 5, 1, 2, 3, 1
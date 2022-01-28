function y = myFreqConv(x,h)

lx=length(x)
lh=length(h)
l=2^nextpow2(lx+lh-1);

%get the size in zerors
x=[x,zeros(1,l-lx)];
h=[h,zeros(1,l-lh)];

%compute FFT
x=fft(x);
h=fft(h);

ft_result=x.*h;

%inverse fourier transform
y=ifft(ft_result);
end


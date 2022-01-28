function [f,XAbs,XPhase,XRe,XIm] = computeSpectrum(x,sampleRateInHz)

l1=length(x)    
f1 = fft(x)
f1 = f1(1:l1/2)
l2=length(f1)
f = 0:sampleRateInHz/l2:sampleRateInHz/2
XRe = real(f1)
XIm = imag(f1)
XAbs = abs(f1)
XPhase = angle(f1);

end



n=4;
error1 = zeros(1,n);
error2 = zeros(1,n);
h = zeros(1,n);
for j=1:n
    [error1(j),h(j)] = oneovertRK4(j*1000,-5,25);
    [error2(j)] = oneovertEE(j*1000,-5,25);
end

subplot(1,3,3)
error1
error2
hold on
plot(log(h),log(error1),'b')
plot(log(h),log(error2),'r')
title('Log(e)=f(log(h))')
hold off

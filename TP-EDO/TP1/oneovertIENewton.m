function oneovertIENewton(N,lambda,T,it)
% y'(t)=lambda*(t*y^2(t)−1/t)−1/t^2;
% y(1)=1
% numerical approximation by IE with Newton iteration
% [1,T] interval
% N gridpoints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%format long
h=(T-1)/N % stepsize
t=linspace(1,T,N+1); % grid
y=zeros(1,N+1); % vector of the numerical approximation
sol=zeros(1,N+1); % vector of the solution (it is known)
errorv=zeros(1,N+1); % vector of the errors
% the solution:
for j=1:(N+1)
    sol(j)=s(t(j));
end
% computing the numerical approximation:
y(1)=1;
tic
for j=1:N
    y(j+1)=Newton(t(j+1),t(j),y(j),y(j),lambda,h,it);
end
time=toc % time of the computation
% error:
errorv=y-sol;
% maxerror:
maxerror=max(abs(errorv))
% plots:
subplot(1,2,1)
plot(t,y)
title('Numerical approximation')
subplot(1,2,2)
plot(t,errorv,'r')
title('Error')
%xlim([1 t(length(t))]);
end
%−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
% solution:
function output=s(t)
output=1/t;
end
%−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
% Newton iteration:
function x=Newton(t2,t1,y,x,lambda,h,it)
for i=1:it
    x = x - (y+(h/2)*(lambda*(t2*x^2-1/t2)-1/t2^2)+(h/2)*(lambda*(t1*x^2-1/t1)-1/t1^2)-x)/(2*h*lambda*t2*x-1);
end
end
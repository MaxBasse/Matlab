function [output]=oneovertEE(N,lambda,T)
% y'(t)=lambda*(t*y^2(t)−1/t)−1/t^2;
% y(1)=1
% numerical approximation by EE
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
    y(j+1)=y(j)+h*f(lambda,t(j),y(j));
end
time=toc % time of the computation
% error:
errorv=y-sol;
% maxerror:
maxerror=max(abs(errorv))
output=maxerror
% error at the endpoint:
abs(y(N+1)-1/T)
% plots:
subplot(2,3,4)
plot(t,y)
title('Numerical approximation')
subplot(2,3,5)
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
% f:
function output=f(lambda,t,y)
output=lambda*(t*y^2-1/t)-1/t^2;
end
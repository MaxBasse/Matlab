function [output,step]=oneovertRK4(N,lambda,T)
% y'(t)=lambda*(t*y^2(t)−1/t)−1/t^2;
% y(1)=1
% numerical approximation by EE
% [1,T] interval
% N gridpoints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%format long
h=(T-1)/N % stepsize
step=h
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
    y1=y(j);

    f2=f(lambda,t(j),y1);
    y2=y1 + f2*h/2;

    f3=f(lambda,(t(j+1)-h/2),y2);
    y3=y1+f3*h/2;

    f4=f(lambda,(t(j+1)-h/2),y3);
    y4=y1+f4*h;

    y(j+1)=y1+(h/6)*(f2+2*f3+2*f4+f(lambda,t(j+1),y4));
end
time=toc % time of the computation
% error:
errorv=y-sol;
% maxerror:
maxerror=max(abs(errorv))

% error at the endpoint:
abs(y(N+1)-1/T)
% plots:

subplot(2,3,1)
plot(t,y)
title('Numerical approximation')
subplot(2,3,2)
plot(t,errorv,'r')
title('Error')
output=maxerror
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

function output=test(t, y, itr)
    for j=1:itr
        oneovertRK4(j*100,t ,y)
          
    end
end
   
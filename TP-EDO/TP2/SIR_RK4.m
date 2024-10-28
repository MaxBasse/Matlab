function SIR_RK4(T,h,beta,gamma,e)
	% SIR model
	% Explicit-Euler
	% pl. SIR_EE(100,.1,.5,.1,.01)
	% % % % % % % % % % % % % % %
	
	N=round(T/h); % stepsize
	t=linspace(0,T,N+1); % grid
	y=zeros(3,N+1); % numerical approximation
	% EE:
	y(:,1)=[1-e e 0]';
	for j=1:N

        y1=y(:,j);
    
        f2=SIR(beta,gamma,y1);
        y2=y1 + f2*h/2;
    
        f3=SIR(beta,gamma,y2);
        y3=y1+f3*h/2;
    
        f4=SIR(beta,gamma,y3);
        y4=y1+f4*h;
    
        y(:,j+1)=y1+(h/6)*(f2+2*f3+2*f4+SIR(beta,gamma,y4));

	%y(:,j+1)=y(:,j)+h*SIR(beta,gamma,y(:,j));
    end
    % visualization:
    subplot(1,2,2)
	plot(t,y(1,:),'g',t,y(2,:),'r',t,y(3,:),'b')
    title('SIR RK4')
	xlabel('Time')
end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = SIR(beta,gamma,y)
	% SIR model
	f = zeros(3,1);
	f(1) = -beta*y(1)*y(2);
	f(2) = beta*y(1)*y(2) - gamma*y(2);
	f(3) = gamma*y(2);
end
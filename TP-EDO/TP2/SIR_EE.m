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
	    y(:,j+1)=y(:,j)+h*SIR(beta,gamma,y(:,j));
    end
    % visualization:
    subplot(1,2,1)
	plot(t,y(1,:),'g',t,y(2,:),'r',t,y(3,:),'b')
    title('SIR EE')
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
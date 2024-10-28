function gliderEE(T,h,muL,muD,vIni,thetaIni)
	% SIR model
	% Explicit-Euler
	% pl. SIR_EE(100,.1,.5,.1,.01)
	% % % % % % % % % % % % % % %
	g=9.81
	N=round(T/h); % stepsize
	t=linspace(0,T,N+1); % grid
	y=zeros(4,N+1); % numerical approximation
	% EE:
	y(:,1)=[300 300 vIni thetaIni*pi/180]';
	for j=1:N

        y1=y(:,j);
    
        y(:,j+1)=y1+h*Glide(muL,muD,y1);

	%y(:,j+1)=y(:,j)+h*SIR(beta,gamma,y(:,j));
    end
    % visualization:
    
	%plot(t,y(1,:),'g',t,y(2,:),'r',t,y(3,:),'b')
    subplot(2,1,2)
    plot(y(1,:),y(2,:))
    title('GLIDER EE')
	xlabel('x')
end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function f = Glide(muL,muD,y)
	% SIR model
    g=9.81;
	f = zeros(4,1);
	f(1) = y(3)*cos(y(4));
	f(2) = y(3)*sin(y(4));
	f(3) = -g*sin(y(4))-muD*y(3)^2;
    f(4) = -(g/y(3))*cos(y(4))+muL*y(3);
end
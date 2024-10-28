function gliderRK4(T,h,muL,muD,vIni,thetaIni)
	% % % % % % % % % % % % % % %
	g=9.81
	N=round(T/h); % stepsize
	t=linspace(0,T,N+1); % grid
	y=zeros(4,N+1); % numerical approximation

    y(:,1)=[300 300 vIni thetaIni*pi/180]'; %Y0 datas

    % RK4 method
	for j=1:N
        y1=y(:,j); 
        f2=Glide(muL,muD,y1);
        y2=y1 + f2*h/2; 
        f3=Glide(muL,muD,y2);
        y3=y1+f3*h/2;
        f4=Glide(muL,muD,y3);
        y4=y1+f4*h;
        y(:,j+1)=y1+(h/6)*(f2+2*f3+2*f4+Glide(muL,muD,y4));
    end
    % visualization:
    subplot(2,1,1)
    plot(y(1,:),y(2,:))
    title('GLIDER RK4')
	xlabel('x')
end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function f = Glide(muL,muD,y)
    g=9.81;
	f = zeros(4,1);
	f(1) = y(3)*cos(y(4));
	f(2) = y(3)*sin(y(4));
	f(3) = -g*sin(y(4))-muD*y(3)^2;
    f(4) = -(g/y(3))*cos(y(4))+muL*y(3);
end
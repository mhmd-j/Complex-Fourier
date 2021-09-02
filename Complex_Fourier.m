clc
clear
close all
%DO NOT CHANGE THE ENDTIME, since we assumed that the period of the figure is 1s
endtime = 1;
numpoints = 500;
% define function that creates your desired figure
t = linspace(0,endtime,numpoints);
Cordmat(:,2) = (sin(2*t));
Cordmat(:,1) = exp(cos(5*t));

% transfering the center of the figure to the origin so that C0 would be zero
Cordmat(:,2) = Cordmat(:,2)-mean(Cordmat (:,2));
Cordmat(:,1) = Cordmat(:,1)-mean(Cordmat (:,1));

plot(Cordmat (:,1), Cordmat (:,2));
grid on
axis equal
imgCord = Cordmat(:,2)*1i;
realCord = Cordmat(:,1);
Cord = realCord + imgCord;
deltaT = t(2)-t(1);

% K is number Fourier Coefficient 
%(fourier coeffs actually are 2K+1 because each periodic vector has a conjogate)
K = 50;
n = -K:1:K;
C =(exp(-n'*2*pi*1i*t)*Cord.*deltaT)/endtime;
vecorg = exp(n'*2*pi*1i*t);
F = C.'*vecorg;
figure
plot(real(F),imag(F))
figAx = gcf;
Ax = figAx.CurrentAxes;
axis equal
grid on
xylim = [Ax.XLim, Ax.YLim];
%%-----------------------------
ntF = C.*vecorg;
xnOriginP = 0;
ynOriginP = 0;
xnOriginN = 0;
ynOriginN = 0;
X = 0; Y = 0;
fig = figure('Name','Vectors');
figure(fig)
axis equal
for T = 1:length(ntF)
    % T = 1
    figure(fig)
    xnOriginP = 0;
    ynOriginP = 0;
    xnOriginN = 0;
    ynOriginN = 0;
    for m = K+1:length(C)-1
        % for positive coeficients
        x = [xnOriginN, xnOriginN+real(ntF(m,T))];
        y = [ynOriginN, ynOriginN+imag(ntF(m,T))];
        xnOriginP = x(2);
        ynOriginP = y(2);
        plot(x,y,'LineWidth',1.5)
        hold on
        % for negative coeficients
        x = [xnOriginP, xnOriginP+real(ntF(length(C)-m,T))];
        y = [ynOriginP, ynOriginP+imag(ntF(length(C)-m,T))];
        xnOriginN = x(2);
        ynOriginN = y(2);
        plot(x,y,'LineWidth',1.5)
        hold on
    end
    x = [xnOriginN, xnOriginN+real(ntF(m+1,T))];
    y = [ynOriginN, ynOriginN+imag(ntF(m+1,T))];
    plot(x,y,'LineWidth',1.5)
    hold on
    X(T) = x(2);
    Y(T) = y(2);
    plot(X,Y)
    hold on
    plot(x(2),y(2),'*')
    grid on
%     axis(xylim)
    axis equal
    set(gcf,'Position',[200 50 1000 600])
    hold off
end

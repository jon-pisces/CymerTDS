

dowrite = 0; %file output

bb = CymerB_srs; % preloaded with He plasma
cc = CymerC_srs; % no He
ww = WDimes03_srs;


offset = 180.; %seconds, offset for tungsten sample
Wcorrection = 5.e14 % added to WDimes03 Dflux to avoid negative numbers. 
        %Basically, original background was not perfect.

lw = 2.;
colb = 'r';
colc = 'k';
colw = 'b';

%figure(10);%
%plot(cc.dtList, cc.temptr);


bmks =CymerB_mks;
Bhesig = bmks.m_Pres/max(bmks.m_Pres); 

cmks = CymerC_mks;
Chesig = cmks.m_Pres/max(cmks.m_Pres); 


figure(10); % CymerB mks normalized to srs 
plot(bb.dtList, bb.D_flux, colb, 'LineWidth',lw);
hold on;
plot(bmks.dtList, Bhesig * max(bb.D_flux), 'b--', 'LineWidth',lw)
legend('SRS D signal', 'MKS "He" signal');
xlabel('time (s)');
ylabel('Flux (ions m^{-2} s^{-1})');
title('CymerB with He preloading');
axis([0 8000 0 2e18]);

figure(20);  % CymerC mks normalized to srs 
plot(cc.dtList, cc.D_flux, colc, 'LineWidth',lw);
hold on;
plot(cmks.dtList, Chesig * 1.04*max(cc.D_flux), 'b--', 'LineWidth',lw)
legend('SRS D signal', 'MKS "He" signal');
xlabel('time (s)');
ylabel('Flux (ions m^{-2} s^{-1})');
title('CymerC reference sample');
axis([0 8000 0 5e18]);
%%%%%%%%%%%%%%%%%%
figure(1); 
plot(cc.dtList, cc.D_flux, colc, 'LineWidth',lw);
hold on;
plot(bb.dtList - 20, bb.D_flux, colb, 'LineWidth',lw);
plot(ww.dtList + offset, ww.D_flux, colw, 'LineWidth',lw);

plot(cc.dtList,(cc.temptr-273)*2e15,'k--')
jj=250;
plot(ww.dtList(1:end-jj) + offset,(ww.temptr(1:end-jj)-273)*2e15,'b--')


xlabel('time (s)');
ylabel('D Flux (ions m^{-2} s^{-1})');
s1 = ['No He'];
s2 = ['Preloaded with He'];
s3 = ['Tungsten'];
legend(s1, s2, s3);
title('NiP Al samples and W');
axis([0 6000 0 5e18]);
%axis([300 1250 5e14 1.e18]);

figure(2); 
plot(cc.temptr-273., cc.D_flux, colc, 'LineWidth',lw);
hold on;
plot(bb.temptr-273., bb.D_flux, colb, 'LineWidth',lw);
plot(ww.temptr-273., ww.D_flux, colw, 'LineWidth',lw);
xlabel('T (C)');
ylabel('D Flux (ions m^{-2} s^{-1})');
s1 = ['No He'];
s2 = ['Preloaded with He'];
s3 = ['Tungsten'];
legend(s1, s2, s3);
title('NiP Al samples and W');
axis([0 500 0 5e18]);

%Integrate
%Cintegraltemp_D = trapz(cc.dtList(jSpan), max(cc.D_flux(jSpan),0)) %Integral up to peak T
Cintegral_D = trapz(cc.dtList, max(cc.D_flux,0))  %Total integral

%Bintegraltemp_D = trapz(bb.dtList(jSpan), max(bb.D_flux(jSpan),0)) %Integral up to peak T
Bintegral_D = trapz(bb.dtList, max(bb.D_flux,0))  %Total integral

%Wintegraltemp_D = trapz(ww.dtList(jSpan), max(ww.D_flux(jSpan),0)) %Integral up to peak T
%Wintegral_D = trapz(ww.dtList, max(ww.D_flux,0))  %Total integral
Wintegral_D = trapz(ww.dtList, max(ww.D_flux+Wcorrection,0))  %Total integral


%Write to file:
if dowrite
    Mb = [bb.dtList - 20, bb.temptr-273., bb.D_flux];
    fname = 'CymerB_output.txt';
    dlmwrite(fname, Mb);
    
    Mc = [cc.dtList, cc.temptr-273., cc.D_flux];
    fname = 'CymerC_output.txt';
    dlmwrite(fname, Mc);
    
    %ncrop = 100; %needed b/c matrix dims not equal, not sure why
    Mw = [ww.dtList, ww.temptr-273., ww.D_flux+Wcorrection];
    fname = 'WDimes03_output.txt';
    dlmwrite(fname, Mw);
    
end;



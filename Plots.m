
dowrite = 0;
s1 = CymerB_srs; % 
s2 = CymerC_srs; %
s3 = CymerD_srs;
s4 = CymerE_srs;
s5 = CymerF_srs;
%ww = WDimes03_srs;

offset = 180.; %seconds, offset for tungsten sample

lw = 2.;
col1 = 'r';
col2 = 'k';
col3 = 'm';
col4 = 'b';
col5 = 'y';

%figure(10);%
%plot(s2.dtList, s2.temptr);

fac = 1;

figure(1); 
plot(s2.dtList, s2.D_flux, col2, 'LineWidth',lw);
hold on;
plot(s1.dtList - 20, s1.D_flux, col1, 'LineWidth',lw);
plot(s3.dtList , fac*s3.D_flux, col3, 'LineWidth',lw);
plot(s4.dtList , fac*s4.D_flux, col4, 'LineWidth',lw);
plot(s5.dtList , fac*s5.D_flux, col5, 'LineWidth',lw);
%plot(ww.dtList + offset, ww.D_flux, colw, 'LineWidth',lw);

%plot(s2.dtList,(s2.temptr-273)*2e15,'k--')
plot(s2.dtList,(s2.temptr-273)*2e16,'k--')
plot(s5.dtList,(s5.temptr-273)*2e16,'b--');
jj=250;
%plot(ww.dtList(1:end-jj) + offset,(ww.temptr(1:end-jj)-273)*2e15,'b--')


xlabel('time (s)');
ylabel('D Flux (ions m^{-2} s^{-1})');
str1 = ['No He'];
str2 = ['CymerB'];
str3 = ['CymerD'];
str4 = ['CymerE'];
str5 = ['CymerF'];
legend(str1, str2, str3, str4, str5)
title('NiP Al samples');
axis([0 6000 0 10e18]);
%axis([300 1250 5e14 1.e18]);

% figure(2); 
% plot(s2.temptr-273., s2.D_flux, colc, 'LineWidth',lw);
% hold on;
% plot(s1.temptr-273., s1.D_flux, colb, 'LineWidth',lw);
% %plot(ww.temptr-273., ww.D_flux, colw, 'LineWidth',lw);
% xlabel('T (C)');
% ylabel('D Flux (ions m^{-2} s^{-1})');
% s1 = ['No He'];
% s2 = ['Preloaded with He'];
% s3 = ['Tungsten'];
% legend(s1, s2, s3);
% title('NiP Al samples and W');
% axis([0 500 0 5e18]);

%Integrate
%Cintegraltemp_D = trapz(s2.dtList(jSpan), max(s2.D_flux(jSpan),0)) %Integral up to peak T
Cintegral_D = trapz(s2.dtList, max(s2.D_flux,0))  %Total integral

%Bintegraltemp_D = trapz(s1.dtList(jSpan), max(s1.D_flux(jSpan),0)) %Integral up to peak T
Bintegral_D = trapz(s1.dtList, max(s1.D_flux,0))  %Total integral

%Wintegraltemp_D = trapz(ww.dtList(jSpan), max(ww.D_flux(jSpan),0)) %Integral up to peak T
%Wintegral_D = trapz(ww.dtList, max(ww.D_flux,0))  %Total integral

%Write to file:

if dowrite
Mb = [s1.dtList - 20, s1.temptr-273., s1.D_flux];
fname = 'CymerB_output.txt';
dlmwrite(fname, Mb);
end

% Mortality Through time of year for Hannah Cubaynes

% COD codes: EN = 1, VS = 2, ENVS = 12, OH = 3, NH = 4, UN = 5
% spp codes: NARW = 1, Humpback = 2, Fin = 3, Minke = 4, Sei = 5, Blue = 6,
% Bryde's = 7, Sperm = 8, UN = 9
% these spp codes may be different than those published in Con Bio and
% Con Lett

% data are from 1990-2012_QC.xlsx 
% year / month / day / lat / lon / COD / spp 

% load data
clear, load('MortalityData_ForHannahCubaynes')
% concatenate MEAS and MEAS2016
MEAS = vertcat(MEAS,MEAS2016);
% MEAS and MEAS2016 are mortalities only, no SI; column 6 is
% distance along coastline
% data is all, not just coastal. 

%% plot all mortalities along coast all species 

% make month fraction vector
mday = MEAS(:,2)+(MEAS(:,3)/30);
data(:,8) = data(:,2)+(data(:,3)/30);

% calculate kernel density along coastline
[f_allall,xi_allall,bw] = ksdensity(MEAS(:,6),'width',200000);
[f_RW,xi_RW,bw] = ksdensity(MEAS(MEAS(:,4)==1,6),'width',200000); % right
[f_FS,xi_FS,bw] = ksdensity(MEAS(find(MEAS(:,4)==3 | MEAS(:,4)==4),6),'width',200000); % fin/sei = 3 and 4 spp codes in MEAS 
[f_HB,xi_HB,bw] = ksdensity(MEAS(MEAS(:,4)==2,6),'width',200000); % humpback

% begin to plot
figure(1), clf; hold on
set(gcf,'Position',[250 250 785 500])
% rule extents
plot([3477.270 3698.100],[1.25E-6 1.25E-6],'k') % SEUS
plot([3698.100 4156.472],[1.25E-6 1.25E-6],'k') % Mid-Atlantic
plot([4246.695 4338.101],[1.25E-6 1.25E-6],'k') % Morehead City/Beaufort
plot([4737.100 4807.470],[1.25E-6 1.25E-6],'k') % Chesapeake
plot([4975.700 5055.800],[1.25E-6 1.25E-6],'k') % Delaware Bay
plot([5197.324 5292.450],[1.25E-6 1.25E-6],'k') % NY/NJ
plot([5594.700 5767.630],[1.25E-6 1.25E-6],'k') % BIS
plot([6032.000 6168.980],[1.25E-6 1.25E-6],'k') % CCB
plot([5975.760 6247.370],[1.25E-6 1.25E-6],'k') % ORP
plot([5975.760 6247.370],[1.25E-6 1.25E-6],'k') % GSC

plot([6738.341 7261.435],[1.25E-6 1.25E-6],'k') % BOF
plot([7337.985 7474.765],[1.25E-6 1.25E-6],'k') % Roseway


% add labels
text(3630,1.28E-6,'SEUS','Rotation',90,'FontSize',12) % SEUS
text(3950,1.28E-6,'M-A','Rotation',90,'FontSize',12) % Mid-Atlantic
text(4300,1.28E-6,'MC/B','Rotation',90,'FontSize',12) % Morehead City/Beaufort
text(4770,1.28E-6,'CB','Rotation',90,'FontSize',12) % Chesapeake
text(5040,1.28E-6,'DB','Rotation',90,'FontSize',12) % Delaware Bay
text(5270,1.28E-6,'NY/NJ','Rotation',90,'FontSize',12) % NY/NJ
text(5650,1.28E-6,'BIS','Rotation',90,'FontSize',12) % Block Island Sound
text(6350,1.28E-6,'CCB','Rotation',90,'FontSize',12) % Cape Cod Bay
text(6150,1.28E-6,'ORP/','Rotation',90,'FontSize',12) % Off Race Point
text(5950,1.28E-6,'GSC/','Rotation',90,'FontSize',12) % Great South Channel

text(7000,1.28E-6,'BOF','Rotation',90,'FontSize',12) % BOF
text(7400,1.28E-6,'ROS','Rotation',90,'FontSize',12) % Roseway

ylim([-0.25E-7 1.45E-6])
xlim([2999 7500])

plot(xi_allall/1000,f_allall,'-');
plot(xi_FS/1000,f_FS,'--')
plot(xi_HB/1000,f_HB,'--')
plot(xi_RW/1000,f_RW,'--')


ylabel('Kernel Density')
xlabel('Distance along coastline (km)')

adjustfigurefont

print('MortalityDensity19902016','-dpng','-r300')

%% Plot spp by day of year
figure(2), clf, hold on
% all species
histogram(data(:,8),[1:12])
xlim([1 12]), ylabel('Count'), xlabel('Month of year')

histogram(data(find(MEAS(:,4)== 3 | MEAS(:,4)== 5),8),[1:12]) % fin and sei are 3 and 5 
histogram(data(MEAS(:,4)== 2,8),[1:12]) % humpbacks
histogram(data(MEAS(:,4)== 1,8),[1:12]) % right whales

adjustfigurefont

print('MortalityMonthly19902016','-dpng','-r300')

%% space vs time 
figure(3); clf; hold on
set(gcf,'Position',[343          58        1050         550])
% plot right whales
othr = find(MEAS(:,4) > 5);
plot(MEAS(othr,6)/1000,mday(othr),'o','markersize',8) % other 
FS = find(MEAS(:,4) == 3 | MEAS(:,4) == 4);
plot(MEAS(FS,6)/1000,mday(FS),'o','markersize',8) % fin and sei
plot(MEAS(MEAS(:,4) == 2,6)/1000,mday(MEAS(:,4) == 2),'o','markersize',8) % humpback
plot(MEAS(MEAS(:,4) == 1,6)/1000,mday(MEAS(:,4) == 1),'o','MarkerSize',8) % right whales

xlabel('Distance along coastline (km)','FontSize',12)
set(gca,'Ytick',1:12,'YTickLabel',{'Jan', 'Feb', 'Mar', 'Apr','May',...
    'Jun','Jul','Aug','Sept','Oct','Nov','Dec'},'FontSize',12)
% ylabel('Date of Mortality')
ylim([0 13.5])

% labels
text(3630,13.7,'SEUS','Rotation',90,'FontSize',12) % SEUS
text(3950,13.7,'M-A','Rotation',90,'FontSize',12) % Mid-Atlantic
text(4300,13.7,'MC/B','Rotation',90,'FontSize',12) % Morehead City/Beaufort
text(4770,13.7,'CB','Rotation',90,'FontSize',12) % Chesapeake
text(5040,13.7,'DB','Rotation',90,'FontSize',12) % Delaware Bay
text(5240,13.7,'NY/NJ','Rotation',90,'FontSize',12) % NY/NJ
text(5680,13.7,'BIS','Rotation',90,'FontSize',12) % Block Island Sound
text(6210,13.7,'CCB','Rotation',90,'FontSize',12) % Cape Cod Bay
text(6080,13.7,'ORP/','Rotation',90,'FontSize',12) % Off Race Point
text(5930,13.7,'GSC/','Rotation',90,'FontSize',12) % Great South Channel

text(7000,13.7,'BOF','Rotation',90,'FontSize',12) % BOF
text(7420,13.7,'ROS','Rotation',90,'FontSize',12) % Roseway

print('MortalitySpaceTime19902016','-dpng','-r300')

%% scattergram - more busy than anything
% scatterhist(MEAS(:,6),mday,'group',MEAS(:,4),'kernel','on','location','NE','direction','out')
% legend('NARW','Humpback','Fin','Sei','Minke','Blue','Sperm','Brydes','UN')


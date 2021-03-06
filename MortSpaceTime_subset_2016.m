% Plots mortalities in time and space and spatial and temporal extent of
% regulations (both ship strike rule and other regs in Canada). 

% MORTALITIES ONLY, NO SI NOW - AS OF 30 OCT 2016

% June 8 2013
% updated Oct 24 for NARWC 2016 with 2012-2016 mortalities and serious
% injuries
% Julie van der Hoop jvanderhoop@whoi.edu


% load data files
load beachedMEAS_subset2016.mat

%% make month fraction vector
mday = MEAS(:,2)+(MEAS(:,3)/30);
mday2016 = MEAS2016(:,2)+(MEAS2016(:,3)/30);

% set pre- and post- ship strike rule dates
pre = [1:766]';
post = [767:934]';

% find vessel strikes
VS = find(MEAS(:,5) == 2);
VS = MEAS(VS,:);

% find within dates
vspre = find(VS(:,1) < 2009);
vspost = find(VS(:,1) > 2008);

vsmday = find(MEAS(:,5) == 2);
vsmday = mday(vsmday);

figure(2); clf; hold on
set(gcf,'Position',[343          58        1050         550])
% plot right whales 
Egold = find(VS(:,4) == 1);
plot(VS(Egold(VS(Egold)<2009),6)/1000,vsmday(Egold(VS(Egold)<2009)),'ro','markersize',8)
plot(VS(Egold(VS(Egold)>=2009),6)/1000,vsmday(Egold(VS(Egold)>=2009)),'ro',...
    'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
% newest data
Eg = find(MEAS2016(:,4) == 1);
plot(MEAS2016(Eg,6)/1000,mday2016(Eg),'ro','MarkerSize',8,'MarkerEdgeColor','r',...
    'MarkerFaceColor','r')

%% plot other species before and after
other = find(VS(:,4) ~= 1); 
plot(VS(intersect(vspre,other),6)/1000,vsmday(intersect(vspre,other)),'ko','MarkerSize',8)
plot(VS(intersect(vspost,other),6)/1000,vsmday(intersect(vspost,other)),'ko','MarkerEdgeColor','k',...
    'MarkerFaceColor','k','MarkerSize',8)
%%
legend('Pre-Rule','Post-Rule',12,'Location','SE')
xlabel('Distance along coastline (km)','FontSize',12)
set(gca,'Ytick',1:12,'YTickLabel',{'Jan', 'Feb', 'Mar', 'Apr','May',...
    'Jun','Jul','Aug','Sept','Oct','Nov','Dec'},'FontSize',12)
% ylabel('Date of Mortality')
ylim([0 13.5])

% SMAS WITH OLD MEASURES. DO NOT USE. 
% SEUS = [3562650,0;3562650,4.5;3783883,4.5;3783883,0;3562650,14;3562650,...
%     11.5;3783883,11.5;3783883,14];
% plot(SEUS(1:4,1)/1000,SEUS(1:4,2),'k')
% plot(SEUS(5:8,1)/1000,SEUS(5:8,2),'k')
% 
% MA = [3783883,0;3783883,5;4254585,5;4254585,0;3783883,14;3783883,11;...
%     4254585,11;4254585,14];
% plot(MA(1:4,1)/1000,MA(1:4,2),'k')
% plot(MA(5:8,1)/1000,MA(5:8,2),'k')

% unified SEUS and MID-ATLANTIC
SEUSMA = [3477270,0;3477270,4.5;3698100,4.5;3698100,5;4156472,5;4156472,0;...
    3477270,14;3477270,11.5;3698100,11.5;3698100,11;4156472,11;4156472,14];

plot(SEUSMA(1:6,1)/1000,SEUSMA(1:6,2),'k')
plot(SEUSMA(7:12,1)/1000,SEUSMA(7:12,2),'k')

PORTS = [4246695,0;4246695,5;4338101,5;4338101,0;4246695,14;4246695,11;...
    4338101,11;4338101,14;4737100,0;4737100,5;4807470,5;4807470,0;...
    4737100,14;4737100,11;4807470,11;4807470,14;4975700,0;4975700,5;...
    5055800,5;5055800,0;4975700,14;4975700,11;5055800,11;5055800,14;...
    5197324,0;5197324,5;5292450,5;5292450,0;5197324,14;5197324,11;...
    5292450,11;5292450,14];
plot(PORTS(1:4,1)/1000,PORTS(1:4,2),'k')
plot(PORTS(5:8,1)/1000,PORTS(5:8,2),'k')
plot(PORTS(9:12,1)/1000,PORTS(9:12,2),'k')
plot(PORTS(13:16,1)/1000,PORTS(13:16,2),'k')
plot(PORTS(17:20,1)/1000,PORTS(17:20,2),'k')
plot(PORTS(21:24,1)/1000,PORTS(21:24,2),'k')
plot(PORTS(25:28,1)/1000,PORTS(25:28,2),'k')
plot(PORTS(29:32,1)/1000,PORTS(29:32,2),'k')

% %% if widen port entrances from 20 nmi to 30 nmi:
% % original radius = 20 nmi = 37 km. Wider radius = 30 nmi = 56 km
% PORTSWIDE = PORTS;
% PORTSWIDE(1:4:end,1) = PORTS(1:4:end,1) - 19000;
% PORTSWIDE(2:4:end,1) = PORTS(2:4:end,1) - 19000; 
% PORTSWIDE(3:4:end,1) = PORTS(3:4:end,1) + 19000; 
% PORTSWIDE(4:4:end,1) = PORTS(4:4:end,1) + 19000; 
% % PORTSWIDE = [4246695-19000,0;4246695-19000,5;4338101+19000,5;4338101+19000,0;4246695,14;4246695,11;...
% %     4338101,11;4338101,14;4737100,0;4737100,5;4807470,5;4807470,0;...
% %     4737100,14;4737100,11;4807470,11;4807470,14;4975700,0;4975700,5;...
% %     5055800,5;5055800,0;4975700,14;4975700,11;5055800,11;5055800,14;...
% %     5197324,0;5197324,5;5292450,5;5292450,0;5197324,14;5197324,11;...
% %     5292450,11;5292450,14];
% plot(PORTSWIDE(1:4,1)/1000,PORTSWIDE(1:4,2),'r')
% plot(PORTSWIDE(5:8,1)/1000,PORTSWIDE(5:8,2),'r')
% plot(PORTSWIDE(9:12,1)/1000,PORTSWIDE(9:12,2),'r')
% plot(PORTSWIDE(13:16,1)/1000,PORTSWIDE(13:16,2),'r')
% plot(PORTSWIDE(17:20,1)/1000,PORTSWIDE(17:20,2),'r')
% plot(PORTSWIDE(21:24,1)/1000,PORTSWIDE(21:24,2),'r')
% plot(PORTSWIDE(25:28,1)/1000,PORTSWIDE(25:28,2),'r')
% plot(PORTSWIDE(29:32,1)/1000,PORTSWIDE(29:32,2),'r')
% 
% % patch
% patch(PORTSWIDE(1:4,1)/1000,PORTSWIDE(1:4,2),'k','facealpha',0.25)
% patch(PORTSWIDE(5:8,1)/1000,PORTSWIDE(5:8,2),'k','facealpha',0.25)
% patch(PORTSWIDE(9:12,1)/1000,PORTSWIDE(9:12,2),'k','facealpha',0.25)
% patch(PORTSWIDE(13:16,1)/1000,PORTSWIDE(13:16,2),'k','facealpha',0.25)
% patch(PORTSWIDE(17:20,1)/1000,PORTSWIDE(17:20,2),'k','facealpha',0.25)
% patch(PORTSWIDE(21:24,1)/1000,PORTSWIDE(21:24,2),'k','facealpha',0.25)
% patch(PORTSWIDE(25:28,1)/1000,PORTSWIDE(25:28,2),'k','facealpha',0.25)
% patch(PORTSWIDE(29:32,1)/1000,PORTSWIDE(29:32,2),'k','facealpha',0.25)

BIS = [5594700,0;5594700,5;5767630,5;5767630,0;5594700,14;5594700,11;5767630,11;5767630,14];
plot(BIS(1:4,1)/1000,BIS(1:4,2),'k')
plot(BIS(5:8,1)/1000,BIS(5:8,2),'k')

% CCB = [6032000,1;6032000,5.5;6168980,5.5;6168980,1;6032000,1];
% plot(CCB(:,1)/1000,CCB(:,2),'k')
% 
% ORP = [5975760,3;5975760,5;6247370,5;6247370,3;5975760,3];
% plot(ORP(:,1)/1000,ORP(:,2),'k')
% 
% GSC = [5837140,4;5837140,8;6247370,8;6247370,4;5837140,4];
% plot(GSC(:,1)/1000,GSC(:,2),'k')

% UNIFIED CCB/ORP/GSC
BOS = [6032000,1;6032000,3;5975760,3;5975760,4;5837140,4;5837140,8;...
    5975760,8; 5975760,5;6032000,5;6032000,5.5;6168980,5.5;...
    6168980,5;6247370,5;6247370,3;6168980,3;6168980,3;6168980,1;6032000,1;];
plot(BOS(:,1)/1000,BOS(:,2),'k')

% Concurrent Canadian Regulations
BOF = [6738341,0;6738341,14;7261435,14;7261435,0];
plot(BOF(:,1)/1000,BOF(:,2),'k--')

ROS = [7377985,6;7377985,13;7474765,13;7474765,6;7377985,6];
plot(ROS(:,1)/1000,ROS(:,2),'k--')


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

set(gca,'Position',[0.1300 0.0900 0.7750 0.8100])
set(gcf,'PaperOrientation','landscape')
xlim([3000 8800])

set(gcf, 'PaperPositionMode','auto')
% print -dtiff -r600 SpaceTime20nmi_subset_updated

%% add new events since 31 Dec 2012
%% make month fraction vector 
Other = find(MEAS2016(:,4) ~= 1);
plot(MEAS2016(Other,6)/1000,mday2016(Other),'ko','MarkerEdgeColor','k',...
    'MarkerSize',8,'MarkerFaceColor','k')

cd '/Users/julievanderhoop/Documents/MATLAB/NARWC2016'
print('SpaceTime20nmi_subset_updated.png','-dpng','-r300')

return

%% 
vspre = find(VS(:,1) < 2009);
vspost = find(VS(:,1) > 2008);

vsmday = find(MEAS(:,5) == 2);
vsmday = mday(vsmday);

figure(10)
set(gcf,'Position',[1400 -50 900 600])
subplot(211)

plot(VS(vspre,6)/1000,vsmday(vspre),'ko')
hold on
plot(VS(vspost,6)/1000,vsmday(vspost),'ko','MarkerEdgeColor','k',...
    'MarkerFaceColor','k')

legend('1990-2008','2009-2012','Location','SE')
xlabel('Distance along coastline (km)')
set(gca,'Ytick',1:12,'YTickLabel',{'Jan', 'Feb', 'Mar', 'Apr','May',...
    'Jun','Jul','Aug','Sept','Oct','Nov','Dec'})
ylim([0 13.5])

% plot spatial/temporal extents of rules
plot(SEUSMA(1:6,1)/1000,SEUSMA(1:6,2),'k')
plot(SEUSMA(7:12,1)/1000,SEUSMA(7:12,2),'k')
plot(PORTS(1:4,1)/1000,PORTS(1:4,2),'k')
plot(PORTS(5:8,1)/1000,PORTS(5:8,2),'k')
plot(PORTS(9:12,1)/1000,PORTS(9:12,2),'k')
plot(PORTS(13:16,1)/1000,PORTS(13:16,2),'k')
plot(PORTS(17:20,1)/1000,PORTS(17:20,2),'k')
plot(PORTS(21:24,1)/1000,PORTS(21:24,2),'k')
plot(PORTS(25:28,1)/1000,PORTS(25:28,2),'k')
plot(PORTS(29:32,1)/1000,PORTS(29:32,2),'k')

plot(BIS(1:4,1)/1000,BIS(1:4,2),'k')
plot(BIS(5:8,1)/1000,BIS(5:8,2),'k')

plot(BOS(:,1)/1000,BOS(:,2),'k')

plot(BOF(:,1)/1000,BOF(:,2),'k--')
plot(ROS(:,1)/1000,ROS(:,2),'k--')

subplot(212)
vspre = find(VS(:,1) < 2009 & VS(:,1) > 2004);
vspost = find(VS(:,1) > 2008);

plot(VS(vspre,6)/1000,vsmday(vspre),'ko')
hold on
plot(VS(vspost,6)/1000,vsmday(vspost),'ko','MarkerEdgeColor','k',...
    'MarkerFaceColor','k')

legend('2005-2008','2009-2012','location','SE')
xlabel('Distance along coastline (km)')
set(gca,'Ytick',1:12,'YTickLabel',{'Jan', 'Feb', 'Mar', 'Apr','May',...
    'Jun','Jul','Aug','Sept','Oct','Nov','Dec'})
ylim([0 13.5])
xlim([1000 9000])

plot(SEUSMA(1:6,1)/1000,SEUSMA(1:6,2),'k')
plot(SEUSMA(7:12,1)/1000,SEUSMA(7:12,2),'k')
plot(PORTS(1:4,1)/1000,PORTS(1:4,2),'k')
plot(PORTS(5:8,1)/1000,PORTS(5:8,2),'k')
plot(PORTS(9:12,1)/1000,PORTS(9:12,2),'k')
plot(PORTS(13:16,1)/1000,PORTS(13:16,2),'k')
plot(PORTS(17:20,1)/1000,PORTS(17:20,2),'k')
plot(PORTS(21:24,1)/1000,PORTS(21:24,2),'k')
plot(PORTS(25:28,1)/1000,PORTS(25:28,2),'k')
plot(PORTS(29:32,1)/1000,PORTS(29:32,2),'k')

plot(BIS(1:4,1)/1000,BIS(1:4,2),'k')
plot(BIS(5:8,1)/1000,BIS(5:8,2),'k')

plot(BOS(:,1)/1000,BOS(:,2),'k')

plot(BOF(:,1)/1000,BOF(:,2),'k--')
plot(ROS(:,1)/1000,ROS(:,2),'k--')


%% 
return

% same for all morts
figure (3)
set(gcf,'Position',[1490 -30 1050 610])
plot(MEAS(pre,6),MEAS(pre,2),'ko')
hold on
plot(MEAS(post,6),MEAS(post,2),'ko','MarkerEdgeColor','k',...
    'MarkerFaceColor','k')

legend('Pre-Rule','Post-Rule','Location','SE')
xlabel('Distance along coastline (m)')
ylabel('Month of year')
ylim([0 13])


%%
% same for EN? % BETTER TO DO BEFORE AND AFTER ACTUAL DATE% ***** FIX 
% find vessel strikes
EN = find(MEAS(:,5) == 1);
EN = MEAS(EN,:);

% find within dates
enpre = find(EN(:,1) < 2010);
enpost = find(EN(:,1) > 2009);

figure (3)
set(gcf,'Position',[1490 -30 1050 610])
plot(EN(enpre,6),EN(enpre,2),'ko')
hold on
plot(EN(enpost,6),EN(enpost,2),'ko','MarkerEdgeColor','k',...
    'MarkerFaceColor','k')

legend('Pre-Rule','Post-Rule','Location','S')
xlabel('Distance along coastline')
ylabel('Month of year')
ylim([0 13])
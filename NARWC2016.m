% NARWC Meeting 2016 - Is the vessel-strike problem solved?
% 11 Oct 2016
warning off

close all; clear all; clc

% year / N sightings / Unique IDs / Presumed alive / Survey effort (1000s
% km) / % Pop seen / All EG Morts / EG EN morts / EG VS Morts / UN morts
data = [2000,3084,236,342,125,69,2,1,0,1;2001,3848,281,360,127,78,5,1,2,2;
    2002,2709,303,383,217,79,6,1,1,3;2003,2401,314,396,180,79,2,0,1,0;
    2004,1804,286,405,259,71,4,1,2,1;2005,3397,352,420,340,84,5,0,2,2;
    2006,2799,344,431,316,80,5,1,4,0;2007,3736,379,445,267,85,3,1,0,1;
    2008,4147,388,466,254,83,3,0,0,0;2009,4634,421,483,246,87,5,0,0,4;
    2010,3221,418,502,263,83,4,3,1,0;2011,3462,435,501,223,87,5,1,1,2;
    2012,2126,370,500,256,74,4,2,0,2;2013,1905,293,500,212,58,1,1,0,0;
    2014,2389,361,495,199,72,3,2,0,1;2015,1766,250,NaN,NaN,51,3,0,0,3;
    2016,NaN,NaN,NaN,NaN,NaN,4,1,1,2;2017,NaN,NaN,NaN,NaN,NaN,15,2,5,9];

%% figure 1: How many dead animals we find vs. live animals we see

cd '/Users/julievanderhoop/Documents/MATLAB/NARWC2016'
load beachedMEAS_subset2016.mat

figure(1);
[AX,H1,H2] = plotyy(data(:,1),data(:,6),data(:,1),data(:,7));
ylabel(AX(2),'All Eg Morts'); ylabel(AX(1),'% Population seen')
% figure(2)
% plot(data(:,6),data(:,7),'o')
% xlabel('Percent of population seen'); ylabel('All Eg Morts')
%
% figure(3)
% plot(data(:,5),data(:,7),'o')
% xlabel('Survey Effort'); ylabel('All Eg Morts')
adjustfigurefont
print('SightingsMorts.png','-dpng','-r300')

%% Mortality vs SI
% Would expect fewer mortalities since rule. Seeing more SI since rule.

MSI = [2000,1,0,0,0;2001,1,0,1,2;2002,2,0,1,1;2003,1,0,0,1;2004,0,0,1,2;...
    2005,0,1,0,2;2006,0,1,1,4;2007,0,0,1,0;2008,1,0,0,0;2009,3,0,0,0;...
    2010,1,0,3,1;2011,5,2,1,1;2012,2,1,2,0;2013,1,0,0,0;2014,7,1,2,0;...
    2015,NaN,NaN,0,0;2016,NaN,NaN,2,1];

figure(4); clf
barh(MSI(:,[4 2]),'stacked') % EN SI and MT
set(gca,'ytick',1:2:2014,'yticklabel',MSI(1:2:end,1)); title('Entanglement')
xlim([0 10]); axis ij
xlabel('Number of Cases')
adjustfigurefont('Helvetica',18)

print('Eg_ENMortSI.png','-dpng','-r300')
%% 
testdata(:,2) = data(:,7)-MSI(:,4); % mortalities other than EN
testdata(:,1) = MSI(:,4); % EN mortalities
testdata(:,3) = MSI(:,2); % EN SI

figure(20); clf
set(gcf,'position',[427   200   1044   473],'paperpositionmode','auto')

bar(data(:,7),'stacked')
ylim([0 11])
set(gca,'xtick',1:2:2014,'xticklabel',MSI(1:2:end,1))

myC= [0 0 0;];
colormap(myC)

adjustfigurefont('Helvetica',18)

% save
print('AllMorts_NARW.png','-dpng','-r300')

%% plot EN Morts
hold on
bar(testdata(:,[1 2]),'stacked')
myC= [0.5 0.5 0.5; 0 0 0;];
colormap(myC)

% save
print('AllMorts_NARW_EN.png','-dpng','-r300')

%% add SI 
bar(testdata,'stacked')
myC= [0.5 0.5 0.5; 0 0 0; 1 1 1];
colormap(myC)

print('AllMorts_NARW_ENSI.png','-dpng','-r300')

PBR = [2000 2009 2010 2011 2012 2013 2014 2015 2016;0 0 0.7 0.8 0.9 0.9 0.9 1 1];
plot(PBR(1,:)-1999,PBR(2,:),'linewidth',2,'color',[204/255 83/255 20/255])

print('AllMorts_NARW_ENSI_PBR.png','-dpng','-r300')
return


%% also plot horizontally
figure(40); clf; hold on
bar(MSI(:,[4 2]),'stacked') % EN SI and MT
set(gca,'xtick',1:2:2014,'xticklabel',MSI(1:2:end,1)); title('Entanglement')
ylim([0 10])
ylabel('Number of Cases')
adjustfigurefont('Helvetica',18)
set(gcf,'position',[427   200   1044   473],'paperpositionmode','auto')

myC= [0 0 0; 0.75 0.75 0.75];
colormap(myC)

PBR = [2000 2009 2010 2011 2012 2013 2014 2015 2016;0 0 0.7 0.8 0.9 0.9 0.9 1 1];
plot(PBR(1,:)-1999,PBR(2,:),'linewidth',2,'color',[0.5 0.5 0.5])

print('Eg_ENMortSI_horizontal.png','-dpng','-r300')

%%
figure(5); clf
barh(MSI(:,[5 3]),'stacked') % VS SI and MT
set(gca,'ytick',1:2:2014,'yticklabel',MSI(1:2:end,1)); title('Vessel Strikes')
xlim([0 10]); axis ij; set(gca,'xdir','reverse','yaxislocation','right')
xlabel('Number of Cases')
adjustfigurefont('Helvetica',18)
print('Eg_VSMortSI.png','-dpng','-r300')


%% datenum/sparklines?
for i = 1:length(MEAS)
    date(:,i) = datenum([MEAS(i,1:3) 0 0 0]);
end

for i = 1:length(MEAS2016)
    date(:,i+934) = datenum([MEAS2016(i,1:3) 0 0 0]);
end

figure(6); clf; hold on
for i = 1:length(MEAS)
    if MEAS(i,5) == 2
    plot([date(i) date(i)],[0 1],'k')
    else if MEAS(i,5) == 1
            plot([date(i) date(i)],[-1 0],'r')
        else plot([date(i) date(i)],[-1 0],'k')
        end
    end
end
for i = 935:length(date)
    plot([date(i) date(i)],[0 1],'k')
end


%% histogram
figure(8); clf; hold on
histogram(VS(other,1),'edgecolor','k','facecolor','k','facealpha',1)
histogram(VS(Egold,1),'edgecolor','k','facecolor',[0.5 0.5 0.5],'facealpha',1)
histogram(MEAS2016(Other,1),'edgecolor','k','facecolor','k','facealpha',1)
histogram(MEAS2016(Eg,1),'edgecolor','k','facecolor',[0.5 0.5 0.5],'facealpha',1)
xlim([1989 2017]); ylim([0 10]); ylabel('Number of Cases')
adjustfigurefont

print('EgOtherTimeline.png','-dpng','-r300')

%% 

histogram(data(:,7))


%% calving data

calf = [2007 23; 2008 23; 2009 39; 2010 19; 2011 22; 2012 7; 2013 20; 2014 11; 2015 17; 2016 14; 2017 3];
figure
plot(calf(:,1),calf(:,2))
return

%% population

pop = [1990	270.96106	4.19907
1991	273.9844	4.19727
1992	282.35004	4.96243
1993	282.31995	3.43512
1994	289.16068	3.05222
1995	293.32843	2.67117
1996	308.9472	2.67176
1997	316.1684	3.05282
1998	314.99326	3.43389
1999	311.90912	3.05224
2000	315.31415	2.28945
2001	333.22357	1.90659
2002	356.09302	3.43512
2003	364.0782	1.5249
2004	375.49847	3.05163
2005	394.9334	1.90782
2006	404.4447	3.05283
2007	418.91843	2.67053
2008	442.9341	1.90782
2009	466.56754	3.43389
2010	481.8046	4.19787
2011	481.01056	4.57894
2012	479.45312	5.72641
2013	475.9879	9.16032
2014	469.85095	9.92307
2015	461.04282	12.21252];

figure(80)
errorbar(pop(:,1),pop(:,2),pop(:,3),'ko','markerfacecolor','k')
xlim([1989 2016]); ylim([200 500])
adjustfigurefont('Helvetica',18)
set(gcf,'position',[427   298   851   375],'paperpositionmode','auto')

 print('NARWPopTrend.png','-dpng','-r300')

%% Compliance data

compliance = [2009,4,57.30000;2010,4.20000,55.500000;
    2011,12.8000,38.3000;2012,23.10000,29.100; 2013,23.70000,26.9000];
figure(8); hold on
plot(compliance(:,1),compliance(:,2)/10)

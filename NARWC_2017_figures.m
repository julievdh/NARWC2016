% NARWC 2017 Plots

%% timeline of management 


%% updated VS mortality data 
% Mortality vs SI
% Would expect fewer mortalities since rule. Seeing more SI since rule.
% column 2 = EN SI, 3 = VS SI, 4 = EN mortalities, 5 = VS mortalities

MSI = [2000,1,0,0,0;2001,1,0,1,2;2002,2,0,1,1;2003,1,0,0,1;2004,0,0,1,2;...
    2005,0,1,0,2;2006,0,1,1,4;2007,0,0,1,0;2008,1,0,0,0;2009,3,0,0,0;...
    2010,1,0,3,1;2011,5,2,1,1;2012,2,1,2,0;2013,1,0,0,0;2014,7,1,2,0;...
    2015,2,0,0,0;2016,6,0,2,1;2017,2,0,2,5];

myC= [0 0 0; .75 .75 .75];

figure(4); clf
barh(MSI(:,[4 2]),'stacked') % EN SI and MT
set(gca,'ytick',2:2:2017, 'yticklabel', 2001:2:2017); title('Entanglement')
xlim([0 10]); axis ij, ylim([0 19])
xlabel('Number of Cases')
adjustfigurefont('Helvetica',18)
colormap(myC)

print('Eg_ENMortSI_2017.png','-dpng','-r300')

figure(5); clf
barh(MSI(:,[5 3]),'stacked') % VS SI and MT
set(gca,'ytick',2:2:2017, 'yticklabel', 2001:2:2017); title('Vessel Strikes')
xlim([0 10]); axis ij; set(gca,'xdir','reverse','yaxislocation','right')
xlabel('Number of Cases'), ylim([0 19])
adjustfigurefont('Helvetica',18)
colormap(myC)

print('Eg_VSMortSI_2017.png','-dpng','-r300')

figure(15); clf
bar(MSI(:,[5 3]),'stacked') % VS SI and MT
set(gca,'xtick',2:2:length(MSI), 'xticklabel', 2001:2:2017); title('Vessel Strikes')
ylim([0 6]); 
ylabel('Number of Cases'), 
adjustfigurefont('Helvetica',16)
colormap(myC)

print('Eg_VSMortSI_2017_h.png','-dpng','-r300')


%% histogram through time
figure(6)
bar(MSI(:,[4 5]))

%% Timeline 
yrs = [1993 1994 1997 1999 2000 2003 2005 2006 2007 2008 2009 2013 2017]; 
figure(7), clf, hold on
plot(yrs,zeros(length(yrs),1),'k')
for i = 1:length(yrs)
% plot([yrs(i) yrs(i)],[0 1],'w')
end
set(gca,'xtick',yrs), ylim([0 1])
adjustfigurefont('Helvetica',18)
set(gcf,'paperpositionmode','auto')
xlim([1992 2018])
print('VS_ManagementTimeline','-dpng','-r300')

%% 
testdata(:,2) = data(:,7)-MSI(:,5); % mortalities other than VS
testdata(:,1) = MSI(:,5); % VS mortalities
testdata(:,3) = MSI(:,3); % VS SI

figure(20); clf
set(gcf,'position',[427   200   1044   473],'paperpositionmode','auto')

bar(data(:,7),'stacked')
% ylim([0 11])
set(gca,'xtick',1:2:length(data),'xticklabel',MSI(1:2:end,1))

myC= [0 0 0;];
colormap(myC)

adjustfigurefont('Helvetica',18)

% save
print('AllMorts_NARW_2017.png','-dpng','-r300')

%% plot VS Morts
hold on
bar(testdata(:,[1 2]),'stacked')
myC= [0.5 0.5 0.5; 0 0 0;];
colormap(myC)

% save
print('AllMorts_NARW_VS.png','-dpng','-r300')

%% add SI 
bar(testdata,'stacked')
myC= [0.5 0.5 0.5; 0 0 0; 1 1 1];
colormap(myC)

print('AllMorts_NARW_VSSI.png','-dpng','-r300')

PBR = [2000 2009 2010 2011 2012 2013 2014 2015 2016 2017; 0 0 0.7 0.8 0.9 0.9 0.9 1 1 1];
plot(PBR(1,:)-1999,PBR(2,:),'linewidth',3,'color',[204/255 83/255 20/255])

print('AllMorts_NARW_VSSI_PBR.png','-dpng','-r300')
return

% proportion of HI to total?
sum(MSI(:,[3 5])')'./data(:,7);


%% calving data 
calving(:,1) = 1993:2018; % years 
calving(:,2:3) = [8,2;8,0;7,0;22,3;20,1;6,1;4,0;1,0;31,4;22,2;19,0;16,1;28,0;
    19,2;23,2;23,2;39,1;19,0;22,0;7,1;20,1;11,1;17,0;14,1;3,1;0,0]; % number of calves and number of dead calves
% data from Waring et al. 2016 and Report cards

testdata(:,1) = calving(:,2)-calving(:,3); % surviving calves
testdata(:,2) = calving(:,3); % dead calves


figure(20); clf
set(gcf,'position',[427   200   1044   473],'paperpositionmode','auto')

bar(testdata,'stacked')
set(gca,'xtick',2:2:length(calving),'xticklabel',calving(2:2:end,1),'xlim',[0 27])
myC= [0 0 0; 0.5 0.5 0.5];
colormap(myC)
ylabel('Number of Calves')

adjustfigurefont('Helvetica',18)

% save
print('Calves_NARW_1993-2018.png','-dpng','-r300')

%% reproduction 
interval(:,1) = 2008:2017;
interval(:,2:4) = [3,3,7;4,4,8;3,3,4;4,3,3;5,4,2;5,4,7;4,5,1;6,6,4;7,7,4;10,8,0];
% mean calving interval, median calving interval, new moms 
% data from NARWC, Heather Pettis presentation 2017

figure(21); clf, hold on 
set(gcf,'position',[427   200   1044   473],'paperpositionmode','auto')
plot(interval(:,1),interval(:,3),'LineWidth',2,'color',[0.6 0.6 0.6]); 
plot(interval(:,1),interval(:,2),'LineWidth',2,'color','k'); 
ylim([0 11]) 

ylabel('Calving Interval (Years)')

adjustfigurefont('Helvetica',18)

% save
print('CalfInt_NARW_2008-2017.png','-dpng','-r300')


%% longer-term mortality
[num,txt] = xlsread('DeadEg_1970-2009.xlsx',2);

% put them together with data from above
allENmort = vertcat([num(1:30,7) num(1:30,8)],[MSI(:,1) MSI(:,4)],[2018 0]); % use DeadEg only until 1999
allVSmort = vertcat([num(1:30,7) num(1:30,9)],[MSI(:,1) MSI(:,5)],[2018 1]); % use DeadEg only until 1999


figure(22); clf, hold on 
set(gcf,'position',[427   200   1044   473],'paperpositionmode','auto')
bar(allENmort(:,1),[allENmort(:,2) allVSmort(:,2)],'stacked')
xlim([1969 2019]), adjustfigurefont('Helvetica',18)

print -dpng EgMortHI_19702018 -r300

% known dead from Kraus presentation 
KD = [2000 1; 2001 6; 2002 4; 2003 1; 2004 3; 2005 4; 2006 6; 2007 2; 2008 0; 2009 4; 
    2010 3; 2011 5; 2012 3; 2013 1; 2014 3; 2014 3; 2016 4; 2017 17]; 
OM = KD(:,2)-sum(MSI(:,4:5)')'; % other mortalities during that time (non EN and non VS)

allothermort = vertcat([num(1:30,7) sum(num(1:30,10:11)')'],[KD(:,1) OM],[2018 0]);
%%
bar(allENmort(:,1),[allENmort(:,2) allVSmort(:,2) allothermort(:,2)],'stacked');

myC = [53 42 134; 248 250 13;  55 184 154]/255;
colormap(myC)

xlim([1969 2019])

print -dpng EgMortall_19702018 -r300

PBR = [1970 2000 2009 2010 2011 2012 2013 2014 2015 2016 2017; 0 0 0 0.7 0.8 0.9 0.9 0.9 1 1 1];
plot(PBR(1,:),PBR(2,:),'linewidth',2,'color',[204/255 83/255 20/255])
ylabel('Number of Confirmed Mortalities'), adjustfigurefont('Helvetica',18)

print -dpng EgMortall_19702018_PBR -r300 
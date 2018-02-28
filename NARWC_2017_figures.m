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

% NARWC Meeting 2016 - Is the vessel-strike problem solved?
% 11 Oct 2016

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
    2016,NaN,NaN,NaN,NaN,NaN,4,1,1,2];

%% figure 1: How many dead animals we find vs. live animals we see

cd '/Users/julievanderhoop/Documents/MATLAB/NARWC2016'

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

figure(4)
bar(MSI(:,[4 2]),'stacked') % EN SI and MT
set(gca,'xtick',1:2:2014,'xticklabel',MSI(1:2:end,1)); title('Entanglement')
ylim([0 10])
ylabel('Number of Cases')
adjustfigurefont

print('Eg_ENMortSI.png','-dpng','-r300')

figure(5)
bar(MSI(:,[5 3]),'stacked') % VS SI and MT
set(gca,'xtick',1:2:2014,'xticklabel',MSI(1:2:end,1)); title('Vessel Strikes')
ylim([0 10])
ylabel('Number of Cases')
adjustfigurefont
print('Eg_VSMortSI.png','-dpng','-r300')
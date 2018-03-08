cd /Users/julievanderhoop/Documents/MATLAB/NARWC2016
[num,txt] = xlsread('Pop estimates for Julie.xlsx');

figure(1); clf
set(gcf,'position',[427   200   1044   473],'paperpositionmode','auto')
plot(num(:,1),num(:,2),'ko','markerfacecolor','k')
ylabel('Minimum Number Alive')
adjustfigurefont('Helvetica',18)

print -dpng EgPop_19802018 -r300

ylim([0 2000]), xlim([1993 2018])

print -dpng EgPop_19932018 -r300

ylim([0 550]), xlim([1970 2019])

print -dpng EgPop_19702019 -r300


%% whaling timeline
yrs = [1000 1100 1400 1500 1600 1700 1780 1800 1900 1924 1935 1982];
figure(7), clf, hold on
plot(yrs,zeros(length(yrs),1),'k')
for i = 1:length(yrs)
 % plot([yrs(i) yrs(i)],[0 1],'w')
end
set(gca,'xtick',yrs), ylim([0 1])
adjustfigurefont('Helvetica',18)
set(gcf,'paperpositionmode','auto')
xlim([1000 2018])

adjustfigurefont('Helvetica',18)

print -dpng EgWhaling -r300

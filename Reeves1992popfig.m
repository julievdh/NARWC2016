% reeves et al 1992 figure of right whale abundance 

[num1,txt1] = xlsread('/Users/julievanderhoop/Documents/Reviews/Frontiers_NARW/Reeves 1992 Abundance Data.xlsx',1);

cd /Users/julievanderhoop/Documents/MATLAB/NARWC2016
[num2,txt2] = xlsread('Pop estimates for Julie.xlsx');

figure(1); clf, hold on 
set(gcf,'position',[366   200   1044   473],'paperpositionmode','auto')
plot(num1(:,1),num1(:,2),'k-','linewidth',2)
plot(num1(:,3),num1(:,4),'k--','linewidth',2)
plot(num1(:,5),num1(:,6),'k--','linewidth',2)
plot(num2(:,1),num2(:,2),'ko','markerfacecolor','k')
adjustfigurefont('Helvetica',18)
xlim([1625 2025])

print -dpng EgPop_16332018 -r300 

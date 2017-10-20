%% Vessel Compliance SMA expectation

speedBI = [14 14 14 10 10 14 14 14 14 14 14 14 14];
speedMA = [14 10 10 14 14 14 14 14 14 14 14 14 14];
month = 0:12; 

plot(month(1:7),speedBI(1:7),month(1:7),speedMA(1:7))
legend('Block Island','Mid Atlantic','location','SE')
ylim([8 15]), ylabel('Speed (kts)'), adjustfigurefont
set(gca,'xtick',1:12,'xticklabels',{'J','F','M','A','M','J','J','A','S','O','N','D'})

cd /Users/julievanderhoop/Documents/MATLAB/NARWC2016
print('SMAexpectation_short','-dpng')

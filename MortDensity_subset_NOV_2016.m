% Calculates kernel density of distance along coastline of mortalities
% associated with VS or all COD.

% Julie van der Hoop jvanderhoop@whoi.edu
% June 6 2013; Updated 26 Oct 2016 for NARWC 2016

close all; clear all; clc

% load data files
% MORTALITIES ONLY, NO SI
load beachedMEAS_subset2016.mat

% subtract measurement 2993662 as this is the spatial reference of the tip
% of the FL peninsula. This way, data are measured from zero.
% MEAS(:,6) = MEAS(:,6) - 2993662;

% make month fraction vector
mday = MEAS(:,2)+(MEAS(:,3)/30);

% find vessel strikes
VS = find(MEAS(:,5) == 2);
VS = MEAS(VS,:);

% find within dates
vspre = find(VS(:,1) < 2009);
vspre4 = [82:109]'; % between 9 Dec 2004 and 9 Dec 2008
% vspre4 = find(VS(:,1) < 2009 & VS(:,1) > 2004);
vspost = find(VS(:,1) > 2008);

%% which ones are in the middle?

opentime = iswithin(VS(:,2),[5 11]);
openspace = iswithin(VS(:,6),[4737100 5975760]);
for i = 1:length(openspace)
    if opentime(i) == 1 & openspace(i) == 1
        openspacetime(i) = 1;
    else openspacetime(i) = 0;
    end
end

% species = VS(:,4)
figure(9)
histogram(VS(openspacetime == 1,4))

%% for all OTHER COD

% find COD not = VS
otherCOD = find(MEAS(:,5) ~= 2);
otherCOD = MEAS(otherCOD,:);

% find appropriate xi value
[f_allall,xi_allall,bw] = ksdensity(otherCOD(:,6),'width',200000);

pre = find(otherCOD(:,1) < 2009);
pre4 = [508:657]'; % between 9 Dec 2004 and 9 Dec 2008
% pre4 = find(MEAS(:,1) < 2009 & MEAS(:,1) > 2004);
post = find(otherCOD(:,1) > 2008);

[f_pre_ALL,xi_pre_ALL] = ksdensity(otherCOD(pre,6),xi_allall,'width',200000);
[f_post_ALL,xi_post_ALL] = ksdensity(otherCOD(post,6),xi_allall,'width',200000);
[f_pre_ALL4,xi_pre_ALL4] = ksdensity(otherCOD(pre4,6),xi_allall,'width',200000);

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

% legend('Pre-rule All COD','Post-Rule All COD','Pre-rule VS','Post-rule VS','Location','best')
ylabel('Kernel Density')
xlabel('Distance along coastline (km)')


% plot(xi_allall/1000,f_pre_ALL,'k--'); hold on
% plot(xi_allall/1000,f_pre_ALL4,'k.-'); hold on
% plot(xi_allall/1000,f_post_ALL,'k')

%% calculate kernel densities
[f_post,xi_post] = ksdensity(VS(vspost,6),xi_allall,'width',200000);
[f_pre,xi_pre] = ksdensity(VS(vspre,6),xi_allall,'width',200000);
[f_pre4,xi_pre4] = ksdensity(VS(vspre4,6),xi_allall,'width',200000);

% plot VS kernel densities
h = plot(xi_pre/1000,f_pre,'k--'); hold on
% plot(xi_pre/1000,f_pre4,'b.-')
% X=[xi_pre/1000,fliplr(xi_pre/1000)];                %#create continuous x value array for plotting
% Y=[f_pre,fliplr(f_pre4)];              %#create y values for out and then back
% fill(X,Y,'b');                  %#plot filled area between all pre and pre-4

plot(xi_post/1000,f_post,'k')

%% for 2012-2016 events:
% calculate kernel densities
%[f_post2016,xi_post2016] = ksdensity(MEAS2016(:,6),xi_allall,'width',200000);
%plot(xi_post2016/1000,f_post2016,'r')

% all post (2009 - 2016)
[f_allpost2016,xi_allpost2016] = ksdensity(vertcat(VS(vspost,6),MEAS2016(:,6)),xi_allall,'width',200000);
plot(xi_allpost2016/1000,f_allpost2016,'r')

%% brush plot
% for i = 1:length(MEAS)
% plot([MEAS(i,6)/1000 MEAS(i,6)/1000],[11.5E-7 12E-7],'k')
% end
%
for i = 1:length(VS)
    plot([VS(vspre,6)/1000 VS(vspre,6)/1000],[11.5E-7 12E-7],'k')
end

for i = 1:length(VS)
    plot([VS(vspost,6)/1000 VS(vspost,6)/1000],[11E-7 11.5E-7],'r')
end

for i = 1:length(MEAS2016)
    plot([MEAS2016(i,6)/1000 MEAS2016(i,6)/1000],[11E-7 11.5E-7],'r')
end

set(gca,'XtickLabel',[0:500:4500])
box off
plot([7500 7500],[-0.5 1.45E-6],'k')
plot([0 10000],[1.448E-6 1.448E-6],'k')

set(gcf, 'PaperPositionMode','auto')
cd '/Users/julievanderhoop/Documents/MATLAB/NARWC2016'
print('vanderHoop_Density_updated2016.png','-dpng','-r300')

return

%% US ONLY AND KS TEST

% find mortalities in US waters
US = find(MEAS(:,6) < 6745185);
US = MEAS(US,:);

VSUS = find(US(:,5) == 2);
VSUS = US(VSUS,:);

% find new pre and post
pre = find(US(:,1) < 2009);
post = find(US(:,1) > 2008);

[f_pre_US_ALL,xi_pre_US_ALL] = ksdensity(US(pre,6),'width',200000);
[f_post_US_ALL,xi_post_US_ALL] = ksdensity(US(post,6),'width',200000);

% find new pre and post
pre = find(VSUS(:,1) < 2009);
post = find(VSUS(:,1) > 2008);

[f_pre_VSUS,xi_pre_VSUS] = ksdensity(VSUS(pre,6),'width',200000);
[f_post_VSUS,xi_post_VSUS] = ksdensity(VSUS(post,6),'width',200000);

plot(xi_post_US_ALL,f_post_US_ALL,'k')
hold on
plot(xi_pre_US_ALL,f_pre_US_ALL,'k--')
plot(xi_pre_VSUS,f_pre_VSUS,'r--')
plot(xi_post_VSUS,f_post_VSUS,'r')


%%
figure(3)
set(gcf,'Position',[1600 -100 800 700])
subplot(211)
set(gca,'Position',[0.1300 0.55 0.7750 0.3412])

% plot VS kernel densities
plot(xi_pre/1000,f_pre,'k--'); hold on
plot(xi_post/1000,f_post,'k')
ylim([0 1.28E-6]); xlim([-5 10E3])

legend('1990-2008','2008-2012')
ylabel('Kernel Density','FontSize',12)
xlabel('Distance along coastline (km)','FontSize',12)


% rule extents
plot([3562.650 3783.883],[1.2E-6 1.2E-6],'k') % SEUS
plot([3783.833 4254.585],[1.2E-6 1.2E-6],'k') % Mid-Atlantic
plot([4358.025 4447.142],[1.2E-6 1.2E-6],'k') % Morehead City/Beaufort
plot([4854.360 4935.569],[1.2E-6 1.2E-6],'k') % Chesapeake
plot([5097.220 5178.770],[1.2E-6 1.2E-6],'k') % Delaware Bay
plot([5322.677 5421.315],[1.2E-6 1.2E-6],'k') % NY/NJ
plot([5580.100 5911.370],[1.2E-6 1.2E-6],'k') % BIS
plot([6192.146 6331.840],[1.2E-6 1.2E-6],'k') % CCB
plot([6133.615 6394.000],[1.2E-6 1.2E-6],'k') % ORP
plot([5987.500 6394.000],[1.2E-6 1.2E-6],'k') % GSC

text(3E2,1.15E-6,'(a)','FontSize',12)

%% do the same for latitude instead of distance along coast

load VS_LAT % coordsinates of VS, aligned with dates for VS vector

% make month fraction vector
mday = VS(:,2)+(VS(:,3)/30);

% find within dates
vspre = find(VS(:,1) < 2009);
vspost = find(VS(:,1) > 2008);


% calculate kernel densities
[f_pre_LAT,xi_pre] = ksdensity(VS_LAT(vspre));
[f_post_LAT,xi_post] = ksdensity(VS_LAT(vspost),xi_pre);

% plot VS kernel densities
figure(2)
set(gcf,'Position',[1500 -100 800 630])
plot(xi_pre,f_pre_LAT,'r--')
hold on
plot(xi_post,f_post_LAT,'r')

legend('Pre-rule VS','Post-rule VS')
ylabel('Kernel Density')
xlabel('Latitude ^oN')

ylim([0 0.27])% plot rule extents
plot([31.45 29.75],[0.25 0.25],'k') % SEUS
plot([33.945 31.45],[0.25 0.25],'k') % Mid-Atlantic
plot([34.462965 34.862133],[0.25 0.25],'k') % Morehead City/Beaufort
plot([36.701173 37.305429],[0.25 0.25],'k') % Chesapeake
plot([38.5401883 39.10506],[0.25 0.25],'k') % Delaware Bay
plot([40.162509 40.5959972],[0.25 0.25],'k') % NY/NJ
plot([40.5959972 41.3184775],[0.25 0.25],'k') % BIS
plot([41.699421 42.211725],[0.25 0.25],'k') % CCB
plot([41.66667 42.5],[0.25 0.25],'k') % ORP
plot([41.00321 42.5],[0.25 0.25],'k') % GSC


figure(3)
subplot(212)

plot(xi_pre,f_pre_LAT,'k--')
hold on
plot(xi_post,f_post_LAT,'k')

% plot rule extents
plot([31.45 29.75],[0.25 0.25],'k') % SEUS
plot([33.945 31.45],[0.25 0.25],'k') % Mid-Atlantic
plot([34.462965 34.862133],[0.25 0.25],'k') % Morehead City/Beaufort
plot([36.701173 37.305429],[0.25 0.25],'k') % Chesapeake
plot([38.5401883 39.10506],[0.25 0.25],'k') % Delaware Bay
plot([40.162509 40.5959972],[0.25 0.25],'k') % NY/NJ
plot([40.5959972 41.3184775],[0.25 0.25],'k') % BIS
plot([41.699421 42.211725],[0.25 0.25],'k') % CCB
plot([41.66667 42.5],[0.25 0.25],'k') % ORP
plot([41.00321 42.5],[0.25 0.25],'k') % GSC

ylabel('Kernel Density','FontSize',12)
xlabel('Latitude ^oN','FontSize',12)
ylim([0 0.27])
text(21,0.24,'(b)','FontSize',12)
set(gca,'Position',[0.1300 0.07 0.7750 0.3412])

% add labels to (b)
text(30.5,0.28,'SEUS','Rotation',90,'FontSize',12)
text(32,0.28,'M-A','Rotation',90,'FontSize',12)
text(34.6,0.28,'MC/B','Rotation',90,'FontSize',12)
text(36.9,0.28,'CB','Rotation',90,'FontSize',12)
text(38.75,0.28,'DB','Rotation',90,'FontSize',12)
text(40.3,0.28,'NY/NJ','Rotation',90,'FontSize',12)
text(41,0.28,'BIS','Rotation',90,'FontSize',12)
text(41.7,0.28,'GSC','Rotation',90,'FontSize',12)
text(42.3,0.28,'CCB/ORP','Rotation',90,'FontSize',12)

% add labels to (a)
text(31.1,0.66,'SEUS','Rotation',90,'FontSize',12)
text(32,0.66,'M-A','Rotation',90,'FontSize',12)
text(33.2,0.66,'MC/B','Rotation',90,'FontSize',12)
text(34.75,0.66,'CB','Rotation',90,'FontSize',12)
text(35.35,0.66,'DB','Rotation',90,'FontSize',12)
text(36.1,0.66,'NY/NJ','Rotation',90,'FontSize',12)
text(37.2,0.66,'BIS','Rotation',90,'FontSize',12)
text(38.3,0.66,'GSC','Rotation',90,'FontSize',12)
text(38.9,0.66,'CCB/ORP','Rotation',90,'FontSize',12)


%# set size on printed paper
%#set(gcf, 'PaperUnits','centimeters', 'PaperPosition',[0 0 5 10])
%# WYSIWYG mode: you need to adjust your screen's DPI (*)
% set(gcf, 'PaperPositionMode','auto')

%# save as TIFF
% print -dtiff -r300 SpatialLatDistance.tiff

% print proper dimensioncs for journal
% set(gcf, 'units', 'centimeters', 'pos', [52 10 17.3 7])
% set(gcf, 'units', 'centimeters')
% print -depsc vanderHoop_CL_Fig4.eps



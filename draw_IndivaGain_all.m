namelist = dir('D:\MyPaper\2Outgoing\2Register\register\Fourth experiment\5twoDirection\data_weight\916_two_direction_agg\');
len=length(namelist);
temp_OM=[];
temp_Neg=[];
temp_OMRight=[];
temp_OMLeft=[];
temp_NegLeft=[];
temp_NegRight=[];
for i = 1:len
      file_name = namelist(i).name;
      if strcmp(file_name,'.') || strcmp(file_name,'..') 
          continue
      end
      Data=[];
      file_nameF=['./data_weight/916_two_direction_agg/',file_name];
      %disp(file_name);
      Data=importdata(file_nameF);
      array = Data.data;
      OMTotal= array(:,7);
      SMTotal= array(:,8);
      NETotal= array(:,9);
      OMLeft= array(:,1);
      SMLeft= array(:,2);
      NELeft=array(:,3);
      OMRight=array(:,4);
      SMRight=array(:,5);
      NERight=array(:,6);
      OMGain=SMTotal-OMTotal;
      NEGain=SMTotal-NETotal;
      OMGainLeft=SMLeft-OMLeft;
      NEGainLeft=SMLeft-NELeft;
      OMGainRight=SMRight-OMRight;
      NEGainRight=SMRight-NERight;
      for j=1:length(NEGain)
          if NEGain(j) < 0
              if OMGain(j) >=0
                  NEGain(j)=OMGain(j);
                  NEGainLeft(j)=OMGainLeft(j);
                  NEGainRight(j)=OMGainRight(j);
              else
                  NEGain(j)=0;
                  NEGainLeft(j)=0;
                  NEGainRight(j)=0;
              end
          end
      end
      OMGainP=(OMGain./SMTotal)*100;
      NEGainP=(NEGain./SMTotal)*100;
      OMGainLeftP= (OMGainLeft./SMTotal)*100;
      NEGainLeftP=(NEGainLeft./SMTotal)*100;
      OMGainRightP= (OMGainRight./SMTotal)*100;
      NEGainRightP=(NEGainRight./SMTotal)*100;
      temp_OM=[temp_OM,mean(OMGainP)];
      temp_Neg=[temp_Neg,mean(NEGainP)];
      temp_NegLeft = [temp_NegLeft,mean(NEGainLeftP)];
      temp_OMLeft = [temp_OMLeft,mean(OMGainLeftP)];
      temp_OMRight = [temp_OMRight,mean(OMGainRightP)];
      temp_NegRight = [temp_NegRight,mean(NEGainRightP)];
end
subplot(3,1,1);
OM=cdfplot(temp_OM);
hold on;
NG=cdfplot(temp_Neg);
set(gca,'YTick',(0:0.2:1));
set(gca,'XTick',(0:10:100));
set(gca,'XLim',[0 100]);
legend('OM','NBREG','Location','best');
set(gca,'Xlabel',[]);
set(gca,'Ylabel',[]);
%,'Marker','*','MarkerSize',5
set(OM,'LineStyle','-','LineWidth',2,'Color','red');
set(NG,'LineStyle',':','LineWidth',2,'Color','blue');
title('右自治系统向左自治系统注册');
subplot(3,1,2);
OML=cdfplot(temp_OMLeft);
hold on;
NGL=cdfplot(temp_NegLeft);
legend('OM','NBREG','Location','best');
set(gca,'Xlabel',[]);
ylabel('自治系统对的累积分布 ','Fontname','宋体','FontSize',14);
set(gca,'YTick',(0:0.2:1));
set(gca,'XTick',(-100:10:0));
set(gca,'XLim',[-100 0]);
set(OML,'LineStyle','-','LineWidth',2,'Color','red');
set(NGL,'LineStyle',':','LineWidth',2,'Color','blue');
title('左自治系统');
subplot(3,1,3);
OMR=cdfplot(temp_OMRight);
hold on;
NGR=cdfplot(temp_NegRight);
legend('OM','NBREG','Location','best');
xlabel('平均收益 / %','Fontname','宋体','FontSize',14);
set(gca,'Ylabel',[]);
set(gca,'YTick',(0:0.2:1));
set(gca,'XTick',(0:10:100));
set(gca,'XLim',[0 100]);
set(OMR,'LineStyle','-','LineWidth',2,'Color','red');
set(NGR,'LineStyle',':','LineWidth',2,'Color','blue');
title('右自治系统');
saveas(gcf,'./916_two_direction/indiv/weight/stat/allASPairAverageGainLTR.png');
saveas(gcf,'./916_two_direction/indiv/weight/stat/allASPairAverageGainLTR.fig');



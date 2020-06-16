%双方向注册收益和
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
      OMLeftLTR= array(:,1);
      SMLeftLTR= array(:,2);
      NELeftLTR=array(:,3);
      OMRightLTR=array(:,4);
      SMRightLTR=array(:,5);
      NERightLTR=array(:,6);
      OMTotalLTR= array(:,7);
      SMTotalLTR= array(:,8);
      NETotalLTR= array(:,9);
      OMGainLTR=((SMTotalLTR-OMTotalLTR)./SMTotalLTR)*100;
      NEGainLTR=((SMTotalLTR-NETotalLTR)./SMTotalLTR)*100;
      OMGainLeftLTR=((SMLeftLTR-OMLeftLTR)./SMTotalLTR)*100;
      NEGainLeftLTR=((SMLeftLTR-NELeftLTR)./SMTotalLTR)*100;
      OMGainRightLTR=((SMRightLTR-OMRightLTR)./SMTotalLTR)*100;
      NEGainRightLTR=((SMRightLTR-NERightLTR)./SMTotalLTR)*100;
      for j=1:length(NEGainLTR)
          if NEGainLTR(j) < 0
              if OMGainLTR(j) >=0
                  NEGainLTR(j)=OMGainLTR(j);
                  NEGainLeftLTR(j)=OMGainLeftLTR(j);
                  NEGainRightLTR(j)=OMGainRightLTR(j);
              else
                  NEGainLTR(j)=0;
                  NEGainLeftLTR(j)=0;
                  NEGainRightLTR(j)=0;
              end
          end
      end
      OMLeftRTL= array(:,10);
      SMLeftRTL= array(:,11);
      NELeftRTL=array(:,12);
      OMRightRTL=array(:,13);
      SMRightRTL=array(:,14);
      NERightRTL=array(:,15);
      OMTotalRTL= array(:,16);
      SMTotalRTL= array(:,17);
      NETotalRTL= array(:,18);
      OMGainRTL=((SMTotalRTL-OMTotalRTL)./SMTotalRTL)*100;
      NEGainRTL=((SMTotalRTL-NETotalRTL)./SMTotalRTL)*100;
      OMGainLeftRTL=((SMLeftRTL-OMLeftRTL)./SMTotalRTL)*100;
      NEGainLeftRTL=((SMLeftRTL-NELeftRTL)./SMTotalRTL)*100;
      OMGainRightRTL=((SMRightRTL-OMRightRTL)./SMTotalRTL)*100;
      NEGainRightRTL=((SMRightRTL-NERightRTL)./SMTotalRTL)*100;
      for j=1:length(NEGainRTL)
          if NEGainRTL(j) < 0
              if OMGainRTL(j) >=0
                  NEGainRTL(j)=OMGainRTL(j);
                  NEGainLeftRTL(j)=OMGainLeftRTL(j);
                  NEGainRightRTL(j)=OMGainRightRTL(j);
              else
                  NEGainRTL(j)=0;
                  NEGainLeftRTL(j)=0;
                  NEGainRightRTL(j)=0;
              end
          end
      end
      OG=mean(OMGainLTR)+mean(OMGainRTL);
      if OG < 0
            OG = 0;
      end
      NG=mean(NEGainLTR)+mean(NEGainRTL);
      if NG <0
          NG = 0;
      end
      OGL=mean(OMGainLeftLTR)+mean(OMGainLeftRTL);
      if OGL <0
          OGL = 0;
      end
      NGL=mean(NEGainLeftLTR)+mean(NEGainLeftRTL);
      if NGL <0
          NGL =0;
      end
      OGR=mean(OMGainRightLTR)+mean(OMGainRightRTL);
      if OGR <0
          OGR = 0;
      end
      NGR=mean(NEGainRightLTR)+mean(NEGainRightRTL);
      if NGR <0
          NGR=0;
      end
      temp_OM=[temp_OM,OG/2];
      temp_Neg=[temp_Neg,NG/2];
      temp_OMLeft = [temp_OMLeft,OGL/2];
      temp_NegLeft = [temp_NegLeft,NGL/2];
      temp_OMRight = [temp_OMRight,OGR/2];
      temp_NegRight = [temp_NegRight,NGR/2];
end
%画图
subplot(3,1,1);
OM=cdfplot(temp_OM);
hold on;
NG=cdfplot(temp_Neg);
set(gca,'YTick',(0:0.2:1));
set(gca,'XTick',(0:10:80));
set(gca,'XLim',[0 80]);
legend('OM','NBREG','Location','best');
set(gca,'Xlabel',[]);
set(gca,'Ylabel',[]);
%,'Marker','*','MarkerSize',5
set(OM,'LineStyle','-','LineWidth',2,'Color','red');
set(NG,'LineStyle',':','LineWidth',2,'Color','blue');
title('AS对');
subplot(3,1,2);
OML=cdfplot(temp_OMLeft);
hold on;
NML=cdfplot(temp_NegLeft);
legend('OM','NBREG','Location','best');
set(gca,'Xlabel',[]);
ylabel('自治系统对的累积分布 / %','Fontname','宋体','FontSize',14);
set(gca,'YTick',(0:0.2:1));
set(gca,'XTick',(0:10:80));
set(gca,'XLim',[0 80]);
set(OML,'LineStyle','-','LineWidth',2,'Color','red');
set(NML,'LineStyle',':','LineWidth',2,'Color','blue');
title('左自治系统');
subplot(3,1,3);
OMR=cdfplot(temp_OMRight);
hold on;
NMR=cdfplot(temp_NegRight);
legend('OM','NBREG','Location','best');
xlabel('平均收益 / %','Fontname','宋体','FontSize',14);
set(gca,'Ylabel',[]);
set(gca,'YTick',(0:0.2:1));
set(gca,'XTick',(0:10:80));
set(gca,'XLim',[0 80]);
set(OMR,'LineStyle','-','LineWidth',2,'Color','red');
set(NMR,'LineStyle',':','LineWidth',2,'Color','blue');
title('右自治系统');
saveas(gcf,'./916_two_direction/two_direction_add/weight_allASPairAverageGain.png');
saveas(gcf,'./916_two_direction/two_direction_add/weight_allASPairAverageGain.fig');
%�����ܵ�322��AS��������
namelist = dir('D:\MyPaper\2Outgoing\2Register\register\fourth experiment\5twoDirection\data_weight\916_two_direction_agg\');
len=length(namelist);
temp_OM=[];
temp_Neg=[];
for i = 1:len
      file_name = namelist(i).name;
      if  strcmp(file_name,'.') || strcmp(file_name,'..')
          continue
      end
      Data=[];
      %֮ǰ�ĳ���countsOM��countsNegû���
      %countsOM=[];
      %countsNeg=[];
      file_nameF=['./data_weight/916_two_direction_agg/',file_name];
      Data=importdata(file_nameF);
      array = Data.data;
      OMTotal= array(:,7);
      SMTotal= array(:,8);
      NETotal= array(:,9);
      OMGain=SMTotal-OMTotal;
      NEGain=SMTotal-NETotal;
      for j=1:length(NEGain)
          if NEGain(j) < 0
              if OMGain(j) >=0
                  NEGain(j)=OMGain(j);
              else
                  NEGain(j)=0;
              end
          end
      end
      OMGainP= (OMGain./SMTotal)*100;
      NEGainP=(NEGain./SMTotal)*100;
      temp_OM = [temp_OM,mean(OMGainP)];
      temp_Neg = [temp_Neg,mean(NEGainP)];
end
OM=cdfplot(temp_OM);
hold on;
NG=cdfplot(temp_Neg);
set(OM,'LineStyle','-','LineWidth',2,'Color','r');
set(NG,'LineStyle',':','LineWidth',2,'Color','b');
temp=temp_OM-temp_Neg;
mean(temp)
max(temp)
min(temp)
hold on;
pof=cdfplot(temp);
set(pof,'LineStyle','--','LineWidth',2,'Color','black');
set(gca,'YTick',(0:0.1:1));
set(gca,'Xlim',[0,100])
set(gca,'XTick',(0:10:100));
legend('OM','NBREG','PoF','Location','best');
xlabel('�������ƽ��ֵ / %','Fontname','����','FontSize',14);
ylabel('AS�Ե��ۻ��ֲ�','Fontname','����','FontSize',14);
outputname1='./916_two_direction/Total/weight_stat/MeanTotalGainWithoutRemoveZeroLTR.png';
outputname2='./916_two_direction/Total/weight_stat/MeanTotalGainWithoutRemoveZeroLTR.fig';
saveas(gcf,outputname1);
saveas(gcf,outputname2);
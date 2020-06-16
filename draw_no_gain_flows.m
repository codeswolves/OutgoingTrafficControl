%统计0收益流的百分比
namelist = dir('D:\MyPaper\2Outgoing\2Register\register\fourth experiment\5twoDirection\data_weight\916_two_direction_agg\');
len=length(namelist);
countsOM=[];
countsNeg=[];
for i = 1:len
      file_name = namelist(i).name;
      if  strcmp(file_name,'.') || strcmp(file_name,'..')
          continue
      end
      Data=[];
      %disp(file_name);
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
      countsOM = [countsOM,(length(find(OMGain==0))/length(OMGain))*100];
      countsNeg = [countsNeg,(length(find(NEGain==0))/length(NEGain))*100];
end
%figure('visible','off');
OM=cdfplot(countsOM);
hold on;
NG=cdfplot(countsNeg);
%set(gca,'Ylim',[0,100]);
set(gca,'YTick',[0:0.1:1]);
set(gca,'Xlim',[0,100])
set(gca,'XTick',(0:10:100));
set(OM,'LineStyle','-','LineWidth',2,'Color','r');
set(NG,'LineStyle',':','LineWidth',2,'Color','b');
legend('OM','NBREG','Location','best');
xlabel('无收益服务占总服务数的百分比 / %','Fontname','宋体','FontSize',14);
ylabel('AS对的累积分布','Fontname','宋体','FontSize',14);
outputname1='./916_two_direction/Total/weight_stat/percentage_of_zeroLTR.fig';
outputname2='./916_two_direction/Total/weight_stat/percentage_of_zeroLTR.png';
saveas(gcf,outputname1);
saveas(gcf,outputname2);

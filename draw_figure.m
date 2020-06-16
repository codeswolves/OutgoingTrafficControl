%画总收益
namelist = dir('D:\MyPaper\2Outgoing\2Register\register\Fourth experiment\5twoDirection\data_hopnumber\916_two_direction_agg\');
len=length(namelist);
for i = 1:len
      file_name = namelist(i).name;
      if  strcmp(file_name,'.') || strcmp(file_name,'..')
          continue
      end
      file_nameF=['./data_hopnumber/916_two_direction_agg/',file_name];
      Data=importdata(file_nameF);
      
      array = Data.data;
      figure('visible','off');
      %OMLeft= array(:,1);
      %SMLeft= array(:,2);
      %NELeft=array(:,3);
      %OMRight=array(:,4);
      %SMRight=array(:,5);
      %NERight=array(:,6);
      OMTotalLTR= array(:,7);
      SMTotalLTR= array(:,8);
      NETotalLTR= array(:,9); 
      OMGain=SMTotalLTR-OMTotalLTR;
      NEGain=SMTotalLTR-NETotalLTR;
      if OMGain <0
          disp(file_name);
      end
      %删除小于0的。
      for j=1:length(NEGain)
          if NEGain(j) < 0
              if OMGain(j) >=0
                  NEGain(j)=OMGain(j);
              else
                  NEGain(j)=0;
              end
          end
      end
      OMGainP= (OMGain./SMTotalLTR)*100;
      NEGainP=(NEGain./SMTotalLTR)*100;
      OM=cdfplot(OMGain);
      hold on;
      NG=cdfplot(NEGain);
      set(gca,'YTick',(0:0.1:1));
      set(OM,'LineStyle','-','LineWidth',2,'Color','r');
      set(NG,'LineStyle',':','LineWidth',2,'Color','b');
      legend('OM','NBREG','Location','best');
      ylabel('服务的累积分布 / %','Fontname','宋体','FontSize',14);
      xlabel('总收益 / 跳数','Fontname','宋体','FontSize',14);
      str= strsplit(file_name,'_');
      titlename=['自治系统',str{1},'-','自治系统',str{2}];
      title(titlename);
      outputname=[file_name,'.png'];
      saveas(gcf,['./Total/hopnumber/raw_gain/LTR/',outputname]);
end
close all;
fclose('all');
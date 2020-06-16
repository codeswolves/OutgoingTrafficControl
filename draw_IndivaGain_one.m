%画自自治系统对中，单个自治系统的收益
namelist = dir('D:\MyPaper\2Outgoing\2Register\register\Fourth experiment\5twoDirection\data_weight\916_two_direction_agg\');
len=length(namelist);
for i = 1:len
      file_name = namelist(i).name;
      if  strcmp(file_name,'.') || strcmp(file_name,'..')
          continue
      end
      file_nameF=['./data_weight/916_two_direction_agg/',file_name];
      data=importdata(file_nameF);
      array = data.data;
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
      %删除小于0的。
      for j=1:length(NEGain)
          if NEGain(j) < 0
              if OMGain(j) >=0
                  NEGain(j)=OMGain(j);
                  NEGainLeft(j)=OMGainLeft(j);
                  NEGainRight(j)=OMGainRight(j);
              else
                  NEGain(j)=0;
                  NEGainLeft=0;
                  NEGainRight=0;
              end
          end
      end
      %为了有可比性，一定要选一样的分母，或者进行归一化处理
      OMGainP=(OMGain./SMTotal)*100;
      NEGainP=(NEGain./SMTotal)*100;
      OMGainLeftP= (OMGainLeft./SMTotal)*100;
      NEGainLeftP=(NEGainLeft./SMTotal)*100;
      OMGainRightP= (OMGainRight./SMTotal)*100;
      NEGainRightP=(NEGainRight./SMTotal)*100;
      figure('visible','off');
      str= strsplit(file_name,'_');
      subplot(3,1,1);
      OM=cdfplot(OMGainP);
      hold on;
      NG=cdfplot(NEGainP);
      set(gca,'YTick',(0:0.2:1));
      set(gca,'XTick',(0:10:100));
      set(gca,'XLim',[0 100]);
      legend('OM','NBREG','Location','best');
      set(OM,'LineStyle','-','LineWidth',2,'Color','red');
      set(NG,'LineStyle',':','LineWidth',2,'Color','blue');
      set(gca,'Ylabel',[]);
      set(gca,'Xlabel',[]);
      titlename=['从AS-',str{2}, '向AS-',str{1},'注册'];
      title(titlename);
      subplot(3,1,2);
      OML=cdfplot(OMGainLeftP);
      hold on;
      NGL=cdfplot(NEGainLeftP);
      set(gca,'YTick',(0:0.2:1));
      set(gca,'XTick',(-100:10:0));
      set(gca,'XLim',[-100 0]);
      set(OML,'LineStyle','-','LineWidth',2,'Color','red');
      set(NGL,'LineStyle',':','LineWidth',2,'Color','blue');
      legend('OM','NBREG','Location','best');
      ylabel('服务的累积分布 / %','Fontname','宋体','FontSize',14);
      set(gca,'Xlabel',[]);
      titlename=['AS-',str{1}];
      title(titlename);
      subplot(3,1,3);
      OMR=cdfplot(OMGainRightP);
      hold on;
      NGR=cdfplot(NEGainRightP);
      set(gca,'YTick',(0:0.2:1));
      %'Marker','*','MarkerSize',5
      set(OMR,'LineStyle','-','LineWidth',2,'Color','red');
      set(NGR,'LineStyle',':','LineWidth',2,'Color','blue');
      set(gca,'XTick',(0:10:100));
      set(gca,'XLim',[0 100]);
      set(gca,'Ylabel',[]);
      xlabel('收益 / %','Fontname','宋体','FontSize',14);
      %leftnameO=['AS-',str{1},' OM'];
      %leftnameN=['AS-',str{1},' NBREG'];
      %rightnameO=['AS-',str{2},' OM'];
      %rightnameN=['AS-',str{2},' NBREG'];
      %legend(leftnameO,leftnameN,rightnameO,rightnameN,'Location','best');
      legend('OM','NBREG','Location','best');
      titlename=['AS-',str{2}];
      title(titlename);
      %outputname1=[file_name,'.fig'];
      outputname2=[file_name,'RTL.png'];
      saveas(gcf,['./916_two_direction/indiv/weight/4IN1/LTR/',outputname2]);
end
close all;
fclose('all');
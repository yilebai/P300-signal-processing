function [spelledword] = decode(file,startpoint,label,numtest,wordlength,in,indxs,coefficients,b0)
  donchin=[...
        'A' 'B' 'C' 'D' 'E' 'F';...
        'G' 'H' 'I' 'J' 'K' 'L';...
        'M' 'N' 'O' 'P' 'Q' 'R';...
        'S' 'T' 'U' 'V' 'W' 'X';...
        'Y' 'Z' '1' '2' '3' '4';...
        '5' '6' '7' '8' '9' '_'];

  colors=[...
        [1 1 0] 
        [0.8500 0.3250 0.0980]
        [0.9290 0.6940 0.1250] 
        [0.4940 0.1840 0.5560] 
        [0.4660 0.6740 0.1880] 
        [0.3010 0.7450 0.9330]];
    
  symbols=[...
        'o' 'o' 'o' 'o' 'o' 'o'...
        's' 's' 's' 's' 's' 's'];
  numtargets = 12;
  numchannels = 10;
  numseries = 15;
  epochsize = 0.8;%800ms
  samplefreq = 256;
  batchsize = round(epochsize * samplefreq);
  spelledword = [];
  figure('units','normalized','outerposition',[0 0 1 1],'color','w')

  for sequence=1:wordlength

    responses=zeros(batchsize,numchannels,numtargets,numseries);
    ntest = numtest/wordlength;
    
     for x = 1:numtest
      for i = 1:batchsize
         for j = 1:numchannels
          
          if(x <= sequence*ntest && x > (sequence-1)*ntest )
              series = ceil((x-(sequence-1)*ntest)/12);
              responses(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j); 
          end
          
         end
      end
     end
     
     responses=reshape(mean(responses,4),size(responses,1)*size(responses,2),numtargets);
     responses=responses(in~=0,:)';
     features=responses(:,indxs);
     
     [~,row]=max(sum(features(1:6,:).*repmat(coefficients',numtargets/2,1),2)+b0);
     subplot(2,wordlength,sequence)
     hold on
     for target=1:numtargets/2
         if target==row
           eval(strcat('r',num2str(target),'=plot(features(target,1),features(target,2),symbols(target),''color'',[0 0 0],''MarkerFaceColor'',colors(target,:),''MarkerSize'',10);'))
         else
           eval(strcat('r',num2str(target),'=plot(features(target,1),features(target,2),symbols(target),''color'',[1 1 1],''MarkerFaceColor'',colors(target,:),''MarkerSize'',10);'))
         end
     end
     x=linspace(min(features(:,1)),max(features(:,1)),1000);
     y=-x*(coefficients(1)/coefficients(2))-(b0/coefficients(2));
     plot(x,y,'k','linewidth',2)
     legend([r1 r2 r3 r4 r5 r6],{'row 1','row 2','row 3','row 4','row 5','row 6'},'fontsize',8,'fontweight','bold','location','bestoutside')
     legend boxoff
             
     [~,col]=max(sum(features(7:12,:).*repmat(coefficients',numtargets/2,1),2)+b0);
     subplot(2,wordlength,sequence+wordlength)
     hold on
     for target=numtargets/2+1:numtargets
         if target==col+6
             eval(strcat('c',num2str(target-6),'=plot(features(target,1),features(target,2),symbols(target),''color'',[0 0 0],''MarkerFaceColor'',colors(target-6,:),''MarkerSize'',10);'))
         else
             eval(strcat('c',num2str(target-6),'=plot(features(target,1),features(target,2),symbols(target),''color'',[1 1 1],''MarkerFaceColor'',colors(target-6,:),''MarkerSize'',10);'))
         end
     end
     x=linspace(min(features(:,1)),max(features(:,1)),1000);
     y=-x*(coefficients(1)/coefficients(2))-(b0/coefficients(2));
     plot(x,y,'k','linewidth',2)
     legend([c1 c2 c3 c4 c5 c6],{'col 1','col 2','col 3','col 4','col 5','col 6'},'fontsize',8,'fontweight','bold','location','bestoutside')
     legend boxoff
     spelledword= cat(2,spelledword,donchin(row,col))       
  end

end
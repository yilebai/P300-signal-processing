close all
clear
clc
    
numtargets = 12;
numchannels = 10;
numseries = 15;
epochsize = 0.8;%800ms
samplefreq = 256;
batchsize = round(epochsize * samplefreq);

[file1,startpoint1,label1,numtest1,wordlength1] = readFile('XCL11.mat');
[file2,startpoint2,label2,numtest2,wordlength2] = readFile('XCL12.mat');
[file3,startpoint3,label3,numtest3,wordlength3] = readFile('XCL13.mat');

%construct data array for training set
[infreq1,freq1] = construct(file1,startpoint1,label1,numtest1,wordlength1);
[infreq2,freq2] = construct(file2,startpoint2,label2,numtest2,wordlength2);
[infreq3,freq3] = construct(file3,startpoint3,label3,numtest3,wordlength3);

infreq = cat(3,infreq1,infreq2,infreq3);
freq = cat(3,freq1,freq2,freq3);
%mean calculation 205*10
infreq0 = mean(infreq,3);
freq0 = mean(freq,3);
figure
for i=1:numchannels
    subplot(5,2,i);
    x = 1:batchsize;
    plot(x,freq0(:,i));%channel i
    hold on,
    plot(x,infreq0(:,i),'red');
    xticks(0:205/8:205);
    xticklabels({ '0','100','200','300','400','500','600','700','800' });%ms
    xlabel('ms');
    ylabel('amplitude');
end


labels=[ones(size(infreq,3),1);-ones(size(freq,3),1)];%192*1
features=reshape(cat(3,infreq,freq),size(infreq,1)*size(infreq,2),length(labels))';
[coefficients,~,PVAL,in,stats]=stepwisefit(features,labels,'maxiter',6,'display','off','penter',0.1,'premove',0.15);
%coefficient estimate, STD, pvalue,in=finalmodel,stats=statistics
[~,indxs]=sort(PVAL(in~=0),'ascend');
coefficients=coefficients(in~=0);
coefficients=coefficients(indxs);
b0=stats.intercept;

features=features(:,in~=0);
features=features(:,indxs);

figure
hold on
plot(features(labels==-1,1),features(labels==-1,2),'o','MarkerEdgeColor',[1 1 1],'MarkerFaceColor','b')
plot(features(labels==1,1),features(labels==1,2),'o','MarkerEdgeColor',[1 1 1],'MarkerFaceColor','r')

%line plot
hold on,
x=linspace(min(features(:,1)),max(features(:,1)),1000);
y=-x*(coefficients(1)/coefficients(2))-(b0/coefficients(2));
plot(x,y,'k','LineWidth',1);
title('regression model based on training set')




%test set
[file4,startpoint4,label4,numtest4,wordlength4] = readFile('XCL31.mat');
[file5,startpoint5,label5,numtest5,wordlength5] = readFile('XCL32.mat');
[file6,startpoint6,label6,numtest6,wordlength6] = readFile('XCL33.mat');

[spelledword1] = decode(file1,startpoint1,label1,numtest1,wordlength1,in,indxs,coefficients,b0);
[spelledword2] = decode(file2,startpoint2,label2,numtest2,wordlength2,in,indxs,coefficients,b0);
[spelledword3] = decode(file3,startpoint3,label3,numtest3,wordlength3,in,indxs,coefficients,b0);
[spelledword4] = decode(file4,startpoint4,label4,numtest4,wordlength4,in,indxs,coefficients,b0);
[spelledword5] = decode(file5,startpoint5,label5,numtest5,wordlength5,in,indxs,coefficients,b0);
[spelledword6] = decode(file6,startpoint6,label6,numtest6,wordlength6,in,indxs,coefficients,b0);




















    


        




    

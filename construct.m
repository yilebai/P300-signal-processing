function [infreq,freq] = construct(file,startpoint,label,numtest,wordlength)

numtargets = 12;
numchannels = 10;
numseries = 15;
epochsize = 0.8;%800ms
samplefreq = 256;
batchsize = round(epochsize * samplefreq);

 if(wordlength == 5 )
    
    letter1 = zeros(batchsize, numchannels, numtargets,numseries);
    letter2 = zeros(batchsize, numchannels, numtargets,numseries);
    letter3 = zeros(batchsize, numchannels, numtargets,numseries);
    letter4 = zeros(batchsize, numchannels, numtargets,numseries);
    letter5 = zeros(batchsize, numchannels, numtargets,numseries);
    infreq = zeros(batchsize, numchannels, 2*wordlength);
    freq = zeros(batchsize, numchannels, 10*wordlength);
    ntest = numtest/wordlength;
    for x = 1:numtest
      for i = 1:batchsize
         for j = 1:numchannels
          
          if(x <= ntest )
              series = ceil(x/12);
              letter1(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j); 
          elseif(x <= 2*ntest)
              series = ceil((x-ntest)/12);
              letter2(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
          elseif(x <= 3*ntest)
              series = ceil((x-2*ntest)/12);
              letter3(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
          elseif(x <= 4*ntest)
              series = ceil((x-3*ntest)/12);
              letter4(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
          elseif(x <= 5*ntest)
              series = ceil((x-4*ntest)/12);
              letter5(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
          end;
                  
         end;
      end;
   end;
   %coherent average
   letter1 = mean(letter1,4);
   letter2 = mean(letter2,4);
   letter3 = mean(letter3,4);
   letter4 = mean(letter4,4);
   letter5 = mean(letter5,4);

  %construct infrequent responses
   if(label(1,1)==2)
     for i = 1:batchsize
       for j = 1:numchannels
            infreq(i,j,1) = letter1(i,j,1);
            letter1(1,1,1) = 0;
            infreq(i,j,2) = letter1(i,j,9);
            letter1(1,1,9) = 0;
            infreq(i,j,3) = letter2(i,j,1);
            letter2(1,1,1) = 0;
            infreq(i,j,4) = letter2(i,j,7);
            letter2(1,1,7) = 0;
            infreq(i,j,5) = letter3(i,j,2);
            letter3(1,1,2) = 0;
            infreq(i,j,6) = letter3(i,j,12);
            letter3(1,1,12) = 0;
            infreq(i,j,7) = letter4(i,j,3);
            letter4(1,1,3) = 0;
            infreq(i,j,8) = letter4(i,j,9);
            letter4(1,1,9) = 0;
            infreq(i,j,9) = letter5(i,j,3);
            letter5(1,1,3) = 0;
            infreq(i,j,10) = letter5(i,j,12);
            letter5(1,1,12) = 0;
      end;
  end;
 end;
 
   if(label(1,1)==5)
     for i = 1:batchsize
       for j = 1:numchannels
            infreq(i,j,1) = letter1(i,j,4);
            letter1(1,1,4) = 0;
            infreq(i,j,2) = letter1(i,j,7);
            letter1(1,1,7) = 0;
            infreq(i,j,3) = letter2(i,j,4);
            letter2(1,1,4) = 0;
            infreq(i,j,4) = letter2(i,j,9);
            letter2(1,1,9) = 0;
            infreq(i,j,5) = letter3(i,j,4);
            letter3(1,1,4) = 0;
            infreq(i,j,6) = letter3(i,j,7);
            letter3(1,1,7) = 0;
            infreq(i,j,7) = letter4(i,j,2);
            letter4(1,1,2) = 0;
            infreq(i,j,8) = letter4(i,j,8);
            letter4(1,1,8) = 0;
            infreq(i,j,9) = letter5(i,j,2);
            letter5(1,1,2) = 0;
            infreq(i,j,10) = letter5(i,j,9);
            letter5(1,1,9) = 0;
      end;
  end;
 end;
 
   %construct frequent responses 
   freq = cat(3,letter1,letter2,letter3,letter4,letter5);
   b=(freq~=0);
   freq=freq(:,:,find(sum(sum(b))==batchsize*numchannels));          
 
 end;


 if(wordlength == 6 )
    
    letter1 = zeros(batchsize, numchannels, numtargets,numseries);
    letter2 = zeros(batchsize, numchannels, numtargets,numseries);
    letter3 = zeros(batchsize, numchannels, numtargets,numseries);
    letter4 = zeros(batchsize, numchannels, numtargets,numseries);
    letter5 = zeros(batchsize, numchannels, numtargets,numseries);
    letter6 = zeros(batchsize, numchannels, numtargets,numseries);
    infreq = zeros(batchsize, numchannels, 2*wordlength);
    freq = zeros(batchsize, numchannels, 10*wordlength);
    ntest = numtest/wordlength;
    for x = 1:numtest
      for i = 1:batchsize
         for j = 1:numchannels
          
          if(x <= ntest )
              series = ceil(x/12);
              letter1(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j); 
          elseif(x <= 2*ntest)
              series = ceil((x-ntest)/12);
              letter2(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
          elseif(x <= 3*ntest)
              series = ceil((x-2*ntest)/12);
              letter3(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
          elseif(x <= 4*ntest)
              series = ceil((x-3*ntest)/12);
              letter4(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
          elseif(x <= 5*ntest)
              series = ceil((x-4*ntest)/12);
              letter5(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
           elseif(x <= 6*ntest)
              series = ceil((x-5*ntest)/12);
              letter6(i,j,label(x,1),series) = file.signal(startpoint(x,1)+i-1,j);
          end;
                  
         end;
      end;
   end;
   %coherent average
   letter1 = mean(letter1,4);
   letter2 = mean(letter2,4);
   letter3 = mean(letter3,4);
   letter4 = mean(letter4,4);
   letter5 = mean(letter5,4);
   letter6 = mean(letter6,4);
   
    %construct infrequent responses
   if(label(1,1)==10)
     for i = 1:batchsize
       for j = 1:numchannels
            infreq(i,j,1) = letter1(i,j,1);
            letter1(1,1,1) = 0;
            infreq(i,j,2) = letter1(i,j,9);
            letter1(1,1,9) = 0;
            infreq(i,j,3) = letter2(i,j,1);
            letter2(1,1,1) = 0;
            infreq(i,j,4) = letter2(i,j,7);
            letter2(1,1,7) = 0;
            infreq(i,j,5) = letter3(i,j,3);
            letter3(1,1,3) = 0;
            infreq(i,j,6) = letter3(i,j,12);
            letter3(1,1,12) = 0;
            infreq(i,j,7) = letter4(i,j,2);
            letter4(1,1,2) = 0;
            infreq(i,j,8) = letter4(i,j,9);
            letter4(1,1,9) = 0;
            infreq(i,j,9) = letter5(i,j,3);
            letter5(1,1,3) = 0;
            infreq(i,j,10) = letter5(i,j,8);
            letter5(1,1,8) = 0;
            infreq(i,j,11) = letter6(i,j,3);
            letter6(1,1,3) = 0;
            infreq(i,j,12) = letter6(i,j,9);
            letter6(1,1,9) = 0;
        end;
     end;
   end;
   
   %construct frequent responses 
   freq = cat(3,letter1,letter2,letter3,letter4,letter5,letter6);
   b=(freq~=0);
   freq=freq(:,:,find(sum(sum(b))==batchsize*numchannels));

  end;


end
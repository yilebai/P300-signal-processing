function [file,startpoint,label,numtest,wordlength] = readFile(x)
    file = importdata(x);
    file.signal = double(file.signal);
    samples = size(file.signal,1);
    counter = 0;
    
    % counting number of stimulus according to StimulusBegin
    for i = 1:samples
      if (file.states.StimulusBegin(i) == 1)
         counter = counter + 1;
      end;
    end;
    numtest = counter/8;
    wordlength = numtest/(12*15);

    % get starting point and label of each stimulus
    startpoint = zeros(numtest,1);
    label = zeros(numtest,1);
    j = 1;
    for i = 2:samples
       if(file.states.StimulusBegin(i)==1 && file.states.StimulusBegin(i-1)==0)
          startpoint(j) = i;
          label(j) = file.states.StimulusCode(i);
          j = j+1;
       end;
    end;

    
end
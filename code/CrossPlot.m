clear all
%num = [20 18 16 10 2];
num = [20];
N = 100;
S3 = zeros(length(num),N);
for countIter =1:length(num)
    l = 1;
    while l<N+1
        gaRouteCreate1        
%        gaRouteCreate
        Figure7_SEQ_SEL
%         Figure7_SEQ_SEL_CutVertex
%         Figure7_RAND_SEL_CutVertex
        gaRoutePostPro
        if ~isempty(S)
            indTime = size(S);
            S3(countIter,l) = S(1,indTime(2));
            display([' ',num2str(S3(countIter,l)),' num of cross ',num2str(num(countIter)),' iteration ' ,num2str(l)])
            l = l+1;
        end
    clearvars -except S S3 num countIter l N indTime
    end
end
S3t = S3';
S3tavg = mean(S3t,1);
%S3toWrite = [0 0 0 0 0;S3t;S3tavg];
S3toWrite = [0;S3t;S3tavg];
csvwrite('SeqCrossOverAverages100.csv',S3toWrite);

clear all
%num = [20 18 16 10 2];
num = [20];
N = 100;
S3 = zeros(length(num),N);
for countIter =1:length(num)
    l = 1;
    while l<N+1
        gaRouteCreate1
%         Figure7_SEQ_SEL
        Figure7_SEQ_SEL_CutVertex
%         Figure7_RAND_SEL_CutVertex
        gaRoutePostPro
        if ~isempty(S)
            indTime = size(S);
            S3(countIter,l) = S(1,indTime(2));
            display([' ',num2str(S3(countIter,l)),' num of cross ',num2str(num(countIter)),' iteration ' ,num2str(l)])
            l = l+1;
        end
    clearvars -except S S3 num countIter l N indTime
    end
end
S3t = S3';
S3tavg = mean(S3t,1);
%S3toWrite = [0 0 0 0 0;S3t;S3tavg];
S3toWrite = [0;S3t;S3tavg];
csvwrite('SeqCutCrossOverAverages100.csv',S3toWrite);

clear all
%num = [20 18 16 10 2];
num = [20];
N = 100;
S3 = zeros(length(num),N);
for countIter =1:length(num)
    l = 1;
    while l<N+1
        gaRouteCreate1
%         Figure7_SEQ_SEL
%         Figure7_SEQ_SEL_CutVertex
        Figure7_RAND_SEL_CutVertex
        gaRoutePostPro
        if ~isempty(S)
            indTime = size(S);
            S3(countIter,l) = S(1,indTime(2));
            display([' ',num2str(S3(countIter,l)),' num of cross ',num2str(num(countIter)),' iteration ' ,num2str(l)])
            l = l+1;
        end
    clearvars -except S S3 num countIter l N indTime
    end
end
S3t = S3';
S3tavg = mean(S3t,1);
%S3toWrite = [0 0 0 0 0;S3t;S3tavg];
S3toWrite = [0;S3t;S3tavg];
csvwrite('RanCutCrossOverAverages100.csv',S3toWrite);
clear all
num = [20 18 16 4 2];
N = 100;
S3 = zeros(length(num),N);
for countIter =1:length(num)
    l = 1;
    while l<N+1
        gaRouteCreate1
        Figure8RANDSELCutVertex
        gaRoutePostPro
        if ~isempty(S)
            indTime = size(S);
            S3(countIter,l) = S(1,indTime(2));
            display([' ',num2str(S3(countIter,l)),' num of cross ',num2str(num(countIter)),' iteration ' ,num2str(l)])
            l = l+1;
        end
    clearvars -except S S3 num countIter l N
    end
end
S3t = S3';
S3tavg = mean(S3t,1);
S3toWrite = [20 18 16 4 2;S3t;S3tavg];
csvwrite('Fig8MutationAverages100.csv',S3toWrite);


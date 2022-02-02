%this M file try to discover new routes using GA with crossover strategey RAND SEL with CutVertex CO
t1=tic;
source=40;
dest=13;
limit=1;
max_limit=500;
while limit <= max_limit
t2=tic;

%Calculate Fitness for Population Matrix Fitness Function
fit=zeros(1,P_r);
for r=1:P_r
    for i=2:P_c
        if (P(r,i)==-1)         %reach end of the chromosome
            break;
        elseif ((G(P(r,i-1),P(r,i)))==0)||((any(P(r,:)==source))==0)||((any(P(r,:)==dest))==0)  %if chromosome isn't valid or doesn't contain source or destenation
            fit(r)=inf;
            break;
        elseif (P(r,i)==dest)         %destenation found no need to continue
            fit(r)=fit(r)+G(P(r,i-1),P(r,i));
            P(r,i+1:P_c)=-1;
            break;
        else
            fit(r)=fit(r)+G(P(r,i-1),P(r,i));
        end
    end
end

P1 =[P fit'];                            %concatenate P and fit
P2=sortrows(P1,P_c+1);         %sort whole row by row according to fittness


%Find Crossover
% CO=P_sort;
rate1=ceil(P_r/2);      %finding the mid of P rows
rate2=ceil(P_c/2);      %finding the mid of P columns
CO = P2(:,1:P_c);       %copy population to crossover matrix
% CH=zeros(P_r,P_c);      %initiate children matrix

%find crossover if there is common node
for r = 1:2:num(countIter)
    random2 = ceil((size(CO,1)-1) * rand(1));       %choose random row and the row after it (-1 to avoid be in last row)
    parent1   = CO(random2,:);
    parent2   = CO(random2+1,:);
    random3 = ceil(rate2 * rand(1));                %choose random column from first half of chromosome
    cv1=-1;
    cv2=-1;
    for i = random3:P_c                             %those two loops look for cut vertices in the parents from random start point
        for k = random3:P_c
            if (parent1(i)==parent2(k))
                cv1=i;
                cv2=k;
                break;
            end
        end
        if (cv1~=-1) && (cv2~=-1)
            break;
        end
    end
    
    if (cv1~=-1) && (cv2~=-1)                      %if there are cut vertices make them crossover points
                child1    = [parent1(1:i),parent2(k+1:P_c)];
                child2    = [parent2(1:k),parent1(i+1:P_c)];
    else                                           %in case if there aren't any cut vertices just crossover from the half
                child1    = [parent1(1:rate2),parent2(rate2+1:P_c)];
                child2    = [parent2(1:rate2),parent1(rate2+1:P_c)];
    end
       
    if ((size(child1,2))<P_c)                       %those loops fill the gaps and put the chromosomes in a proper shape
        while((size(child1,2))<P_c)
            child1(1,(size(child1,2)+1))=-1;
        end
    elseif ((size(child2,2))<P_c)
        while((size(child2,2))<P_c)
            child2(1,(size(child2,2)+1))=-1;
        end
    end
    CH(r,:)   = child1(:,1:P_c);
    CH(r+1,:) = child2(:,1:P_c);
end
CO1=CH;


%Find Mutation for child matrix
for r = 1:size(CH,1)
    random4 = CH(r,:);                                                      %choose random column from first half of chromosome
    random4=random4(random4~=-1);                                           %clear vector from -1 values
    random4=random4(random4~=dest);                                         %don't mutate destenation node
    if (size(random4,2)==P_c)                                               %chromosome with length equal to all nodes in infrastructure
        random4(P_c)=[];
    end
    random5 = [random4;1:size(random4,2)];                                  %choose random column from first half of chromosome
    random5 = random5(:,randperm(size(random5,2)));                         %shuffle the matrix
    for i = 1:size(random5,2)
        link=find(G(random5(1,i),:));
        random6=link(randperm(length(link)));                           %shuffle the connections of the node
        while ((any(CH(r,:)==random6(1)))==1) %|| (random6(1)==dest)
            random6(1)=[];
            if ((isempty(random6))==1)
                break;
            end
        end
                if ((isempty(random6))==1)
                    break;
               end
        k = random5(2,i)+1;        
        CH(r,k)=random6(1);
        break;
        %end
    end
end


%Calculate Fitness for Child Matrix Fitness Function
chfit=zeros(1,size(CH,1));
for r=1:size(CH,1)
    for i=2:size(CH,2)
        if (CH(r,i)==-1)
            break;
        elseif ((G(CH(r,i-1),CH(r,i)))==0) || ((any(CH(r,:)==source))==0) || ((any(CH(r,:)==dest))==0)
            chfit(r)=inf;
            break;
        elseif (CH(r,i)==dest)         %destenation found no need to continue
            chfit(r)=chfit(r)+G(CH(r,i-1),CH(r,i));
            CH(r,i+1:P_c)=-1;
            break;
        else
            chfit(r)=chfit(r)+G(CH(r,i-1),CH(r,i));
        end
    end
end

CH1 =[CH chfit'];
CH2=sortrows(CH1,P_c+1);         %sort whole row by row according to fittness

A=[P2; CH2];
A1=sortrows(A,P_c+1);
A2 = A1(randperm(size(A1,1)),:);
P=A2(1:P_r,1:P_c);

T1(1:size(A1,1))=toc(t1);
Timed_A1=[A1 T1'];
if (limit==1)                   %solution matrix to store P_r solutions per generation
    S2=Timed_A1(1:P_r,:);
else
    S2=[S2; Timed_A1(1:P_r,:)];
end

toc_t2=toc(t2);
T2(limit)=toc_t2;
limit=limit+1;
end
S1=unique(S2,'rows');
S=sortrows(S1,P_c+1);
S(any(isinf(S')),:)=[];

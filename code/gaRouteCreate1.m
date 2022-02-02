%this M file creates the intial topology of network and initial population for GA

t = clock;                %time counter
G=csvread('topo.csv');


G_size = size(G);         %size of Main graph
G_r = G_size(1);          %number of rows in Main graph
G_c = G_size(2);          %number of columns in Main graph

%P=ceil(128 * rand(20,100));
%P(:,101:128)=-1;
%csvwrite('Initial Population 128.csv',P);
% P=ceil(256 * rand(50,200));
% P(:,201:256)=-1;
% csvwrite('Initial Population 256.csv',P);

P = csvread('paths_40to13.csv');                %Population Matrix
for count_plus1=1:size(P,1)
    for count_plus2=1:size(P,2)
        if (P(count_plus1,count_plus2)~=-1)
            P(count_plus1,count_plus2)=P(count_plus1,count_plus2)+1;
        end
    end
end
P_size = size(P);         %size of Population matrix
P_r = P_size(1);          %number of rows in Population matrix
P_c = P_size(2);          %number of columns in Population matrix
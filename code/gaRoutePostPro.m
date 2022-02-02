for count_plus1=1:size(S,1)
    for count_plus2=1:(size(S,2)-2)
        if (S(count_plus1,count_plus2)~=-1)
            S(count_plus1,count_plus2)=S(count_plus1,count_plus2)-1;
        end
    end
end
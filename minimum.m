function [minx, miny, indexMin] = minimum(list, n)

minx = 1;
miny = 1;
indexMin = 0;

for i = 1:n
    if (list(2,i) < miny)
        minx = list(1,i);
        miny = list(2,i);
        indexMin = i;

    elseif (list(2,i) == miny)
        if (list(1,i) < minx)
            minx = list(1,i);
            indexMin = i;
        end
    end
end

function [index, listFIFO] = FIFO(listFIFO,index, number, method)

switch method
    case "append"
        listFIFO(index + 1) = number;
        index = index + 1;

    case "pop"
        listFIFO(index) = 0;
        index = index - 1;
    otherwise
end

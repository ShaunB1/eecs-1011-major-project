function [threshValue] = threshold(value, size)
threshValue = value;
threshValue(value <= size) = 0;
threshValue(value > size) = 1;
end
function [r] = AbsDiff(f1, f2)
    diffArray = imabsdiff(f1, f2);
    r = sum(diffArray(:));
end
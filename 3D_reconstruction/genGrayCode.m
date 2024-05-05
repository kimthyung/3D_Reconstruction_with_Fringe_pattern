function [data] = genGrayCode(NBits)
data = zeros([2^NBits, NBits]);

for i = 1 : NBits
    if (i == 1)
        data(1, i) = 0;
        data(2, i) = 1;
    else
        data(1:2^(i-1), i) = 0; % set extra bit as 0
        data(2^(i-1)+1:2^i, 1:i-1) = data(2^(i-1):-1:1, 1:i-1); % flip data for all previous bits
        data(2^(i-1)+1:2^i, i) = 1; % set extra bit of the flipped data as 1
    end
end
end


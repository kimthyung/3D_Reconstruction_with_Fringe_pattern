function codeLUT = genInverseGrayCodeLUT (NBits)
    gCode = genGrayCode(NBits);
    codeLUT = zeros([2^NBits, 1]);
    
    for K = 1: 2^NBits
        code = 0;
        for N = 1 : NBits
            code = code * 2 + gCode(K, N);
        end
        codeLUT(code+1) = K;
    end

end
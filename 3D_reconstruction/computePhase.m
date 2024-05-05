function [phase, mask, texture,Iavg] = computePhase(path,imageHeight,imageWidth,NStep,gammaTh)
    I = zeros(imageHeight,imageWidth,NStep);
    Iavg = 0;
    for i = 1:NStep
        IPath =sprintf("%s%02d.bmp",path, i-1);
        I(:,:,i) = imread(IPath);
        Iavg = Iavg+ double(I(:,:,i))/NStep;
    end
    I1 = I(:, :, 1);
    
    S = zeros(size(I1));
    C = zeros(size(I1));
    Ip = zeros(size(I1));
    
    for i = 1: NStep
        I1 = I(:, :, i);
        S = S + I1 * sin(2*pi/(NStep) * (i-1));
        C = C + I1 * cos(2*pi/(NStep) * (i-1));
        Ip= Ip + I1/NStep; 
    end
    
    GF = fspecial('Gaussian', [5, 5], 3);
    S = imfilter(S, GF, 'same');
    C = imfilter(C, GF, 'same');
    
    Idp = 2 * sqrt(C.^2 + S.^2)/NStep; 
    phase = -atan2(S, C);
    mask = ones(size(I1))*255;
    gm = Idp./Ip;
    
    mask (gm < gammaTh) = 0;
    mask(isnan(gm)) = 0;
    mask(isinf(gm)) = 0;
    texture = uint8(Idp + Ip);
end
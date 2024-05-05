function unwrPhase = unwrapPhase(phase,path,Iavg,imageHeight,imageWidth,NStep,NBit,filtSize,suph,visualizePhase,visualizeUnwrapPhase,visualizeCodeword)
    %mannualProjectorCompansation only required for son's experiment
    bcode = zeros(imageHeight,imageWidth);
    
    fringePitch = 18;
    shift = -pi + pi/fringePitch;
    phase = atan2(sin(phase  + shift), cos(phase + shift));
    for i = 1:NBit
        Icode = zeros(imageHeight,imageWidth);
        IcodePath = sprintf("%s%02d.bmp",path,i+NStep-1);
        I0 = imread(IcodePath);
        Icode(I0>Iavg) = 1;
        bcode = bcode*2 + Icode;
    end

    codeLUT = genInverseGrayCodeLUT(NBit);
    [imageHeight, imageWidth] = size (bcode);
    codeWord = bcode;

    for i = 1:imageHeight
        for j = 1:imageWidth
            codeWord(i,j) = codeLUT(bcode(i,j)+1);
        end
    end
    
    unwrPhase = phase +codeWord*2*pi;
    if suph ==1
        suph = medfilt2(unwrPhase, [15 3]);
        delta = round((suph-unwrPhase)/(2*pi));
        
        codeWord = codeWord+delta;
        unwrPhase = phase+codeWord*2*pi;
    end
    if filtSize
        unwrPhase = medfilt2(unwrPhase,filtSize);
    end
    if visualizePhase || visualizeUnwrapPhase || visualizeCodeword
        figure, hold on
        if visualizePhase
            plot(phase(:,600),1:imageHeight);
        end
        if visualizeUnwrapPhase
            plot(unwrPhase(:,600),1:imageHeight);
        end
        if visualizeCodeword
            plot(codeWord(:,600),1:imageHeight);
        end
    end


end
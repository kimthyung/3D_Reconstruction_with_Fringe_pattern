function unwrPhase = unwrapPhase(phase,path,Iavg,imageHeight,imageWidth,NStep,NBit,filtSize,suph,visualizePhase,visualizeUnwrapPhase,visualizeCodeword)
    %mannualProjectorCompansation only required for son's experiment
    bcode = zeros(imageHeight,imageWidth);
    
    % fringePitch = 114; %18
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




    % 추가한 코드
    % unwrPhase = unwrPhase - shift; 
    % unwrPhase = unwrPhase*(204.902-7.15585)/(69.115-6.33754);
    % 
    % unwrPhase = unwrPhase-(19.963-7.15585);

    x__ = 1:1:1936;
    plot(x__, phase(1,:));
    hold on;
    plot(x__, unwrPhase(1,:));
    plot(x__, codeWord(1,:))






   
    if suph ==1
        suph = medfilt2(unwrPhase, [15 3]);
        delta = round((suph-unwrPhase)/(2*pi));
        
        codeWord = codeWord+delta;
        unwrPhase = phase+codeWord*2*pi;

        unwrPhase = unwrPhase - shift; 
        unwrPhase = unwrPhase*(324.282-7.15585)/(54.9753-4.77006);
        unwrPhase = unwrPhase-(29.963-7.15585+0.3);
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
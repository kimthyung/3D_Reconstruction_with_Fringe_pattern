function stereoParams = loadStereoCalibrationParams(calibFolder,imageHeight,imageWidth)


imageSize = size(zeros(imageHeight,imageWidth));


file_txtA = sprintf('%s/CamIntrinsicMatrixLeft.txt', calibFolder);
Af0 = textread(file_txtA);
Ac_l = Af0(1:3, 1:3);

file_txtB = sprintf('%s/CamIntrinsicMatrixRight.txt', calibFolder);
Bf0 = textread(file_txtB);
Ac_r = Bf0(1:3, 1:3);

file_txtC = sprintf('%s/CamRotationMatrixRight.txt', calibFolder);
Cf0 = textread(file_txtC);
Rc_r = Cf0(1:3, 1:3);

file_txtD = sprintf('%s/CamTranslationVectorRight.txt', calibFolder);
Df0 = textread(file_txtD);
Tc_r = Df0(:, 1);

file_txtE = sprintf('%s/CamDistortionCoefficientsLeft.txt', calibFolder);
Ef0 = textread(file_txtE);
Dc_l = Ef0(:, 1);

file_txtF = sprintf('%s/CamDistortionCoefficientsRight.txt', calibFolder);
Ff0 = textread(file_txtF);

Dc_r = Ff0(:, 1);


stereoParams = stereoParametersFromOpenCV(Ac_l,Dc_l,Ac_r,Dc_r,Rc_r,Tc_r,imageSize);
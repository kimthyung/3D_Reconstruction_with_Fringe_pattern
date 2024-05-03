% Configuration file
Projector.Type = 'DLP' %'Mannual'
Camera.Channel = 'Mono' % 'RGB'
Calibration.Type = 'OpenCV' %'MATLAB''OpenCV'


% Path.Data = './data06';
Path.CalibrationParameters = './CalibrationDataZeroDistortion';





% General settings
NStep = 3; %3
NBit = 4;  %5
fringePitch = 228;   %114
mannualProjectorCompansation = 0;

% Database settings
Image.Width = 1936; %1600;
Image.Height = 1464; %1200;
Fringe.Height = 1140;
Fringe.Width = 912;

Image.Extension = 'bmp';




Visualize.Phase = true;
Visualize.UnwrapPhase = false;
Visualize.Codeword = false;
Visualize.All3D = true;
Visualize.Crop3D = true;
Visualize.Fitting = true;
Visualize.IdealPlane = false;
Visualize.OffsetErrorMap = false;




Filter.Erosion = 1;
Filter.Erosion2 = 50;
Filter.Gauss = fspecial('Gaussian', [5, 5], 3);
Filter.Median = [3 3];


Features.suph = true;
Features.PhaseFitting = false;
Features.ImageWrite = true;
Features.IdealPlane = true;


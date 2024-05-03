clear all
close all

config

folderPath = "./hori_test/";


[phase, gammaMaskHigh, texture,Iavg] = computePhase(folderPath,Image.Height,Image.Width,NStep,0.2);
unwrPhase = unwrapPhase(phase,folderPath,Iavg,Image.Height,Image.Width,NStep,NBit,Filter.Median,Features.suph,Visualize.Phase,Visualize.UnwrapPhase,Visualize.Codeword);

[x,y,z] = phase2Coord_horizontal(unwrPhase, Fringe.Height, fringePitch, Path.CalibrationParameters);
z(z>400) = NaN;
z(z<200) = NaN;
y(y<-200) = NaN;
y(y>200) = NaN;
x(x>200) = NaN;
x(x<-200) = NaN;


se = strel('disk',5);
x = imerode(x, se);
y = imerode(y, se);
z = imerode(z, se);



figure('color','white','Name',folderPath);
s = surf(x,y,z, 'FaceColor', 'interp',...
    'EdgeColor', 'none',...
    'FaceLighting', 'phong');

hold on
set(gca, 'DataAspectRatio', [4, 4, 1], 'FontSize', 20)
set(gca, 'xdir', 'reverse')
set(gca, 'zdir', 'reverse')
grid on %grid odd
view(-180, 90);
camlight left
colormap('jet');
axis on
clim([50 300])
zlim([50 300])

xlabel('x (mm)','FontSize',20);
ylabel('y (mm)','FontSize',20);
zlabel('z (mm)','FontSize',20);




clear all
close all

config

folderPath = "./data00/p04/";


[phase, gammaMaskHigh, texture,Iavg] = computePhase(folderPath,Image.Height,Image.Width,NStep,0.2);
unwrPhase = unwrapPhase(phase,folderPath,Iavg,Image.Height,Image.Width,NStep,NBit,Filter.Median,Features.suph,Visualize.Phase,Visualize.UnwrapPhase,Visualize.Codeword);

[x,y,z] = phase2Coord_horizontal(unwrPhase, Fringe.Height, fringePitch, Path.CalibrationParameters);

if y>20 
    if z > 338
        z = NaN;
    end
end

z(z>340) = NaN;  %350
z(z<324) = NaN;  %300
y(y<-120) = NaN; %-300
y(y>100) = NaN;  %100
x(x>150) = NaN;  %150
x(x<-130) = NaN; %-150




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
grid on
view(-180, 90);
camlight left
colormap('jet');
% axis off
clim([300 350])
zlim([300 350])

xlabel('x (mm)','FontSize',20);
ylabel('y (mm)','FontSize',20);
zlabel('z (mm)','FontSize',20);




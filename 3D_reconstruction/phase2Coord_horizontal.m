function [x, y, z] = phase2Coord(unwrapPhase, projectorHeight, fringePitch,calibFolder)

file_txtA = sprintf('%s/CamIntrinsicMatrixRight.txt', calibFolder);
Af0 = textread(file_txtA);
Ac = Af0(1:3, 1:3);

file_txtB = sprintf('%s/ProjIntrinsicMatrix.txt', calibFolder);
Bf0 = textread(file_txtB);
Ap = Bf0(1:3, 1:3);

file_txtC = sprintf('%s/ProjRotationMatrix.txt', calibFolder);
Cf0 = textread(file_txtC);
Rp = Cf0(1:3, 1:3);

file_txtD = sprintf('%s/ProjTranslationVector.txt', calibFolder);
Df0 = textread(file_txtD);
Tp = Df0(:, 1);

file_txtE = sprintf('%s/CamDistortionCoefficientsRight.txt', calibFolder);
Ef0 = textread(file_txtE);
Dc = Ef0(:, 1);

Rc = [  1.000000	0.000000	0.000000
    0.000000	1.000000	0.000000
    0.000000	0.000000	1.000000];
Tc = [  0.000000
    0.000000
    0.000000];
    
Pc = Ac * [Rc, Tc];
Pp = Ap * [Rp, Tp];

[h, w] = size(unwrapPhase);
x = zeros([h, w]);
y = zeros([h, w]);
z = zeros([h, w]);

temp = zeros([1 1]);
for uc = 1 : w
    for vc = 1 : h
   
             
        vp = unwrapPhase(vc, uc) *fringePitch/(2*pi);
        A = [Pc(1, 1) - uc * Pc(3, 1), Pc(1, 2) - uc * Pc(3, 2), Pc(1, 3) - uc * Pc(3, 3)
             Pc(2, 1) - vc * Pc(3, 1), Pc(2, 2) - vc * Pc(3, 2), Pc(2, 3) - vc * Pc(3, 3)
             Pp(2, 1) - vp * Pp(3, 1), Pp(2, 2) - vp * Pp(3, 2), Pp(2, 3) - vp* Pp(3, 3)];
  
        
        b = [ uc * Pc(3, 4) - Pc(1, 4)
              vc * Pc(3, 4) - Pc(2, 4)
              vp * Pp(3, 4) - Pp(2, 4)];
%        
      

        A = A / 10000;
        b = b / 10000;

        XX = A\b;

        x(vc,uc) = XX(1);
        y(vc,uc) = XX(2);
        z(vc,uc) = XX(3);
            
    end
end

end


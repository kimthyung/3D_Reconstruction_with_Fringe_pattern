% 이미지 크기(pixel), pattern반복 수 설정
width = 912;
height = 1140;
stripe_num = 8;

% pixel size 그리드 형성, 앞서 정한 pattern반복 수를 구현할 frequency 구현
[X, Y] = meshgrid(1:width, 1:height);
frequency = stripe_num * (1 / 912);

% intensity 최대, 최소 값 (일단, 0-255로 두었다)
min_value = 0;
max_value = 255;

% normalizing (pattern은 -1, 1의 범위를 갖는 sin함수 결과 값이다. 이걸 0-255까지 바꿔야함)
normalize = @(pattern) (pattern - min(pattern(:))) / (max(pattern(:)) - min(pattern(:))) * (max_value - min_value) + min_value;

% Phase shifting(2*pi/3씩), orginal fringe를 0으로 시작하게 하려고 -pi/2 하였다. 
phase_shifts = [0, 2*pi/3, 4*pi/3];

% 이미지를 표시하고 파일로 저장
figure;

% Cell array to store normalized fringe patterns
fringe_patterns_normalized = cell(1, length(phase_shifts));

for i = 1:length(phase_shifts)
    % Fringe pattern 생성
    phase_shift = phase_shifts(i);
    fringe_pattern = sin(2 * pi * frequency * X + phase_shift);

    % normalizing
    fringe_pattern_normalized = normalize(fringe_pattern);
    
    % Store the normalized fringe pattern in the cell array
    fringe_patterns_normalized{i} = fringe_pattern_normalized;
    
    % subplot 및 이미지 표시, bmp로 저장
    subplot(1, length(phase_shifts), i);
    imshow(fringe_pattern_normalized, [min_value, max_value]);
    title(['Phase Shift: ' num2str(phase_shift)]);
    filename = ['fringe_pattern_shifted_normalized_' num2str(i) '.bmp'];
    imwrite(uint8(fringe_pattern_normalized), filename);
end
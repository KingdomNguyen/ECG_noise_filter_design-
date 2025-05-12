function [max_diff, filtered_signal] = test_derivative_filter()
% TEST_DERIVATIVE_FILTER Testbench đơn giản cho bộ lọc đạo hàm
% Đầu ra:
%   max_diff - Độ lệch lớn nhất giữa implementation và MATLAB filter()
%   filtered_signal - Tín hiệu đã lọc

% Load dữ liệu ECG
load 'D:\SampleECG.txt';  
ECGVoltage = SampleECG(1:2000,2);   % Lấy cột điện áp

% Khởi tạo
N = length(ECGVoltage);
filtered_signal = zeros(size(ECGVoltage));

% Xử lý từng mẫu qua bộ lọc
for n = 1:N
    filtered_signal(n) = derivative_filter_algorithm(ECGVoltage(n));
end

% Tính toán kết quả chuẩn dùng hàm filter() của MATLAB
DFa = [1, -0.995];
DFb = [0.9975, -0.9975];
matlab_filtered = filter(DFb, DFa, ECGVoltage);

% Tính độ lệch lớn nhất
max_diff = max(abs(filtered_signal - matlab_filtered));

% Hiển thị kết quả kiểm tra
fprintf('Kết quả kiểm tra bộ lọc đạo hàm:\n');
fprintf('Độ lệch lớn nhất so với MATLAB filter(): %e\n', max_diff);

if max_diff < 1e-10
    fprintf('==> Implementation CHÍNH XÁC\n');
else
    fprintf('==> Implementation CÓ SAI SỐ\n');
end
end
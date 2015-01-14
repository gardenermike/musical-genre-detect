%pkg install general -forge
%pkg install control -forge
%pkg install signal -forge

pkg load signal

[y, Fs, bits] = wavread('Pale_Moon.wav');

million = decimate(y, round(length(y) / 1000000));
cos_transform = dct(million);
half = cos_transform(1:500000);
normalized = (half + (-min(half))) / (range(half) / 2) - 1;

% normalized will now contain suitable inputs
t = transpose(normalized);
%write the one row to the file
save -append -ascii example.txt t

%to read out file
%fid = fopen("example.txt");
%line = fgetl(fid);
%x = strread(line);
%now the row is in x



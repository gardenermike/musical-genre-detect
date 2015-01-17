pkg load signal;

arg_list = argv();
wav_file = arg_list{1};

[y, Fs, bits] = wavread(wav_file);

million = decimate(y, round(length(y) / 1000000));
cos_transform = dct(million);
half = cos_transform(1:500000);
normalized = (half + (-min(half))) / (range(half) / 2) - 1;

load('thetas.txt')

pred = predict(Theta1, Theta2, normalized);


printf('%d\n', pred);

pkg load signal;

arg_list = argv();
wav_file = arg_list{1};
genre_id = arg_list{2};
printf('file is %s and genre is %s\n', wav_file, genre_id);
%printf('type: %s\n', typeinfo(genre_id));

[y, Fs, bits] = wavread(wav_file);

million = decimate(y, round(length(y) / 1000000));
cos_transform = dct(million);
half = cos_transform(1:500000);
normalized = (half + (-min(half))) / (range(half) / 2) - 1;

% normalized will now contain suitable inputs
%fid = fopen('X.txt', 'a');
%stringified = mat2str(normalized);
%without_left_bracket = substr(stringified, 2);
%without_right_bracket = substr(without_left_bracket, 1, strchr(without_left_bracket, ']')(1))
%fputs(fid, without_right_bracket);
%fputs(fid, normalized);
%fputs(fid, "\n");
%fclose(fid);

%write the one row to the file
%t = transpose(normalized);
save -text -append -ascii X.txt normalized;
%csvwrite ('X.txt', normalized, "append", "on", "delimiter", ",");
%x_fid = fopen('X.txt', 'a');
%fputs(x_fid, "\n");
%fclose(x_fid);

fid = fopen('y.txt', 'a');
fputs(fid, genre_id);
fputs(fid, "\n");
fclose(fid);
%save -append -ascii y.txt genre_id

%to read out file
%fid = fopen("example.txt");
%line = fgetl(fid);
%x = strread(line);
%now the row is in x



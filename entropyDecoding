function dtext = entropyDecoding(binPath)
fileID = fopen(binPath);
lengthtext =  fread(fileID,1,'uint32');
lengthtable = fread(fileID,1,'uint16');
feqC =  fread(fileID,lengthtable,'uint8');
offset =fread(fileID,1,'int32');
bin =  fread(fileID,'ubit1');
fclose(fileID);
% Entropy decoding
feq = double(feqC(feqC~=0));
dtext = arithdeco(bin,feq,lengthtext);
feqT = find(feqC);
dtext = feqT(dtext)+offset;

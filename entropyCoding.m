% entropy coding
function binsize = entropyCoding(text,binPath)
% disp('entropyCoding...')
offset = min(text)-1;
text = text - offset;
feq=tabulate(text);
feqInt = zeros(1,max(text));
maxcount = max(feq(:,2));
for i=1:size(feq,1)
    feqInt(feq(i,1)) = max( uint8((feq(i,2)./ maxcount)*255) ,1);
end
counts = double(feqInt);
counts(counts==0) = [];
temp = nan(size(text));
for i=1:size(feq,1)
  temp(text==feq(i,1))=i;
end
text = temp;
bin = arithenco(text,counts);
lenthtext= uint32(length(text));
fileID = fopen(binPath,'w');
fwrite(fileID,lenthtext,'uint32');
fwrite(fileID,length(feqInt),'uint16');
fwrite(fileID,uint8(feqInt),'uint8');
fwrite(fileID,offset,'int32');
fwrite(fileID,bin,'ubit1');
fclose(fileID);
binsize = dir(binPath); 
binsize = binsize.bytes;
end

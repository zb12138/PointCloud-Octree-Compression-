% entropy coding
function binsize = entropyCoding(text,binPath)
% disp('entropyCoding...')
feq=tabulate(text);
feq(:,3)=[];
feqInt = uint8((feq(:,2)./max(feq(:,2)))*255);
feqInt = feqInt+ uint8((feq(:,2)~=0) & (double(uint8((feq(:,2)./max(feq(:,2)))*255))==0));
% feqInt = feq(:,2);
feqC = feqInt;
feq(feqC==0,:)=[];
feqC(feqC==0)=[];
counts = double(feqC);
temp = nan(size(text));
for i=1:size(feq,1)
  temp(text==feq(i,1))=i;
end
text = temp;
bin = arithenco(text,counts);
lenthtext= uint32(length(text));
fileID = fopen(binPath,'w');
fwrite(fileID,lenthtext,'uint32');
fwrite(fileID,feqInt,'uint8');
fwrite(fileID,bin,'ubit1');
fclose(fileID);
% save(binPath,'bin','feqC','lenthtext');
binsize = dir(binPath); 
binsize = binsize.bytes;
end

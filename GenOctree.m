function [Codes,Octree] = GenOctree(points)
tic
mcode = Morton(points);
Lmax = ceil((size(mcode,2)/3));
pointNum = size(mcode,1);
pointID = 1:pointNum;
nodeid = 0;
proot.nodeid = nodeid;
proot.childPoint={pointID};
proot.occupancyCode=[];
proot.parent=0;
Octree(1:Lmax+1) =struct('node',[],'level',0);
Octree(1).node=proot;
% Octree(1).nodeNum = 1;
for L=1:Lmax
    Octree(L+1).level = L;
    NodeTemp(1:min([pointNum,8^(L-1)])) = struct('nodeid',nan,'childPoint',{[]},'parent',0,'occupancyCode',[]);
    nodeNum = 0;
    for node = Octree(L).node
        for ptid = node.childPoint
            PId = ptid{:};
            if isempty(PId)
               continue
            end
            PId = pointID(PId);
            nodeid=nodeid+1;
            Node.nodeid = nodeid;
            Node.childPoint=cell(1,8);
            Node.parent=node.nodeid;
            n = L-1;
            mn = mcode(PId,1+n*3:3+n*3);
            idn = bin2dec(mn)+1;
            for i = 1:8
              Node.childPoint(i)= {PId(idn==i)};
            end
    %      Node.occupancyCode = flip(~cellfun("isempty",Node.childPoint));
    %     fast code
            Node.occupancyCode = ismember(8:-1:1,idn);
            nodeNum = nodeNum+1;
            NodeTemp(nodeNum)=Node;
        end
    end
    Octree(L+1).node= NodeTemp(1:nodeNum);
end
Octree(1)=[];
toc
% fprintf('bpp before entropy coding:%f bit\n',nodeid*8/pointNum);
% Nodes =  arrayfun(@(S)S.node,Octree,'UniformOutput',false);
% Codes=cellfun(@(S)arrayfun(@(S)S.occupancyCode,S,'UniformOutput',false),Nodes,'UniformOutput',false);
% Codes = bin2dec(num2str(cell2mat([Codes{:}]')));
Nodes = [Octree.node]';
Codes = bin2dec(num2str(cell2mat({Nodes.occupancyCode}')));
end

function mcode= Morton(A)
n = ceil(log2(max(A(:))+1));
x = dec2bin(A(:,1),n);
y = dec2bin(A(:,2),n);
z = dec2bin(A(:,3),n);
m = cat(3,x,y,z);
m = permute(m,[1,3,2]);
mcode = reshape(m,size(x,1),[]);
% mcode = bin2dec(mcode);
end

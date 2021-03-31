function ptRec = DeOctree(dtext)
% DeOctree
ptRec = DeOctree(dtext);
function points = DeOctree(Codes)
occupancyCode = flip(dec2bin(Codes)-'0',2);
codeL = size(occupancyCode,1);
N = ones(1,30);
codcal = 1;
L = 1;
while codcal+N(L)-1<=codeL
   L = L+1;
    N(L+1)= sum(occupancyCode(codcal:codcal+N(L)-1,:),'all');
   codcal = codcal+N(L);
end
Lmax = L;
Octree(1:Lmax)=struct('node',[],'nodeNum',1);
proot = struct('pos',[0,0,0]); 
Octree(1).node = proot;
codei = 1;
for L = 2:Lmax
    Octree(L).nodeNum = N(L+1);
    childId = 0;
    childNode(1:Octree(L).nodeNum) = struct('pos',[0,0,0]);
    for currentNode = Octree(L-1).node
        code =occupancyCode(codei,:);
        for bit = find(code)
           childId = childId+1;
           childNode(childId).pos = currentNode.pos+ bitshift((dec2bin(bit-1,3)-'0'),Lmax-L);
        end
        codei = codei+1;
    end
  Octree(L).node = childNode(1:Octree(L).nodeNum);
end
points = cell2mat({Octree(Lmax).node.pos}');
end
end
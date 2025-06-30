function [Abl,Cbl,BblS,DblS,BblV,DblV,J1]=Lift(Am,Bm,Cm,Dm,r)
Abl=Am^r;
Cbl=Cm;
for i=2:r
    Cbl=[Cbl;Cm*Am^(i-1)];
end
BblS=Bm;
for i=2:r  %%%% output blocking
BblS=BblS+Am^(i-1)*Bm;
end
DblS=Dm;
AB=0;
for i=2:r  %%%% output blocking
    for i=2:r
    AB=Am^(i-2)*Bm+AB;
    end
DblS=[DblS;Cm*AB+Dm];
end
BblV=Am^(r-1)*Bm;
for i=r:-1:2
   BblV=[BblV Am^(i-2)*Bm] ;
end
init=zeros(size(Dm));

for i=1:r
    for j=1:r
        if j==i
        DblV{i,j}=Dm;
        elseif j>i
            DblV{i,j}=init;
        elseif i>j
            DblV{i,j}=Cm*Am^(i-2-j+1)*Bm;
    end
end
end
DblV = cell2mat(DblV);

if r-1>0
for i=1:r-1
    for j=1:r-1
        if j==i
        J1{i,j}=Dm;
        elseif j>i
            J1{i,j}=init;
        elseif i>j
            J1{i,j}=Cm*Am^(i-2-j+1)*Bm;
    end
end
end
J1 = cell2mat(J1);
else
    J1=0;
end
end
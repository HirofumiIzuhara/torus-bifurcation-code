function p=oosetfemops(p) 
grid=p.pdeo.grid; 
[K,M,~]=p.pdeo.fem.assema(grid,1,1,1);
p.mat.K=K;
p.mat.M=kron([[1,0];[0,1]],M);
end 

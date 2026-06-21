function Gu=sGjac(p,u)
n=p.np;
[f1u,f1v,f2u,f2v]=njac(p,u); 
Fu=[[spdiags(f1u,0,n,n),spdiags(f1v,0,n,n)];
    [spdiags(f2u,0,n,n),spdiags(f2v,0,n,n)]];
par=u(p.nu+1:end);
alpha=par(1); L=par(2); Du=par(3); Dv=par(4);
N=sparse(p.pdeo.grid.nPoints, p.pdeo.grid.nPoints); 
K=[[(Du/L/L)*p.mat.K N];[N (alpha*Dv/L/L)*p.mat.K]];
Gu=K-p.mat.M*Fu;
end

function [f1u,f1v,f2u,f2v]=njac(p,u)
u1=u(1:p.np); 
u2=u(p.np+1:2*p.np); 
par=u(p.nu+1:end);
alpha=par(1);
A=par(5);
B=par(6);
C=par(7);
f1u=1-2*u1-A*B*u2./(u1+B).^2;
f1v=-A*u1./(u1+B);
f2u=alpha*C*(u2.^2)./(u1.^2);
f2v=alpha*C*(1-2*u2./u1);
end

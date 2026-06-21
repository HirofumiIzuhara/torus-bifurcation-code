function p=tthinit(p,lx,nx,par) % init for Turing-Turing-Hopf
p=stanparam(p); screenlayout(p);
p.fuha.sG=@sG; p.fuha.sGjac=@sGjac; p.sw.jac=1;
p.nc.neq=2; 
p.fuha.outfu=@ntbra;
p.plot.bpcmp=1;
pde=stanpdeo1D(lx,2*lx/nx); p.vol=2*lx; p.x0i=10;
bc=pde.grid.neumannBC('0');
pde.grid.makeBoundaryMatrix(bc); p.nc.sf=0; p.pdeo=pde;
p.sw.sfem=-1; p.np=pde.grid.nPoints; p.nu=p.np*p.nc.neq; p.sol.xi=1/p.nu;
alpha=par(1); L=par(2); Du=par(3); Dv=par(4); A=par(5); B=par(6); C=par(7);
u=((1-A-B+sqrt((1-A-B)^2+4*B))/2)*ones(p.np,1);
v=((1-A-B+sqrt((1-A-B)^2+4*B))/2)*ones(p.np,1);
p.u=[u;v];
p.u(p.nu+1:p.nu+7)=par;
p.file.smod=10;
p.sw.bifcheck=2; 
p.nc.neig=20;
p=setfemops(p);

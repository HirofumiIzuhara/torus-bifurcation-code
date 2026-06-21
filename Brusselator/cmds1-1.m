%% Turing-Turing-Hopf, 1D, basics
close all; keep pphome; 
%% init, and cont of hom.steady branch 
p=[]; lx=0.5; nx=100;
par=[0.495; 1.0; 0.07; 0.34; 2; 3]; % alpha, L, Du, Dv, A, B
p=tthinit(p,lx,nx,par); 
p=setfn(p,'case1-1/hom');
p.nc.ilam=3;
p.sol.ds=-0.0005; 
p.nc.dsmax=0.0005;
p.nc.lammin=0.005; 
p.sw.verb=0; 
p=cont(p,200); 
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt1','case1-1/b1-1',0.0025); 
%figure(2); clf;
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.0025;
p.nc.lammin=0.0; 
p=cont(p,200);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt1','case1-1/b1-2',-0.0025); 
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.0025;
p.nc.lammin=0.0; 
p=cont(p,200);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt2','case1-1/b2-1',0.0025); 
%figure(2); clf;
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.005;
p.nc.lammin=0.01; 
p=cont(p,350);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt2','case1-1/b2-2',-0.0025); 
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.005;
p.nc.lammin=0.01; 
p=cont(p,350);
%% Hopf bifurcations from nonconstant steady state
aux=[]; aux.tl=150;
p=hoswibra('case1-1/b1-2','hpt2',0.01,4,'case1-1/b1-1-h2',aux); 
%figure(2); clf;
p.plot.pmod = 1;
p.hopf.jac=1;
p.nc.dsmax=0.05; 
p.hopf.xi=0.01;
p.nc.tol=1e-8;
p.nc.mu2=0.00001;
%p.usrlam=[];
p.sw.verb=0;
p.hopf.flcheck=1;
p.sw.bifcheck=2;
p=cont(p,300); 
%% Bifurcation diagram
figure(3); clf;
plotbra('case1-1/hom',3,1,'lsw',0,'cl','r');
plotbra('case1-1/b1-1',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b1-2',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b2-1',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b2-2',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b1-1-h2',3,1,'lsw',0,'cl','g');
axis([0.0319 0.033 1.5 2.4]); 
xlabel('D_u'); ylabel('u(0)'); 
%ylim([0.0 3.5]);
%ylim([1.08 1.2]);
%plotbra('hopf2',3,8,'lsw',1,'cl','r');
%xlim([0.2 0.3])
%plotbra('hopf4',3,8,'lsw',15,'cl','g');
set(gcf,'renderer','painters');
%% Solution plot
%hoplotf('case5-3/b1-1-h2','bpt2',1,1);
plotsol('case1-1/b1-2','hpt2',1,[1,2],[1,2]);

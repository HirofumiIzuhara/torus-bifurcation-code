%% Turing-Turing-Hopf, 1D, basics
close all; keep pphome; 
%% init, and cont of hom.steady branch 
p=[]; lx=0.5; nx=100;
par=[0.592; 1.0; 0.15; 1.6; 35.0; 16.0; 9.0; 0.4]; % alpha, L, Du, Dv, a, b, c, d
p=tthinit(p,lx,nx,par);
p=setfn(p,'case1-1/hom');
p.nc.ilam=3;
p.sol.ds=-0.001;
p.nc.dsmax=0.002;
p.nc.lammin=0.03;
p.sw.verb=0;
p=cont(p,100);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt1','case1-1/b1-1',0.01); 
%figure(2); clf;
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.02;
p.nc.lammin=0.03; 
p=cont(p,200);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt1','case1-1/b1-2',-0.01); 
%figure(2); clf;
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.02;
p.nc.lammin=0.03; 
p=cont(p,200);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt2','case1-1/b2-1',0.01); 
%figure(2); clf;
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.02;
p.nc.lammin=0.03; 
p=cont(p,200);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt2','case1-1/b2-2',-0.01); 
%figure(2); clf;
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.02;
p.nc.lammin=0.03; 
p=cont(p,200);
%% Hopf bifurcations from nonconstant steady state
aux=[]; aux.tl=150;
p=hoswibra('case1-1/b1-1','hpt2',0.05,4,'case1-1/b1-1-h2',aux); 
%figure(2); clf;
p.plot.pmod = 1;
p.hopf.jac=1;
p.nc.dsmax=0.25; 
p.hopf.xi=0.01;
p.nc.tol=1e-8;
p.nc.mu2=0.00001;
%p.usrlam=[];
p.sw.verb=0;
p.hopf.flcheck=1;
p.sw.bifcheck=2;
p=cont(p,300); 
%% Hopf bifurcations from nonconstant steady state
aux=[]; aux.tl=150;
p=hoswibra('case1-1/b1-2','hpt2',0.05,4,'case1-1/b1-2-h2',aux); 
%figure(2); clf;
p.plot.pmod = 1;
p.hopf.jac=1;
p.nc.dsmax=0.25; 
p.hopf.xi=0.01;
p.nc.tol=1e-8;
p.nc.mu2=0.00001;
%p.usrlam=[];
p.sw.verb=0;
p.hopf.flcheck=1;
p.sw.bifcheck=2;
p=cont(p,300); 
%% Bifurcations from periodic orbit
%p=poswibra('hopf1','bpt2','hopf2',0.05,aux); 
%p.nc.dsmax=0.5; 
%p=cont(p,50);
%% Parameter switching
figure(2);
clf;
p=hoswiparf('hopf1','pt128','Du-n',3,0.00001);
p.nc.dsmax=0.0005; 
%p.nc.ilam=3;
p.sw.verb=0;
p.sw.para=4;
p.usrlam=[];
%p.sol.ds=0.01;
%p.nc.dsmax=0.01;
%p.nc.lammin=0.0001;
%p.hopf.ilam=2;
%p.nc.dsmax=0.01; 
p=cont(p,150);
%% Bifurcations from periodic orbit
p=poswibra('Du-n','bpt1','hopf2',0.1,aux); 
p.nc.dsmax=0.5; 
p.sw.bifcheck=2;
p=cont(p,200);
%% Bifurcations from periodic orbit
p=poswibra('Du-n','bpt2','hopf3',0.1,aux); 
p.nc.dsmax=0.5; 
p.sw.bifcheck=2;
p=cont(p,200);
%% Bifurcations from periodic orbit
p=poswibra('hopf3','bpt1','hopf3-1',0.1,aux); 
p.nc.dsmax=0.5; 
p=cont(p,200);
%% Bifurcations from periodic orbit
p=poswibra('hopf3-1','bpt1','hopf3-2',0.1,aux); 
p.nc.dsmax=0.5; 
p=cont(p,200);
%% Bifurcation diagram
figure(3); clf;
plotbra('case1-1/hom',3,1,'lsw',0,'cl','r');
plotbra('case1-1/b1-1',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b1-2',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b2-1',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b2-2',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b1-1-h2',3,1,'lsw',0,'cl','g');
plotbra('case1-1/b1-2-h2',3,1,'lsw',0,'cl','g');
%axis([0.05 0.09 0.5 8]); 
axis([0.0538 0.05405 2.2 5.2]); 
xlabel('D_u'); ylabel('u(0)'); 
%ylim([0.0 3.5]);
%ylim([1.08 1.2]);
%plotbra('hopf2',3,8,'lsw',1,'cl','r');
%xlim([0.2 0.3])
%plotbra('hopf4',3,8,'lsw',15,'cl','g');
set(gcf,'renderer','painters');
%% Solution plot
hoplotf('case5-3/b1-1-h2','bpt2',1,1);
%% Solution plot
%hoplotf('hopf1','pt9',1,1);
hoplotf('hopf2','pt50',1,1);
printaux('hopf2','pt50');

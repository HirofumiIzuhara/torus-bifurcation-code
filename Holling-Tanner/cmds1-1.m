%% Turing-Turing-Hopf, 1D, basics
close all; keep pphome; 
%% init, and cont of hom.steady branch 
p=[]; lx=0.5; nx=100;
par=[0.378; 1.0; 0.02; 0.1; 1.0; 0.01; 1.9]; % alpha, L, Du, Dv, A, B, C
p=tthinit(p,lx,nx,par);
p=setfn(p,'case1-1/hom');
p.nc.ilam=3;
p.sol.ds=-0.0001; 
p.nc.dsmax=0.0001;
p.nc.lammin=0.005; 
p.sw.verb=0; 
p=cont(p,200); 
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt1','case1-1/b1-1',0.0005); 
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.0005;
%p.nc.lammin=0.003; 
p=cont(p,100);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt1','case1-1/b1-2',-0.0005); 
p.plot.pmod = 100;
p.nc.ilam=3;
p.nc.dsmax=0.0005;
%p.nc.lammin=0.01; 
p=cont(p,100);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt2','case1-1/b2-1',0.0005); 
p.nc.ilam=3;
p.nc.dsmax=0.0005;
p.nc.lammin=0.005; 
p=cont(p,200);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/hom','bpt2','case1-1/b2-2',-0.0005); 
p.nc.ilam=3;
p.nc.dsmax=0.0005;
p.nc.lammin=0.005; 
p=cont(p,200);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/b2-1','bpt1','case1-1/b2-1-1',0.01); 
p.nc.ilam=3;
p.nc.dsmax=0.01;
p.nc.lammin=0.01; 
p=cont(p,120);
%% Steady bifurcations from constant steady state 
p=swibra('case1-1/b2-1','bpt1','case1-1/b2-1-2',-0.01); 
p.nc.ilam=3;
p.nc.dsmax=0.01;
p.nc.lammin=0.01; 
p=cont(p,120);
%% Hopf bifurcations from nonconstant steady state
aux=[]; aux.tl=150;
p=hoswibra('case1-1/b1-2','hpt2',0.005,4,'case1-1/b1-1-h2',aux); 
%figure(2); clf;
p.plot.pmod = 1;
p.hopf.jac=1;
p.nc.dsmax=0.01; 
p.hopf.xi=0.01;
p.nc.tol=1e-8;
p.nc.mu2=0.00001;
%p.usrlam=[];
%p.sw.verb=0;
p.hopf.flcheck=1;
p.sw.bifcheck=2;
p=cont(p,300); 
%% Bifurcations from periodic orbit
%aux=[]; aux.tl=70; %aux.sw=1;
%p=poswibra('case3-1/b1-1-h1','bpt1','case3-1/b1-1-h1-1',0.001,aux); 
%p.hopf.jac=1;
%p.nc.dsmax=0.005; 
%p.hopf.xi=0.1;
%p.nc.tol=1e-9;
%p.sw.verb=2;
%p.hopf.flcheck=1;
%p=cont(p,10); 
%% Parameter switching
%figure(2);
%clf;
%p=hoswiparf('case-6_1/hom-peri-1','pt28','case-6_1/hom-peri-2',3,0.00005);
%p.nc.dsmax=0.0002; 
%p.nc.dsmin=0.0000001;
%p.sw.verb=0;
%p.sw.para=4;
%p.usrlam=[];
%p.nc.lammin=0.01; 
%p=cont(p,200);
%% Bifurcation diagram
%figure(3);
%clf;
%plotbra('case-3_1/hom-peri-2',3,1,'lsw',0,'cl','m');
%plotbra('case-3_1/hom',3,1,'lsw',0,'cl','r');
%plotbra('case-3_1/b1-1',3,1,'lsw',0,'cl','b');
%plotbra('case-3_1/b1-2',3,1,'lsw',0,'cl','b');
%plotbra('case-3_1/b2-1',3,1,'lsw',0,'cl','b');
%plotbra('case-3_1/b2-2',3,1,'lsw',0,'cl','b');
%plotbra('case-3_1/b3-1',3,1,'lsw',0,'cl','b');
%plotbra('case-3_1/b3-2',3,1,'lsw',0,'cl','b');
%plotbra('case-3_1/b1-1-1',3,1,'lsw',0,'cl','g');
%plotbra('case-3_1/b1-1-2',3,1,'lsw',0,'cl','g');
%plotbra('case-3_1/b2-1-1',3,1,'lsw',0,'cl','g');
%xlim([0.01 0.035]);
%ylim([1.08 1.2]);
%plotbra('hopf2',3,8,'lsw',1,'cl','r');
%xlim([0.2 0.3])
%plotbra('hopf4',3,8,'lsw',15,'cl','g');
%set(gcf,'renderer','painters');
%% Bifurcation diagram
figure(3); clf;
plotbra('case1-1/hom',3,1,'lsw',0,'cl','r');
plotbra('case1-1/b1-1',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b1-2',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b2-1',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b2-2',3,1,'lsw',0,'cl','b');
%plotbra('case1-1/b2-1-1',3,1,'lsw',0,'cl','b');
%plotbra('case1-1/b2-1-2',3,1,'lsw',0,'cl','b');
%plotbra('case2-1/b3-1',3,1,'lsw',0,'cl','b');
%plotbra('case2-1/b3-2',3,1,'lsw',0,'cl','b');
plotbra('case1-1/b1-1-h2',3,1,'lsw',0,'cl','g');
%plotbra('case2-1/hom-peri-2',3,1,'lsw',0,'cl','g');
%plotbra('case3-1/hom-peri-2-1',3,1,'lsw',0,'cl','g');
%plotbra('case-3_1/b3-2',3,1,'lsw',0,'cl','b');
%plotbra('case-3_2/b1-1-1',3,1,'lsw',0,'cl','g');
%plotbra('case-3_1/b2-1-1',3,1,'lsw',0,'cl','g');
axis([0.0104 0.011 0.05 0.14]); 
%axis([0.008 0.014 0.0 0.2]); 
xlabel('D_u'); ylabel('u(0)'); 
%ylim([0.0 3.5]);
%ylim([1.08 1.2]);
%plotbra('hopf2',3,8,'lsw',1,'cl','r');
%xlim([0.2 0.3])
%plotbra('hopf4',3,8,'lsw',15,'cl','g');
set(gcf,'renderer','painters');
%% Solution plot
%hoplotf('hopf1','pt9',1,1);
%hoplotf('case-3_1/b1-1-1','bpt2',1,2);
%plotsol('case1-1/b1-1','pt10',1,1,1);
%plotsol('case1-1/b1-1','pt10',1,2,2);
plotsol('case3-1/b1-1','hpt1',1,[1,2],[1,2]);
%plotsol('b1','pt10',1,2,1);
%printaux('case1-1/b1-1','pt10');
%set(gcf,'renderer','painters');
%plotsol('case1-1/b1-1','pt10',1,1,1);
%hold on;
%plotsol('case1-1/b1-1','pt10',1,2,2);
%hold off

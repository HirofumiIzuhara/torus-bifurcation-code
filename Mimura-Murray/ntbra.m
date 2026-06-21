function out=ntbra(p,u)
if p.sw.para>2
    m1=max(p.hopf.y(1,:));
    m2=min(p.hopf.y(1,:));
    m3=p.hopf.T;
else
    m1=u(1);
    m2=u(1);
    m3=0;
end
out=[m1;m2;m3;sum(p.mat.M(1:p.np,1:p.np)*abs(u(1:p.np).^2))^(1/2)]; 

function f=nodalf(p,u) % for tth
u1=u(1:p.np); u2=u(p.np+1:2*p.np); par=u(p.nu+1:end);
alpha=par(1); a=par(5); b=par(6); c=par(7); d=par(8);
f1=(a*u1+b*u1.^2-u1.^3)/c-u1.*u2;
f2=alpha*(u1.*u2-u2-d*u2.^2);
f=[f1;f2];
end


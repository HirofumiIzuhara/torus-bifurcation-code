function f=nodalf(p,u) % for tth
u1=u(1:p.np); 
u2=u(p.np+1:2*p.np); 
par=u(p.nu+1:end);
alpha=par(1); 
A=par(5); 
B=par(6);
C=par(7);
f1=u1.*(1.0-u1)-A*u1.*u2./(u1+B);
f2=alpha*C*u2.*(1-u2./u1);
f=[f1;f2];
end


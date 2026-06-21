function f=nodalf(p,u) % for tth
u1=u(1:p.np); 
u2=u(p.np+1:2*p.np); 
par=u(p.nu+1:end);
alpha=par(1); 
A=par(5); 
B=par(6);
f1=A-u1-4.0*u1.*u2./(1.0+u1.^2);
f2=alpha*B*(u1-u1.*u2./(1.0+u1.^2));
f=[f1;f2];
end


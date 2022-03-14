clear; clf;

N=2.^(2:7);
L=1; h=L./N; alp=1;
E=zeros(1, length(N));
for k=1:length(N)
    n=N(k); %m=n-1;
    x=h(k)*(1:n-1)';
    f=-sin(x);
    F=f; F(1)=F(1)+alp/h(k)^2;
    
    e=ones(n-1, 1);
    A=spdiags([-e 2*e -e], -1:1, n-1, n-1)/h(k)^2;
    u=A\F;
    E(k)=max(abs(-sin(x)+(sin(1)-1)*x+1-u));
end
figure(1);
plot(x, u, 'b-');
figure(2);
loglog(h, E, 'b--o');
hold on;
loglog(h, 0.2*h.^2, 'k-');
hold off;
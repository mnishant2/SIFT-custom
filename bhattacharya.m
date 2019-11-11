function distance=bhattacharya(h1,h2)
denom=sqrt(sum(h1).* sum(h2));
num=sqrt(h1.*h2);
distance=sum(num./denom);
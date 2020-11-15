close all
time = h5read('data.h5','/time');
V = h5read('data.h5','/variables/V');
cord = h5read('data.h5','/coordinates');
y = cord(2,:);
pwelch(V(40,:),kaiser(length(V),0.1),[],length(V),1/(time(2)-time(1)))

figure()
plot(time,V(40,:),'x')

figure()
contourf(time,y,V,[-0.8:0.01:0.8])
colorbar

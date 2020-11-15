clear all
close all;


data(1).data = importdata('mesh5/forceCoeffs.dat');
data(1).mesh = 5;
data(1).meshsize = 0.1828;
data(2).data = importdata('mesh10/forceCoeffs_0.01.dat');
data(2).mesh = 10;
data(2).meshsize = 0.0914;
data(3).data = importdata('mesh15/forceCoeffs_0.01.dat');
data(3).mesh = 15;
data(3).meshsize = 0.06093;
data(4).data = importdata('mesh20/forceCoeffs_0.01.dat');
data(4).mesh = 20;
data(4).meshsize = 0.0457;
data(5).data = importdata('mesh25/forceCoeffs_0.01.dat');
data(5).mesh = 25;
data(5).meshsize = 0.03656;
data(6).data = importdata('mesh30/forceCoeffs_0.005.dat');
data(6).mesh = 30;
data(6).meshsize = 0.030466;
data(7).data = importdata('mesh35/forceCoeffs_0.005.dat');
data(7).mesh = 35;
data(7).meshsize = 0.02611;
data(8).data = importdata('mesh40/forceCoeffs_0.005.dat');
data(8).mesh = 40;
data(8).meshsize = 0.02285;
data(9).data = importdata('mesh45/forceCoeffs_0.005.dat');
data(9).mesh = 45;
data(9).meshsize = 0.02031;
data(10).data = importdata('mesh45x45/forceCoeffs_0.005.dat');
data(10).mesh = 4545;
data(10).meshsize = 0.02031;
data(10).data = importdata('mesh50x50/forceCoeffs_0.003.dat');
data(10).mesh = 5050;
data(10).meshsize = 0.01828;


for i = 1:length(data)
    fs = 1/(data(i).data.data(2,1)-data(i).data.data(1,1));
    data(i).maxCd = max(data(i).data.data(3*end/5:end,3));
    data(i).meanCd = mean(data(i).data.data(3*end/5:end,3));
    data(i).maxCl = max(data(i).data.data(3*end/5:end,4));
    data(i).minCl = min(data(i).data.data(3*end/5:end,3));
    data(i).time = data(i).data.data(3*end/5:end,1);
    [pxx,f] = pwelch([data(i).data.data(3*end/5:end,4)],length([data(i).data.data(3*end/5:end,4)]),[],length([data(i).data.data(3*end/5:end,4)]),fs);
    [M,I] = max(pxx);
    figure()
    plot(f(1:end/100),pxx(1:end/100));
    l = sprintf('Mesh: %f, elementsize: %f',data(i).mesh,data(i).meshsize);
    data(i).f_peak = f(I);
    
    legend(l);
    figure(2)
    hold on;
    h{i} = sprintf('Mesh: %i',data(i).mesh);
   
    plot([data(i).data.data(:,1)],[data(i).data.data(:,3)]) 
    xlabel('time');
    ylabel('C_D');
    
    

end
legend(h);
figure()
plot(1./[data.meshsize],[data.meanCd])
xlabel('1/h');
ylabel('C_D');

figure()
plot(1./[data.meshsize],[data.maxCl])
xlabel('1/h');
ylabel('C_{L max}');

figure()
plot(1./[data.meshsize],[data.f_peak])
xlabel('1/h');
ylabel('Shedding frequency');


fileID = fopen('MIDETROI.txt');
temp = textscan(fileID, '%d %d %d %f64');
year = 1995;
day = 1;
for i = 1:8327
    if(year == temp{3}(i))
        temp{5}(i) = day;
        day = day + 1;
    else
        year = year + 1;
        day = 1;
        temp{5}(i) = day;
    end
end

x = temp{5};
x = transpose(x);
y_real = temp{4};

fit = @(b,x) b(1)+b(2)*cos(x*2*pi/365.25)+b(3)*sin(x*2*pi/365.25);
cost = @(b) sum((fit(b,x) - y_real).^2);
s = fminsearch(cost, [0;0;0;0]);

x_fit = 1:365;
y_fit = s(1)+s(2)*cos(x_fit*2*pi/365.25)+s(3)*sin(x_fit*2*pi/365.25);

min_temp = min(y_fit);
max_temp = max(y_fit);

figure
scatter(x,y_real,'+');
hold on
plot(x_fit,y_fit,'color',[0.91 0.41 0.17],'LineWidth',3);
xlim([1 365])
h1 = refline([0, min_temp]);
h2 = refline([0,max_temp]);
h1.Color = 'r';
h2.Color = 'r';
hold off

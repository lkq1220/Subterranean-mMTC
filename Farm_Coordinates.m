% function [newpos,Ctrs_UTM,D] = Farm_Coordinates()
% Lat = [30.299673 30.216815 30.127895 30.10524957136607 30.057146171458562 29.95016948489893 29.81778324533373 29.774405499105434 29.672618095472167 29.697506438117188 29.63976274152901 29.720830539481792 29.857811948549738 29.941235618176737 29.93767253521321 30.026108095615488 30.068310949391538 30.096000172607308 30.30486171076145];
% Long = [38.125030 38.487380 38.462590 38.563632158477745 38.58438206436821 38.61614120697012 38.50953366338514 38.594582108113755 38.488574457800055 38.43650972225629 38.38809283730249 38.22125767957599 38.15306518291119 38.17389788781801 38.17667462181306 38.077370699339085 38.09664901934875 38.020542585375466 38.0991307514139];
% 
% Big_region = [Lat;Long];
% 
% digits(32)
% dlmwrite('Big_Region.csv',Big_region','delimiter', ',', 'precision', 32)
% 
% 
% Lat_1 = [29.667817890790314 29.770999682626275 29.797145831517675 29.81502174933678 29.832267358216384 29.905502007182466 29.788970517836702 29.656897381093906 29.68835547023453 29.62867002563271 29.666637035206463];
% Long_1 = [38.58768568397128 38.723811010651964 38.71627385068474 38.740177980704566 38.729119878273984 38.7907299592846 38.92519964537186 38.73845878492111 38.706249519522004 38.624820409000534 38.58567736913604];
% 
% Small_region = [Lat_1;Long_1];
% 
% digits(32)
% dlmwrite('Small_Region.csv',Small_region','delimiter', ',', 'precision', 32)
deg = km2deg(1);
% S = [30.310191757508296, 38.07293962691602];
% E = [30.17953964970978, 38.640735568054076];
% 
% S_new = [30.310191757508296-deg, 38.07293962691602];
% E_new = [30.17953964970978-deg, 38.640735568054076];

%New_lat = linspace(30.310191757508296,30.17953964970978,56);
%New_long = linspace(38.07293962691602,38.640735568054076,56);

New_lat = [30.36298826024972 30.130268427304042];
New_long = [37.866243349226934  38.89898144847];

for i=1:1:102
    Artificial_Lat(i,:) = linspace(New_lat(1)-km2deg(i),New_lat(2)-km2deg(i),102);
    Artificial_Long(i,:) = linspace(New_long(1),New_long(2),102);
end

close all
Artificial_Farm = [Artificial_Lat(:) Artificial_Long(:)];

Big_region = csvread('Big_Region.csv');
Small_region = csvread('Small_Region.csv');

% Total_sensors = 50e3;
% [Grid, Center_found,D] = Region1(Big_region(:,1),Big_region(:,2),Total_sensors);

figure(1)
geoplot(Big_region(:,1),Big_region(:,2),'r', 'LineWidth',2)
hold on
%geoscatter(New_lat1(:),New_long1(:),'k.')
geoplot(Small_region(:,1),Small_region(:,2),'r', 'LineWidth',2)
geobasemap 'satellite'


inside_Big_Farm_index = inpolygon(Artificial_Lat(:),Artificial_Long(:),Big_region(:,1),Big_region(:,2));
inside_Small_Farm_index = inpolygon(Artificial_Lat(:),Artificial_Long(:),Small_region(:,1),Small_region(:,2));

Two_Farms_Artificial = [Artificial_Farm(inside_Big_Farm_index,1),Artificial_Farm(inside_Big_Farm_index,2); Artificial_Farm(inside_Small_Farm_index,1),Artificial_Farm(inside_Small_Farm_index,2)]; 
% figure(2)
% geoscatter(Artificial_Farm(:,1),Artificial_Farm(:,2),'k.')
% geobasemap 'satellite'

figure(2)
geoscatter(Artificial_Farm(inside_Big_Farm_index,1),Artificial_Farm(inside_Big_Farm_index,2),'k.')
hold on 
geoscatter(Artificial_Farm(inside_Small_Farm_index,1),Artificial_Farm(inside_Small_Farm_index,2),'k.')
geobasemap 'satellite'


figure(3)
geoscatter(Two_Farms_Artificial(:,1),Two_Farms_Artificial(:,2),'k.')
hold on
geobasemap 'street'

opts = statset('Display', 'final');
[Idx, Ctrs, SumD, D] = kmeans(Two_Farms_Artificial, 1, 'Replicates', 10, 'Options', opts);
geoscatter(Ctrs(1,1),Ctrs(1,2),'rx',LineWidth=5);
hold on

newpos=latlon2UTM(Two_Farms_Artificial);
opts = statset('Display', 'final');
[Idx_UTM, Ctrs_UTM] = kmeans(newpos, 1, 'Replicates', 10, 'Options', opts);
% plot(newpos(:,1),newpos(:,2),'rx');
% hold on
% plot(Ctrs_UTM(:,1),Ctrs_UTM(:,2),'kx','MarkerSize',14, 'LineWidth',2);
D=sqrt(abs((newpos(Idx_UTM==1,1)-Ctrs_UTM(1,1)).^2)+abs((newpos(Idx_UTM==1,2)-Ctrs_UTM(1,2)).^2));
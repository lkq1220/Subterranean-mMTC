%%%MATLAB����ʵ�־�γ��ת����ƽ������꣺
function [new_position,Ctrs,D] = latlon2UTM(position)
    M_PI=3.14159265358979323846;
    L = 6381372 * M_PI * 2; %�����ܳ�  
    W = L; % ƽ��չ����x������ܳ�  
    H = L / 2; % y��Լ�����ܳ�һ��  
    mill = 2.3; % ����ͶӰ�е�һ����������Χ��Լ������2.3֮�� 

    n=size(position,1);

    %%lon=120.7015202;%����
    %%lat=36.37423;%γ��
    new_position=zeros(n,2);

    for i =1:n
        lon=position(i,2);
        lat=position(i,1);
        x = lon * M_PI / 180; % �����ȴӶ���ת��Ϊ����  
        y = lat * M_PI / 180; %��γ�ȴӶ���ת��Ϊ����  
        y1 = -1.25 * log(tan(0.25 * M_PI + 0.4 * y)); % ����ͶӰ��ת��  
        % ����תΪʵ�ʾ���  
        dikaerX = (W / 2) + (W / (2 * M_PI)) * x ; %�ѿ�������x
        dikaerY = (H / 2) - (H / (2 * mill)) * y1 ;%�ѿ�������y
        new_position(i,1)=dikaerX;
        new_position(i,2)=dikaerY;
    end
end
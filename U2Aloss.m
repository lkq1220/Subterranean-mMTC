function [pr_res] = U2Aloss(realSoilDielectric, imagSoilDielectric,depth,distance,eta,Freq_Band)
    m_realSoilDielectric = realSoilDielectric;
    m_imagSoilDielectric = imagSoilDielectric;
    m_frequecny = Freq_Band;
    EPSILON_0 =  8.854187817 * 10.0^-12;
    MIU_0 = 4 * pi * 10^-7;
    omega = 2 * pi * m_frequecny;
    magEle = (MIU_0 * m_realSoilDielectric * EPSILON_0 / 2.0);
    imagReal = sqrt(1 + (m_imagSoilDielectric / m_realSoilDielectric)^2);
    m_Alpha = omega * sqrt(magEle * (imagReal - 1));
    m_Beta =  omega * sqrt(magEle * (imagReal + 1));
    c=3e8;
%   计算接收信号强度
    %soil path losses
    %n = sqrt((sqrt(m_realSoilDielectric.*m_realSoilDielectric+m_imagSoilDielectric.*m_imagSoilDielectric)+m_realSoilDielectric)/2);
    
    theta_i =asin(1.0./sqrt(m_realSoilDielectric));
    r1 = abs(depth) ./ cos(theta_i);
    r2 = distance;
    Lu = 6.4 + 20.*log10(r1) + 20.*log10(m_Beta) + 8.69.*m_Alpha.*r1;
    La = eta.*(10.*log10(4.*pi.*r2.*m_frequecny./c));
%   Lu_a=10*log10(((sqrt(m_realSoilDielectric)+1)^2)/(4*sqrt(m_realSoilDielectric)));
%   pr_res = Ptx-Lu-La-Lu_a;
    pr_res = Lu+La;
%     pr_res = 10.^(res_db./10);
end


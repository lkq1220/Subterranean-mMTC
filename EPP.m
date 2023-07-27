function [EPP_value] = EPP(ToA,PDR)
    Voltage=3.3;
    Imax=0.11415;
    EPP_value=Voltage.*ToA.*Imax./PDR;
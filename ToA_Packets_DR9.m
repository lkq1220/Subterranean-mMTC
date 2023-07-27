% Paper title: Analysis and Simulation of LoRaWAN LR-FHSS for Direct-to-Satellite Scenario
% IEEE XPlore: https://ieeexplore.ieee.org/document/9653679
% Authors: Muhammad Asad Ullah, Konstantin Mikhaylov, Hirley Alves

% Cite this: M. A. Ullah, K. Mikhaylov and H. Alves, "Analysis and Simulation of LoRaWAN LR-FHSS for Direct-to-Satellite Scenario," in IEEE Wireless Communications Letters, doi: 10.1109/LWC.2021.3135984.

function [Payload_CRC_ToA_DR9,Payload_CRC_ToA_DR9_WH] = ToA_Packets_DR9(Payload,Header_ToA_DR9,M)    
   
    for PL=1:length(Payload)
    Payload_CRC_ToA_DR9(PL) = Header_ToA_DR9  + ceil((Payload(PL) + 3)/M)*(102.4/1000); 
    Payload_CRC_ToA_DR9_WH(PL) = ceil((Payload(PL) + 3)/M)*(102.4/1000); 
    end
end
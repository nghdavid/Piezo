function [output,fake_volts,stimulus_length] = behavior_pulse_genarator(rate,frequency,pulse_time,interval,amplitude,repeat_time)
%% This function can generate a series of pulses with assigned frequency and amplitude
period = 1/frequency;%single trial time
pulse = [ones(1,floor(period/2*rate))*amplitude,ones(1,floor(period/2*rate))*amplitude*-1];%single trial
pulses = repmat(pulse,1,floor(pulse_time/period));%Repeat trials
volt = [pulses,zeros(1,floor(interval*rate))];
volts = repmat(volt,1,repeat_time);%Repeat trials

fake_pulse = [ones(1,floor(period/2*rate)),ones(1,floor(period/2*rate))];
fake_pulses = repmat(fake_pulse,1,floor(pulse_time/period));%Repeat trials
fake_volt = [fake_pulses,zeros(1,floor(interval*rate))];
fake_volts = repmat(fake_volt,1,5);%Repeat trials
adaptation = zeros(1,floor((interval+pulse_time)*2*rate));
output = [adaptation,volts];
stimulus_length = length([adaptation,volts,fake_volts])/rate; 
end
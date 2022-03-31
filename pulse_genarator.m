function [output,fake_output,stimulus_length] = pulse_genarator(rate,frequency,pulse_time,interval,amplitude,repeat_time)
%% This function can generate a series of pulses with assigned frequency and amplitude
period = 1/frequency;%single trial time
pulse = [ones(1,floor(period/2*rate))*amplitude,ones(1,floor(period/2*rate))*amplitude*-1];%single trial
pulses = repmat(pulse,1,floor(pulse_time/period));%Repeat trials
volt = [pulses,zeros(1,floor(interval*rate))];
adaptation = zeros(1,floor((interval+pulse_time)*5*rate));
post_adaptation = zeros(1,floor((interval+pulse_time)*30*rate));
volts = repmat(volt,1,repeat_time);%Repeat trials
fake_volts = repmat(volt,1,5);%Repeat trials
output = [adaptation,volts,post_adaptation];
fake_output = [adaptation,zeros(1,length(volts)),fake_volts,post_adaptation];
fake_output = fake_output(1:length(output));
stimulus_length = length([adaptation,volts,volts])/rate; 
end
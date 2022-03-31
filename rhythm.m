%% Generate stimulus
clear all;
rate=20000;%Rate of DAQ (20000 is max)
filename = 'file_00001';
frequency=70;%Hz
amplitude =10;%Output amplitude (volt), 10 is max
repeat_time =20;%how long the stimulus is
pulse_time = 0.2;
interval =4;
%volts = series_genarator(rate,frequency,amplitude,time);
[volts,fake_volts,stimulus_length] = pulse_genarator(rate,frequency,pulse_time,interval,amplitude,repeat_time);%stimulus
trigger_volt = ones(1,length(volts))*5;%TTL pulse to trigger start and end
trigger_volt(end) = 0;
analog_output = zeros(length(volts),2);%DAQ output
analog_output(:,1) = volts;%
analog_output(:,2) = trigger_volt;%
time = [0:length(volts)]/rate;
disp(['The time is ',num2str(stimulus_length),' second'])

%% Give stimulus
daq_out = daqmx_Task('chan','Dev1/ao0:1' ,'rate',rate, 'Mode', 'f');
daq_out.write(0);
daq_out.write([analog_output]);
mkdir stimulus
save([pwd,'\stimulus\',filename,'.mat'],'rate','frequency','amplitude','repeat_time','pulse_time','interval','volts','fake_volts');

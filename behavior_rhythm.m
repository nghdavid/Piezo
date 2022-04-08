%% Generate stimulus
clear all;
filename = '5-3';
rate=20000;%Rate of DAQ (20000 is max)
frequency=70;%Hz
amplitude =10;%Output amplitude (volt), 10 is max
repeat_time = 20;%how many time of the stimulus
pulse_time = 0.3;
interval = 4;
LED_intensity = 1.11;
[volts,fake_volts,stimulus_length] = behavior_pulse_genarator(rate,frequency,pulse_time,interval,amplitude,repeat_time);%stimulus
LED_volt = [abs(volts/amplitude*LED_intensity),fake_volts*LED_intensity];%Tell LED to turn on during vibration
volts = [volts,zeros(1,length(fake_volts))];
analog_output = zeros(length(volts),2);%DAQ output
analog_output(:,1) = volts;%
analog_output(:,2) = LED_volt;%
time = [0:length(volts)-1]/rate;
disp(['The time is ',num2str(stimulus_length),' second'])

%% Give stimulus
daq_out = daqmx_Task('chan','Dev1/ao0:1' ,'rate',rate, 'Mode', 'f');
daq_out.write(0);
daq_out.write([analog_output]);
mkdir stimulus
save([pwd,'\stimulus\',filename,'.mat'],'rate','frequency','amplitude','repeat_time','pulse_time','interval','volts','LED_volt');
pause(stimulus_length+5)
daq_out = daqmx_Task('chan','Dev1/ao0:1' ,'rate',rate, 'Mode', 'f');
daq_out.write(0);
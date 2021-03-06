% Shaun Bautista
% 218750935
% Major Project (Music Box)
% November 10, 2021
% EECS 1011 Section E

% ------------------------------------------------------------------------
%{
Functions Used:
- setFilter.m, morseChart.m, morseWrite.m, songChoice.m, threshold.m
%}  
% ------------------------------------------------------------------------

% Setup
clear; close all; clc;
a = arduino;

frequencies = [16.35 17.32 18.35 19.45 20.6 21.83 23.12 24.5 25.96 27.5 29.14 30.87 32.7 34.65 36.71 38.89 41.2 43.65 46.25 49 51.91 55 58.27 61.74 65.41 69.3 73.42 77.78 82.41 87.31 92.5 98 103.83 110 116.54 123.47 130.81 138.59 146.83 155.56 164.81 174.61 185 196 207.65 220 233.08 246.94 261.63 277.18 293.66 311.13 329.63 349.23 369.99 392 415.3 440 466.16 493.88 523.25 554.37 587.33 622.25 659.25 698.46 739.99 783.99 830.61 880 932.33 987.77 1046.5 1108.73 1174.66 1244.51 1318.51 1396.91 1479.98 1567.98 1661.22 1760 1864.66 1975.53 2093 2217.46 2349.32 2489.02 2637.02 2793.83 2959.96 3135.96 3322.44 3520 3729.31 3951.07 4186.01 4434.92 4698.63 4978.03 5274.04 5587.65 5919.91 6271.93 6644.88 7040 7458.62 7902.13];
notes = ["C0" "Db0" "D0" "Eb0" "E0" "F0" "Gb0" "G0" "Ab0" "A0" "Bb0" "B0" "C1" "Db1" "D1" "Eb1" "E1" "F1" "Gb1" "G1" "Ab1" "A1" "Bb1" "B1" "C2" "Db2" "D2" "Eb2" "E2" "F2" "Gb2" "G2" "Ab2" "A2" "Bb2" "B2" "C3" "Db3" "D3" "Eb3" "E3" "F3" "Gb3" "G3" "Ab3" "A3" "Bb3" "B3" "C4" "Db4" "D4" "Eb4" "E4" "F4" "Gb4" "G4" "Ab4" "A4" "Bb4" "B4" "C5" "Db5" "D5" "Eb5" "E5" "F5" "Gb5" "G5" "Ab5" "A5" "Bb5" "B5" "C6" "Db6" "D6" "Eb6" "E6" "F6" "Gb6" "G6" "Ab6" "A6" "Bb6" "B6" "C7" "Db7" "D7" "Eb7" "E7" "F7" "Gb7" "G7" "Ab7" "A7" "Bb7" "B7" "C8" "Db8" "D8" "Eb8" "E8" "F8" "Gb8" "G8" "Ab8" "A8" "Bb8" "B8"];

% ------------------------------------------------------------------------

% Full Code
initialized = false;
i = 1;
j = 1;
while i == 1
    % Opening Tune When Light Intensity is High
    if readVoltage(a, 'A1') > 0.5 && j == 1
        greeting = ["C4", "E4", "F4", "C5"];
        for j = 1:length(greeting)
        location = find(notes == (notes(notes == greeting(j))));
        playTone(a, 'D5', frequencies(location))
        pause(0.01);
        configurePin(a, 'D5', 'DigitalOutput');
        writeDigitalPin(a, 'D5', 0);
        end
        initialized = true;
        j = 0;
    
    % Closing Tune When Light Intensity is Low
    elseif readVoltage(a, 'A1') <= 0.5 && initialized == true
        goodbye = ["F5", "E5", "D5", "C5"];
        for j = 1:length(goodbye)
        location = find(notes == (notes(notes == goodbye(j))));
        playTone(a, 'D5', frequencies(location))
        pause(0.01);
        configurePin(a, 'D5', 'DigitalOutput');
        writeDigitalPin(a, 'D5', 0);
        end
        i = 0;
    end
    
    % ------------------------------------------------------------------------
    
    % Morse Code Through Button Input
    press = readDigitalPin(a, 'D6');
    if press == 1 && readVoltage(a, 'A0') == 5
        writePWMDutyCycle(a, 'D5', 0.2);
        writeDigitalPin(a, 'D4', 1)
    else
        writePWMDutyCycle(a, 'D5', 0);
        writeDigitalPin(a, 'D4', 0)
        x = 1;
        
        % More Sophisticated Morse Code Feature
        while x == 1 && readVoltage(a, 'A0') ~= 5 && readVoltage(a, 'A0') > 2.5 && press == 1
            writePWMDutyCycle(a, 'D5', 0);
            
            % Present Two Options to the User
            option = input("Read or Write? ");
            
            % Read Option (Create a word using morse code through button inputs)
            if option == "Read"
                size = input("How Many Characters? ");
                code = nan(1, 14, size);
                if press == 1
                    for m = 1:14*size
                        writePWMDutyCycle(a, 'D5', 0)    
                        pause(0.5);
                        press = readDigitalPin(a, 'D6');
                        if press == 1
                            code(m) = press;
                            code
                        else
                            code(m) = 0;
                            code
                        end
                    end
                    q = 1;
                    Letter = morseChart(code, size);
                    code
                    Letter
                    
                    code3 = code;
                    code3(code3 == 1) = 0.2;
                    for z = 1:numel(code)
                        writeDigitalPin(a, 'D4', code(z));
                        writePWMDutyCycle(a, 'D5', code3(z));
                        pause(0.25);
                    end
                end
                
            % Write Option (Input a word and convert it to morse)
            elseif option == "Write"
                uinput = input("Letter (Single Quotes All Caps): ");
                [uletter, morseCode] = morseWrite(uinput);
                uletter
                morseCode
                
            elseif option == "Stop"
                x = 0;    
            end
        end
    end
    
    % ------------------------------------------------------------------------
    
    % Record Received Audio Through Sound Sensor
    if readVoltage(a, 'A0') == 0 && press == 1
        h1 = animatedline('Color', 'r');
        h2 = animatedline('Color', 'b');
        h3 = animatedline('Color', 'g');
        h4 = animatedline('Color', 'c');
        ax = gca;
        ax.YGrid = 'on';
        ax.YLim = [-0.1 4.6];
        filter = zeros(1, 5); % Filter Factor
        
        title('Sound Sensor Voltage Vs Time');
        xlabel('Time [HH:MM:SS]');
        ylabel('Voltage (V)');
        legend("Original", "Averaged", "Averaged & Thresholded", "Audio Level"); 
            
        stop = false;
        startTime = datetime('now');
        while ~stop
            original = readVoltage(a, 'A2');
            
            filter = setFilter(filter);
            filter(length(filter)) = original;
            average = mean(filter);
            
            % Threshold
            threshValue = threshold(average, 1.5);

            % Audio Level
            audioLevel = (1/4)*average;

            % Get current time
            t = datetime('now') - startTime;
             
            % Add points to animation
            addpoints(h1, datenum(t), original);
            addpoints(h2,datenum(t),average);
            addpoints(h3,datenum(t),threshValue);
            addpoints(h4, datenum(t), audioLevel);
             
            % Update axes
            ax.XLim = datenum([t-seconds(15) t]);
            datetick('x','keeplimits')
            drawnow
             
            % Check stop condition
            stop = readDigitalPin(a,'D6');
       end
   end
    
    % ------------------------------------------------------------------------
    
    % Play Song Based On User Input Taken From List
    if readVoltage(a, 'A0') ~= 0 && readVoltage(a, 'A0') < 2.5 && press == 1
        choices = ["Among Us", "USSR Anthem", "River Flows", "Rickroll", "Mario Theme", "Fur Elise"];
        choice = listdlg("PromptString", "Song Choice","ListSize", [100 100], "ListString", choices, "SelectionMode", "single");
        choice = songChoice(choice);

        % Play Chosen Song
        for l = 1:length(choice)
            location = find(notes == (notes(notes == choice(l))));
            playTone(a, 'D5', frequencies(location));
            pause(0.2)
            configurePin(a, 'D5', 'DigitalOutput');
            writeDigitalPin(a, 'D5', 0);
        end
    end
    
    % ------------------------------------------------------------------------
    
    % User Input Piano Through Sound Sensor
    if readVoltage(a, 'A2') > 4
        w = 1;
        while w == 1
        % User Input Piano Key Option
        piano = input("Play Piano Key: ");
            % Stop
            if piano == "Stop"
                configurePin(a, 'D5', 'Unset');
                w = 0;
            
            % User Input Notes Sequence Option    
            elseif piano == "Sequence"
                sequence = input("Piece: ");
                for r = 1:length(sequence)
                    location = find(notes == (notes(notes == sequence(r))));
                    playTone(a, 'D5', frequencies(location));
                    pause(0.2);
                    configurePin(a, 'D5', 'DigitalOutput');
                    writeDigitalPin(a, 'D5', 0);
                end
                
            % Play Single Notes    
            else
                location = find(notes == (notes(notes == piano)));
                playTone(a, 'D5', frequencies(location));
                pause(0.5);
            end
        end
    end  
end
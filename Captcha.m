
%Captcha solver - MDP D Project Marco Dondo Unmib 2022
%This script uses OCR (Optical character recognition) functions. Before to
%continue please install the "Computer Vision Toolbox" by MathWorks.

close all
clear, clc

%Console interface looping
while true

    %Console interface instructions
    disp('CAPTCHA BREAKER MATLAB MDP UNIMIB PROJECT');
    disp('Enter a number corresponding to the function you want to use ');
    disp('1: Resolve captcha');
    disp('2: Generate a strong captcha');
    disp('3: Exit');
    n = input('Select the number and press enter: ');


    %switch for the different instructions
    switch n

        %Case 1: Resolve captcha
        case 1
            close all;
            %Select one captcha images among the "imgs" folder
            n2 = input('Enter captcha image number [1-20]: ');

            %call the function to resolve the selected captcha
            [x,y,z] = Resolve(n2);

            %Check if the algorithm resolve the captcha
            if((isempty(y))==0)
                %plot results
                figure,
                subplot(1, 2, 1), imshow("imgs/Captcha"+n2+".png"), title("Original Captcha");
                subplot(1, 2, 2), imshow(x), title("Captcha solved");

                %display console output
                fprintf(1, '\n');
                disp("---------- RESULTS ----------");
                format short g
                disp("Captcha result: "+y)
                disp("Accuracy result: "+(round(((z.WordConfidences)*100)))+"%");
                disp("------------------------------");
                fprintf(1, '\n');

                %else display error
            else
                fprintf(1, '\n');
                disp("---------- RESULTS ----------");
                disp("Captcha not solved or file not found");
                disp("------------------------------");
                fprintf(1, '\n');
            end

            %Case 1: Generate strong captcha
        case 2
            close all;
            %call the function to generate the strong captcha
            [s] = Generate();
            %%Check if the algorithm generate the captcha
            if(s==1)
                fprintf(1, '\n');
                disp("---------- RESULTS ----------");
                disp("Your strong captcha was saved in: "+pwd+"\StrongCaptcha.png");
                disp("------------------------------");
                fprintf(1, '\n');
                %else display error
            else
                fprintf(1, '\n');
                disp("---------- RESULTS ----------");
                disp("Error");
                disp("------------------------------");
                fprintf(1, '\n');
            end
            %Case n: Exit
        otherwise
            close all;
            disp('Bye!');
            break
    end

end

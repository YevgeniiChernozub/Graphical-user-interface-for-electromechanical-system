clc, clear, clf, format compact
syms s Rs Rl L1 L2 L3 C3 C1 C2 Ur Ui  

%% Zadanie vstupných hodnôt
disp('Filter Chebysheva typu pásmový priepust')
g1=3.3487; g2=0.7117; g3=g1; del=0.10; f0=2.5e6;
Rsx=50; Rlx=50;Rx=50;
%L1x=35.47e-3; C1x=1.428e-6; L2x = 1.432; C2x = 35.38e-9; C3x=3.010e-6; L3x = 16.83e-3;
 L1x=(g1*Rx)/(2*pi*f0*del); L2x=(Rx*del)/(g2*2*pi*f0); L3x=(g3*Rx)/(2*pi*f0*del); 
 C1x=del/(g1*Rx*2*pi*f0); C2x = g2/(Rx*2*pi*f0*del); C3x=del/(g3*Rx*2*pi*f0); % paramere obvodu
 Ui=1;
Tstep=3e-5; wmin=1.4e7; wmax=1.75e7   % parametre pre Step a Bode
color='b'; % farba grafu 

%% MSP  
disp('MSP')
% Zápis systému a výpočet TF v symbolickom tvare
Ze=(L2*s)/(1+L2*C2*s^2);
Z=[Ze+Rs+1/(s*C1)+L1*s -Ze; -Ze Ze+Rl+1/(s*C3)+s*L3] % matica impedancií obvodu
u=[Ui;0] % vektor napätí obvodu (i=input)
ZI2=[Z(:,1) u ] % submatica pre I2, pre I1 by to bolo: ZI1=[u Z(:,2)]
I2=det(ZI2)/det(Z) % výpočet slučkového prúdu I2 Cramerovým pravidlom
Ur=Rl*I2 % výstupné napätie na R2 (Ohmov zákon), (o – output)
F=Ur/Ui % TF F(s) = Uo(s)/Ui(s) v symbolickom tvare
F=collect(F)
pretty(F)
% Spracovanie údajov TF v symbolickom tvare pre prechod do num. MATLABu
[cit,men]=numden(F) % oddelenie polynómov čitateľa a menovateľa
cit=subs(cit,{Rl,Rs,L1,L2,L3,C1,C2,C3},{Rlx,Rsx,L1x,L2x,L3x,C1x,C2x,C3x}); % dosadenie hodnôt do polynómu čitateľa
men=subs(men,{Rl,Rs,L1,L2,L3,C1,C2,C3},{Rlx,Rsx,L1x,L2x,L3x,C1x,C2x,C3x}); % dosadenie do polynómu menovateľa 

b=sym2poly(cit) % b - koeficienty polynómu čitateľa b(s)
a=sym2poly(men) % a - koeficienty polynómu menovateľa a(s)
b=double(b) % Prechod do numerickeho MATLABu
a=double(a)
F=tf(b,a) % Výsledná TF v numerickom MATLABe
F=tf(b/a(end),a/a(end))% TF upravená pre a0=1 (normovanie TF)

%{
%% Vykresľovanie a popis priebehov PrCh a LFCh
 figure(1)

%  C1x = C1x*1.5;
%  C3x = C1x;
%  C2x = C2x*1.5;
%    Rsx = Rsx*5
% %  
%   numR = [C1x*C3x*L2x*Rlx 0 0 0]
%   denR = [C1x*C2x*C3x*L1x*L2x*L3x C1x*C2x*C3x*L1x*L2x*Rlx+C1x*C2x*C3x*L2x*L3x*Rsx C1x*C2x*L1x*L2x+C1x*C3x*L1x*L2x+C1x*C3x*L1x*L3x+C1x*C3x*L2x*L3x+C2x*C3x*L2x*L3x+C1x*C2x*C3x*L2x*Rlx*Rsx C1x*C3x*L1x*Rlx+C1x*C3x*L2x*Rlx+C2x*C3x*L2x*Rlx+C1x*C2x*L2x*Rsx+C1x*C3x*L2x*Rsx+C1x*C3x*L3x*Rsx C1x*L1x+C1x*L2x+C2x*L2x+C3x*L2x+C3x*L3x+C1x*C3x*Rlx*Rsx C3x*Rlx+C1x*Rsx 1]
%   F1=tf(numR,denR) 
% 
%   C1x=C1x/1.5;
%   C1x = C1x/1.5;
%   C3x = C1x;
%     C2x = C2x/1.5;
%     C2x = C2x/1.5;
%   Rsx = Rsx/5
%   Rsx = Rsx/5
%  
%   numR = [C1x*C3x*L2x*Rlx 0 0 0]
%   denR = [C1x*C2x*C3x*L1x*L2x*L3x C1x*C2x*C3x*L1x*L2x*Rlx+C1x*C2x*C3x*L2x*L3x*Rsx C1x*C2x*L1x*L2x+C1x*C3x*L1x*L2x+C1x*C3x*L1x*L3x+C1x*C3x*L2x*L3x+C2x*C3x*L2x*L3x+C1x*C2x*C3x*L2x*Rlx*Rsx C1x*C3x*L1x*Rlx+C1x*C3x*L2x*Rlx+C2x*C3x*L2x*Rlx+C1x*C2x*L2x*Rsx+C1x*C3x*L2x*Rsx+C1x*C3x*L3x*Rsx C1x*L1x+C1x*L2x+C2x*L2x+C3x*L2x+C3x*L3x+C1x*C3x*Rlx*Rsx C3x*Rlx+C1x*Rsx 1]
%   F2=tf(numR,denR)
%}
 subplot(121); 
 step(F,Tstep), grid on,
 title('Prechodová charakteristika','FontSize',20,'FontWeight','bold')
 legend('F','Orientation','vertical','FontAngle', 'italic','FontSize',16,'FontWeight','bold')
 xlabel('\rightarrow t','FontSize',16,'FontWeight','bold')
 ylabel('\rightarrow U_R/U_{in}','FontSize',16,'FontWeight','bold')
 %LFCh
 subplot(122); bode(F,{wmin,wmax}), grid on
 title('Frekvenčná charakteristika','fontsize',20,'FontWeight','bold')
 xlabel('\rightarrow Frequency','FontSize',16,'FontWeight','bold')
 ylabel('\rightarrow \phi','FontSize',16,'FontWeight','bold')
 set(findall(gcf,'type','line'),'linewidth',2)

 % Vypočet nulov a polov systému 
 z1=zero(F)
 p1=pole(F)
 
%% Odozva har. signal
 F=F*3;
 figure(2)
 bode(F,{wmin,wmax}), grid on
 title('Frekvenčná charakteristika','fontsize',20,'FontWeight','bold')
 xlabel('\rightarrow Frequency','FontSize',16,'FontWeight','bold')
 ylabel('\rightarrow \phi','FontSize',16,'FontWeight','bold')
 set(findall(gcf,'type','line'),'linewidth',2)
 n=50;

    figure(3)                   
    legend('F(s)','Orientation','horizontal','FontAngle', 'italic','FontSize',16)
    w1=1.45e7; T1=2*pi/w1; Tkon1=n*T1;        % volba frekv, doba periody, doba kon.
    [u1,t1]=gensig('sine',T1,Tkon1,T1/24); %('sine','square' doba periódy, trvanie signálu, vzorkovanie
%     u1=u1/10;
    lsim (F,u1,t1),grid on                % formatovanie nadpisu grafu fonty: vypis hondoty frekvencie do nadpisu, použite skratiek \it italics, \rm normal, \bf bold  
    xlim([0,Tkon1]);
    title ('\omega = 10 rad/s'); 
    ylabel('\rightarrow Amplitúda [dB]'), xlabel('\rightarrow t [s]');

    figure(4)
    w1=1.53e7; T1=2*pi/w1; Tkon1=n*T1;        % volba frekv, doba periody, doba kon.
    [u1,t1]=gensig('sine',T1,Tkon1,T1/24); % doba periódy, trvanie signálu, vzorkovanie
    lsim (F,u1,t1),grid on                % formatovanie nadpisu grafu fonty: vypis hondoty frekvencie do nadpisu, použite skratiek \it italics, \rm normal, \bf bold
    xlim([0,Tkon1]);
    title ('\omega = 45 rad/s'); 
    ylabel('\rightarrow Amplitúda [dB]'), xlabel('\rightarrow t [s]');

    figure(5)
    w1=1.57e7; T1=2*pi/w1; Tkon1=n*T1;        % volba frekv, doba periody, doba kon.
    [u1,t1]=gensig('sine',T1,Tkon1,T1/24); % doba periódy, trvanie signálu, vzorkovanie
    lsim (F,u1,t1),grid on                % formatovanie nadpisu grafu fonty: vypis hondoty frekvencie do nadpisu, použite skratiek \it italics, \rm normal, \bf bold 
    xlim([0,Tkon1]);
    title ('\omega = 667 rad/s'); 
    ylabel('\rightarrow Amplitúda [dB]'), xlabel('\rightarrow t [s]');

%% State Space
 clear 
 syms s Rs Rl L1 L2 L3 C3 C1 C2 Ur Ui  
 disp('Stavový model v symbolickom tvare:')
 
 A=[-Rs/L1 0 0 -1/L1 -1/L1 0
     0 0 0 0 1/L2 0
     0 0 -Rl/L3 0 1/L3 -1/L3
     1/C1 0 0 0 0 0
     1/C2 -1/C2 -1/C2 0 0 0
     0 0 1/C3 0 0 0]
 b=[1/L1; 0; 0; 0; 0; 0]
 cT=[0 0 Rl 0 0 0]
 d=[0]
 
 disp('paramere obvodu:');
 g1=3.3487; g2=0.7117; g3=g1; del=0.10; f0=2.5e6;
 Rsx=50; Rlx=50;Rx=50;
 %L1x=35.47e-3; C1x=1.428e-6; L2x = 1.432; C2x = 35.38e-9; C3x=3.010e-6; L3x = 16.83e-3;
 L1x=(g1*Rx)/(2*pi*f0*del); L2x=(Rx*del)/(g2*2*pi*f0); L3x=(g3*Rx)/(2*pi*f0*del); 
 C1x=del/(g1*Rx*2*pi*f0); C2x = g2/(Rx*2*pi*f0*del); C3x=del/(g3*Rx*2*pi*f0); % paramere obvodu
 Ui=1;
 Tstep=3e-5; wmin=1.4e7; wmax=1.75e7;   % parametre pre Step a Bode
 color='r'; % farba grafu 
 Rs=Rsx; Rl=Rlx; L1=L1x; L2=L2x; L3=L3x; C1=C1x; C2=C2x; C3=C3x;

 disp('Stavový po dosadení hodnôt parametrov:')
 A=[-Rs/L1 0 0 -1/L1 -1/L1 0
     0 0 0 0 1/L2 0
     0 0 -Rl/L3 0 1/L3 -1/L3
     1/C1 0 0 0 0 0
     1/C2 -1/C2 -1/C2 0 0 0
     0 0 1/C3 0 0 0]
 b=[1/L1; 0; 0; 0; 0; 0]
 cT=[0 0 Rl 0 0 0]
 d=[0]
 
 sys = ss(A,b,cT,d);

 disp('Výpis stavového modelu:')
 printsys(A,b,cT,d);

 disp('Výpis prenosovej funkcie:')
 [nums,dens]=ss2tf(A,b,cT,d)
 Fss=tf(nums/dens(end),dens/dens(end))
 
 disp('Vlastné hodnoty matice A:')
 eig(A)
 
 disp('Póly prenosovej funkcie Fss:')
 p=pole(Fss)

 format short
  
 figure(6)
 subplot(121); 
 step(sys,Tstep,color), grid on,
 title('Prechodová charakteristika (State Space)','FontSize',20,'FontWeight','bold')
 legend('Fss(s)','Orientation','vertical','FontAngle', 'italic','FontSize',16,'FontWeight','bold')
 xlabel('\rightarrow t','FontSize',16,'FontWeight','bold')
 ylabel('\rightarrow U_R/U_{in}','FontSize',16,'FontWeight','bold')
 %LFCh
 subplot(122); bode(sys,{wmin,wmax},color), grid on
 title('Frekvenčná charakteristika (State Space)','fontsize',20,'FontWeight','bold')
 xlabel('\rightarrow Frequency','FontSize',16,'FontWeight','bold')
 ylabel('\rightarrow \phi','FontSize',16,'FontWeight','bold')
 set(findall(gcf,'type','line'),'linewidth',2)

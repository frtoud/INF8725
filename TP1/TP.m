%% Exercice 1

    clear;
    %% Q1
    % *Comment se nomme ce signal?*
    %
    % C'est un sinus cardinal.
    
    figure
    t = linspace(-4,4,1000);
    s = sin(pi*t)./(pi*t);
    plot(t,s);
    title('Exercice 1 - Question 1 : Sinus cardinal');
    xlabel('Temps');
    ylabel('Amplitude');
    legend('signal');

    %% Q2
    figure;
    t = linspace(-2,2,500);
    s1 = sin(t);
    s2 = sin(3*t)./3;
    s3 = sin(5*t)./5;
    plot(t,s1); hold on;
    plot(t, s2); hold on;
    plot(t, s3);
    title('Exercice 1 - Question 2');
    xlabel('Temps');
    ylabel('Amplitude');
    legend('sin(t)', 'sin(3t)/3', 'sin(5t)/5');
    
    %% Q3
    figure;
    t = linspace(-2,2,500);
    s1 = sin(t);
    s2 = sin(3*t)./3;
    s3 = sin(5*t)./5;
    plot(t,s1,'--'); hold on;
    plot(t, s2, '--'); hold on;
    plot(t, s3, '--'); hold on;
    plot(t, s1 + s2 + s3, 'linewidth', 2);
    title('Exercice 1 - Question 3');
    xlabel('Temps');
    ylabel('Amplitude');
    legend('sin(t)', 'sin(3t)/3', 'sin(5t)/5', 'somme');
    
    %% Q4
    figure;
    t = linspace(-2,2,500);
    sinsum = 0;
    for i = 0:50
        sinsum = sinsum + sin(((2*i)+1)*t)./((2*i)+1);
    end
    s50 = (1./2) + (2./pi)* sinsum;
    plot(t, s50);
    title('Exercice 1 - Question 4');
    xlabel('Temps');
    ylabel('Amplitude');
    legend('0.5 + (2/pi)*sum(sin(((2*i)+1)*t)/((2*i)+1))');
    
%% Exercice 2
    
    clear;
    %% Q1
    % *D�terminer th�oriquement les fr�quences pr�sentes dans ce signal.*
    %
    %  165/2 = 82.5 Hz,  6/2 = 3 Hz, 80/2 = 40 Hz
    
    %% Q2
    figure('Position', [100,100,1400,800]);
    titles = {'Fe = 20 Hz','Fe = 75 Hz','Fe = 100 Hz','Fe = 160 Hz','Fe = 180 Hz','Fe = 330 Hz'};
    thz = {linspace(0,1,20),linspace(0,1,75),linspace(0,1,100),linspace(0,1,160),linspace(0,1,180),linspace(0,1,330)};
    for n = 1:length(thz)
        subplot(2,3,n);
        t = thz{n};
        Y = 2*sin(165*pi*t)+13*cos(6*pi*t)-3*cos(80*pi*t);
        plot(t, Y);
        title(titles{n});
        xlabel('Temps');
        ylabel('Amplitude');
        legend('signal');
    end
    
    %% Q3 
    % *Que remarquez-vous par rapport � la forme du signal en lien avec la fr�quence
    % d��chantillonnage?*
    %
    % plus la fr�quence d'�chantillonage est �lev�e, plus on peut voir 
    % les fr�quences plus �lev�es dans le signal num�rique r�sultant 
    
    %% Q4
    % *Lesquelles, parmi ces fr�quences d��chantillonnage, satisfont le th�or�me
    %  de Nyquist-Shannon?*
    %
    % Les fr�quences d'�chantillonage de 100Hz, 160Hz, 180Hz et 330Hz 
    % satisfonts le crit�re de Nyquist-Shannon.
    %
    % *En pratique, quel compromis doit-on faire lors du choix d�une
    % fr�quence d��chantillonnage?*
    %
    % Le compromis � faire est entre l'espace m�moire et la qualit� du
    % signal: une fr�quence d'�chantillonage plus �lev�e signifie, en
    % g�n�ral, une meilleure qualit� de signal num�rique, mais celui-ci
    % prendra plus d'espace m�moire que le m�me signal �chantillon� �
    % une fr�quence d'�chantillonage plus basse.
    
%% Exercice 3

    clear;
    %% Q1
    figure
    fe = 250;
    t = linspace(0,1,fe);
    Y1 = 7*sin(2*pi*10*t);
    n1 = length(Y1);
    Y2 = 4*sin(2*pi*25*t+(pi/3));
    n2 = length(Y2);
    Y3 = 3*cos(2*pi*50*t);
    n3 = length(Y3);
    plot(t, Y1); hold on;
    plot(t, Y2); hold on;
    plot(t, Y3);
    title('Exercice 3 - Question 1');
    xlabel('Temps');
    ylabel('Amplitude');
    legend('Y1(t) = 7 sin(2*pi �10t)', 'Y2(t) = 4 sin(2*pi �25t + pi/3)', 'Y3(t) = 3 cos(2*pi �50t)');
    
    %% Q2
    % *D�terminez graphiquement la p�riode de chacun de ces signaux. Comparez
    % chaque r�sultat avec sa valeur th�orique.*
    %
    % Y1: p�riode d'environ 0.1s, th�oriquement  1/10 = 0.1s, m�me
    % r�sultat.
    %
    % Y2: p�riode d'environ 0.04s, th�oriquement 1/25 = 0.04s, m�me
    % r�sultat.
    %
    % Y3: p�riode d'environ 0.02s, th�oriquement 1/50 = 0.02s, m�me
    % r�sultat.
    
    %% Q3
    % *Graphiquement, quelle semble �tre la fr�quence du signal Z(t)?*
    %
    % graphiquement, la p�riode semble �tre 0.2s, donc la fr�quence 
    % serait de 1/0.2 = 5 Hz. 
    %
    % *D�terminez analytiquement cette fr�quence sachant que la fr�quence 
    % d�un signal composite est �gal au plus grand d�nominateur commun des 
    % fr�quences des signaux qui le composent.*
    %
    % Analytiquement, le plus grand d�nominateur commun entre 10, 25 et 50 
    % (fr�quences des signaux) est 5, donc lafr�quence du signal r�sultant 
    % est 5 Hz.
    figure
    plot(t, Y1+Y2+Y3);
    title('Exercice 3 - Question 3');
    xlabel('Temps');
    ylabel('Amplitude');
    legend('Y1(t) + Y2(t) + Y3(t)');
    
    %% Q4
    % *Que remarquez vous?*
    %
    % on obtient les fr�quences des signaux
    
    Y1fft = fft(Y1);
    Y2fft = fft(Y2);
    Y3fft = fft(Y3);
    
    Yshift1 = fftshift(Y1fft);
    fshift1 = (-n1/2:n1/2-1)*(fe/n1); % zero-centered frequency range
    doubleshift1 = abs(Yshift1)*2/n1; 
    
    Yshift2 = fftshift(Y2fft);
    fshift2 = (-n2/2:n2/2-1)*(fe/n2); % zero-centered frequency range
    doubleshift2 = abs(Yshift2)*2/n2;  
    
    Yshift3 = fftshift(Y3fft);
    fshift3 = (-n3/2:n3/2-1)*(fe/n3); % zero-centered frequency range
    doubleshift3 = abs(Yshift3)*2/n3;  
    
    plot(fshift1, doubleshift1); hold on;
    plot(fshift2, doubleshift2); hold on;
    plot(fshift3, doubleshift3);
    axis([0 length(t)/2 0 inf]);
    title('Exercice 3 - Question 4');
    xlabel('Fr�quence');
    ylabel('Amplitude');
    legend('Transform�e de Fourier de Y1(t) = 7 sin(2*pi �10t)', 'Transform�e de Fourier de Y2(t) = 4 sin(2*pi �25t + pi/3)', 'Transform�e de Fourier de Y3(t) = 3 cos(2*pi �50t)');
    
    %% Q5
    % *Que remarquez vous?*
    %
    % on obtient les fr�quences des signaux simples composant le signal
    % somm�
    figure
    Ysum = Y1 + Y2 + Y3;
    Ysumfft = fft(Ysum);
    Ysumshift = fftshift(Ysumfft);
    nsum = length (Ysum);
    fshiftsum = (-nsum/2:nsum/2-1)*(fe/nsum);
    doubleshiftsum = abs(Ysumshift)*2/nsum;  
    
    plot(fshiftsum, doubleshiftsum);
    axis([0 length(t)/2 0 inf]);
    title('Exercice 3 - Question 5');
    xlabel('Fr�quence');
    ylabel('Amplitude');
    legend('Transform�e de Fourier de la somme des signaux Y1, Y2 et Y3');
    
%% Exercice 4

    clear;
    
    %% Q1 
    % *En �coutant le signal, rep�rez les perturbations de la m�lodie 
    % principale. Pour chaque perturbation, pr�cisez si le signal est haute 
    % ou basse fr�quence.*
    %
    % le signal de perturbation est de haute fr�quence et il y a
    % possiblement une perturbation � basse fr�quence...

    [Data, Fe] = audioread("./audio.wav");
    player = audioplayer(Data,Fe);
    play(player);

    
    %% Q2
    figure;
    Datafft = fft(Data);
    Datafftshift = fftshift(Datafft);
    nData = length(Data);
    fshiftData = (-nData/2:nData/2-1)*(Fe/nData);
    doubleshiftData = abs(Datafftshift)*2/nData;
    
    plot(fshiftData, doubleshiftData);
    title('Exercice 4 - Question 2');
    xlabel('Fr�quence');
    ylabel('Amplitude');
    legend('Transform�e de Fourier du signal audio.wav');
    
    %% Q3
    % *Quelle est la note (do, r�, mi, fa, sol, la ou si) correspondant � 
    % la perturbation � la plus haute fr�quence?*
    %
    % C'est un r�# (de 5e gamme)
    
    %% Q4
    % *Quelle perte d�information observe-t-on sur le signal?*
    %
    % On perd les hautes fr�quences venant du signal.
    %
    % *Comment pourrait-on conserver cette information tout en supprimant 
    % la perturbation?*
    %
    % Pour conserver cette information, on pourrait utiliser un filtre 
    % coupe-bande, qui ne couperait que la fr�quence parasite. Par exemple, 
    % dans le signal utilis�, on perd le son des cymbales.
    
    nyquist = Fe/2;
    cutoff = 1000/nyquist;
    b = fir1(128, cutoff, 'low');
    filteredData = filter(b,1,Data);
    
    player = audioplayer(filteredData,Fe);
    play(player);
    
    %% Q5
    % *Quelles diff�rences observez-vous entre les diff�rents filtres?*
    %
    % Chebyshev a une courbe de coupure plus accentu�e, la coupure est plus
    % raide. Hamming a une courbe un peu moins accentu�e et Blackman est
    % encore moins accentu�e. Avec blackman, les fr�quences basses sont
    % encore pr�sentes, mais sont tout de moins att�nu�es.
    % De plus, Chebyshev a une ondulation bien plus prononc�e apr�s la fin
    % de la coupure que les deux autres m�thodes. Ensuite, Hamming est
    % moins prononc�e et, finalement, Blackman n'ondule presque pas.
    
    nyquist = Fe/2;
    cutoff = 250/nyquist;
    order = 128;
    
    ChebyshevWindow = chebwin(order+1,30);
    HammingWindow = hamming(order+1);
    BlackmanWindow = blackman(order+1);
    
    ChebyshevFilter = fir1(order, cutoff, 'high', ChebyshevWindow);
    HammingFilter = fir1(order, cutoff, 'high', HammingWindow);
    BlackmanFilter = fir1(order, cutoff, 'high', BlackmanWindow);
    
    %% Q6 
    F1 = dfilt.dffir(ChebyshevFilter);
    
    F2 = dfilt.dffir(HammingFilter);
    
    F3 = dfilt.dffir(BlackmanFilter);
    
    freqz([F1 F2 F3]);
    
    legend('Chebyshev', 'Hamming', 'Blackman');
    
    %% Q7
    % *Lorsque vous �coutez les trois signaux, que remarquez-vous?*
    %
    % Le signal parasite de basse fr�quence n'est plus audible.
    %
    % *Pour le filtre passe-haut et en fonction de la fr�quence de coupure
    % utilis�e, quel va �tre le compromis sur la qualit� du signal 
    % restaur�e?*
    %
    % Plus la fr�quence de coupure sera �lev�e, plus les signaux parasites
    % de basse fr�quences seront att�nu�s, mais les basses fr�quences 
    % du signal seront eux aussi att�nu�s.

    CData = filter(ChebyshevFilter,1,filteredData);
    HData = filter(HammingFilter,1,filteredData);
    BData = filter(BlackmanFilter,1,filteredData);
    
    Cplayer = audioplayer(CData, Fe);
    Hplayer = audioplayer(HData, Fe);
    Bplayer = audioplayer(BData, Fe);
    
    play(Bplayer);
    
    %% Q8
    % *Est-ce que les spectres, au niveau des basses fr�quences, 
    % correspondent � ce que vous avez entendu et remarqu�?*
    %
    % Oui, les signaux parasites de haute fr�quence ont �t� att�nu�s 
    % par le filtre passe-bas et les signaux parasites � basse 
    % fr�quence ont �t� att�nu�s par le filtre passe-haut utilis�.
    % (Chebyshev, Hamming ou Blackman.) Les fr�quences restantes ne
    % d�finissent pas tout le signal et sont donc beaucoup plus bas
    % dans le domaine fr�quentiel.
    figure;
    CDatafft = fft(CData);
    CDatafftshift = fftshift(CData);
    doubleshiftCData = abs(CDatafftshift)*2/nData;
    
    plot(fshiftData, doubleshiftCData);
    title('Exercice 4 - Question 8: Chebyshev');
    xlabel('Fr�quence');
    ylabel('Amplitude');
    ylim([0 1]);
    legend('Transform�e de Fourier du signal audio.wav filtr� avec passe-haut Chebyshev');
    
    figure;
    HDatafft = fft(HData);
    HDatafftshift = fftshift(HData);
    doubleshiftHData = abs(HDatafftshift)*2/nData;
    
    plot(fshiftData, doubleshiftHData);
    title('Exercice 4 - Question 8: Hamming');
    xlabel('Fr�quence');
    ylabel('Amplitude');
    ylim([0 1]);
    legend('Transform�e de Fourier du signal audio.wav filtr� avec passe-haut Hamming');
    
    figure;
    BDatafft = fft(BData);
    BDatafftshift = fftshift(BData);
    doubleshiftBData = abs(BDatafftshift)*2/nData;
    
    plot(fshiftData, doubleshiftBData);
    title('Exercice 4 - Question 8: Blackman');
    xlabel('Fr�quence');
    ylabel('Amplitude');
    ylim([0 1]);
    legend('Transform�e de Fourier du signal audio.wav filtr� avec passe-haut Blackman');

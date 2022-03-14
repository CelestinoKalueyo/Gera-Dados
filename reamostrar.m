%Algoritmo para extra��o de dados nos sinais de tens�o e corrente
%Apos a extra��o dos sinais, os mesmos sinais ser�o filtrados atrav�s do
%filtro passa baixa de Butterworth coom a finalidade de retirar as
%impurezas dos sinais e dos dados
function [sinalreamostrado, tres] = reamostrar(signal,t)

    fnyquist=(64*60)/2;
    fstop=1900;
    fpass=90;

%Constr�i filtro passa-baixa de Butterworth
    wp = fpass/fnyquist;
    ws = fstop/fnyquist; 
    [filter_order,wn] = buttord(wp,ws,3,40); 
    [b,a] = butter(filter_order,wn); 

%Passa os sinais pelo filtro
	signalfiltered = filter(b,a,signal);

%Reamostragem dos sinais:
    tmin = 0.05;
    tmax = 0.066666;
    tres = tmin:(1/60)/64:tmax;

    ts = timeseries(signalfiltered,t,'Name','signalfiltered');
    ts = transpose(ts);
    res_ts = resample(ts,tres);
    sinalreamostrado = res_ts.Data;
    
end
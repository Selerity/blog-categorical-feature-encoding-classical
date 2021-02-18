%macro frequency_encoding(dataset, var);
  proc sql noprint;
    create table freq as 
    select distinct(&var) as values, count(&var) as number
    from &dataset 
    group by Values ;

    create table new as 
    select *, round(freq.number/count(&var),00.01) As freq_encode 
    from &dataset 
    left join freq 
      on &var=freq.values;
  quit;

  data new(drop=values number);
    set new;
  run;

%mend;

* Example of Frequency Encoding
* %frequency_encoding(sashelp.cars,origin);

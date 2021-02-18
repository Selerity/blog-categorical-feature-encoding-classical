%macro binary_encoding(dataset,var);

  proc sql noprint;
    select distinct(&var)
    into:val1-
    from &dataset;

    select count(distinct(&var)) 
    into:mx
    from &dataset;
  quit;

  data new;
    set &dataset;
  %do i=1 %to &mx;
    if &var="&&&val&i" then new=&i;
  %end;
    format new binary.;
  run;

%mend;

* Example of Binary Encoding
* %binary_Encoding(sashelp.cars, make);

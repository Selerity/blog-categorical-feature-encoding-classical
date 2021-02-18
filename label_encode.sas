%macro label_encode(dataset,var);
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
  run;
%mend;

* Example Of Label Encode
* %label_encode(sashelp.cars,origin);

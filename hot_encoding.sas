%macro hot_encoding(data,var);
  proc sql noprint;
    select distinct &var 
	  into:val1-
    from &data;

    select count(distinct(&var))
	  into:len
    from &data;
  quit;

  data encoded_data;
    set &data;
  %do i=1 %to &len;
	  if &var="&&&val&i" then %sysfunc(compress(&&&val&i,'$ - /'))=1 ;
	  else  %sysfunc(compress(&&&val&i,'$ - /'))=0;
  %end;
  run;
%mend;

* Example of One Hot Encoding
* %hot_Encoding(sashelp.cars, origin);

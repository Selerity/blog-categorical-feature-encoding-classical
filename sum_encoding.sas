%macro sum_encoding(data,var);
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

  data sum_encode;
    set encoded_data;
    if %sysfunc(compress(&&&val&Len,'$ - /'))=1 then do;
	%do x=1 %to %eval(&len-1);
		  %sysfunc(compress(&&&val&x,'$ - /'))=-1;
	%end;
    end;
    drop %sysfunc(compress(&&&val&Len,'$ - /'));
  run;

%mend;

* Examples of sum_encoding
* %sum_encode(sashelp.cars,origin);

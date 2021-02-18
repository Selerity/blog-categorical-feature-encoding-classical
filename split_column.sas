%macro split_column(data,var);

  data try;
    set &data;
    cha=put(&var, binary.);
  run;

  proc sql noprint;
    select max(length(cha)) into :ln from try ;
  quit;

  data &data;
    set try;
  %do i=1 %to &ln;
	  c_&i=substr(cha,&i,1);
  %end;
  run;

%mend;

* Example of Column Split
* %split_column(work.new,new);

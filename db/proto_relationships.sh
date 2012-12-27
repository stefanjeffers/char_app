select * from formulas where base='085' and offset='006' ;

select * from pinnames join formulas on pinnames.base=formulas.base and pinnames.offset=formulas.offset where pinnames.base='085' and pinnames.offset='006' ; 


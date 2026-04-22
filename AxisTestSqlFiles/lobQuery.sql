select r.gifdata, r2.gifdata l_gifdata, l.longdata, c.clobdata, b.blobdata
from   raw_example r 
   ,   longraw_example r2 
   ,   long_example    l
   ,   clob_example    c
   ,   blob_example    b
where r.name  = 'LESLIE2'
and   r2.name = 'LESLIE2'
and   l.name = 'LESLIE2'
and   b.name = 'LESLIE2'
and   c.name = 'LESLIE2'

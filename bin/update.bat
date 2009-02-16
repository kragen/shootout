

set sroot=I:\temp\alioth\shootout\website\websites\

set droot="I:\Abyss Web Server\htdocs\websites\"


del /q %droot%debian\code\*  
del /q %droot%debian\data\*
del /q %droot%debian\version\*

del /q %droot%gp4\code\*
del /q %droot%gp4\data\*
del /q %droot%gp4\version\*

del /q %droot%u32\code\*
del /q %droot%u32\data\*
del /q %droot%u32\version\*

del /q %droot%u32q\code\*
del /q %droot%u32q\data\*
del /q %droot%u32q\version\*

del /q %droot%u64\code\*
del /q %droot%u64\data\*
del /q %droot%u64\version\*

del /q %droot%u64q\code\*
del /q %droot%u64q\data\*
del /q %droot%u64q\version\*


copy %sroot%debian\code\* %droot%debian\code
copy %sroot%debian\data\* %droot%debian\data 
copy %sroot%debian\version\* %droot%debian\version

copy %sroot%gp4\code\* %droot%gp4\code 
copy %sroot%gp4\data\* %droot%gp4\data 
copy %sroot%gp4\version\* %droot%gp4\version 

copy %sroot%u32\code\* %droot%u32\code
copy %sroot%u32\data\* %droot%u32\data 
copy %sroot%u32\version\* %droot%u32\version 

copy %sroot%u32q\code\* %droot%u32q\code
copy %sroot%u32q\data\* %droot%u32q\data 
copy %sroot%u32q\version\* %droot%u32q\version

copy %sroot%u64\code\* %droot%u64\code
copy %sroot%u64\data\* %droot%u64\data 
copy %sroot%u64\version\* %droot%u64\version 

copy %sroot%u64q\code\* %droot%u64q\code
copy %sroot%u64q\data\* %droot%u64q\data 
copy %sroot%u64q\version\* %droot%u64q\version

copy %sroot%debian\include.csv %droot%debian
copy %sroot%gp4\include.csv %droot%gp4
copy %sroot%u32\include.csv %droot%u32
copy %sroot%u32q\include.csv %droot%u32q
copy %sroot%u64\include.csv %droot%u64
copy %sroot%u64q\include.csv %droot%u64q




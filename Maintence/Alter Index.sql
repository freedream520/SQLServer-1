
/*---------------------VERIFICACAO DE REGISTROS FRAGMENTADOS---------------------*/

USE @DATABASE
GO

SELECT  OBJ.OBJECT_ID AS OBJECTID ,
        OBJ.NAME AS TABELA ,
        ST.INDEX_ID AS INDEXID ,
        ST.PARTITION_NUMBER AS PARTITIONNUM ,
        ST.AVG_FRAGMENTATION_IN_PERCENT AS FRAG
FROM    SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(), NULL, NULL, NULL,
                                                    'LIMITED') ST
        JOIN SYS.OBJECTS OBJ ON OBJ.OBJECT_ID = ST.OBJECT_ID
WHERE   AVG_FRAGMENTATION_IN_PERCENT >= 50.0
        AND INDEX_ID > 0
ORDER BY FRAG DESC;

/*-----------------COMANDO PARA PEGAR TODAS AS TABELAS DO BANCO-----------------*/

SELECT  'ALTER INDEX ALL ON DBO.' + TAB.NAME + ' REBUILD;'
FROM    SYS.TABLES TAB
WHERE   TYPE = 'U'
ORDER BY TAB.NAME;

OUTPUT:
ALTER INDEX ALL ON DBO.NOMETABELA REBUILD;

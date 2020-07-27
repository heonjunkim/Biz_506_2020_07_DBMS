SELECT status,enabled, t.name,d.name
	     FROM  V$DATAFILE d, V$TABLESPACE t
	     WHERE t.ts#=d.ts#;

CREATE USER grade2 IDENTIFIED BY grade2
DEFAULT TABLESPACE gradeTS;
GRANT DBA TO grade2;


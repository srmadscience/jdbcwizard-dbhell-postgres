SELECT * /* PARAM_PROD_NAME */
FROM all_directories a
ORDER BY DECODE (directory_name, 'MEDIA_DIR',2,'LOG_FILE_DIR',2,'DATA_FILE_DIR',2,'DM_PMML_DIR',2,1), directory_name
/

